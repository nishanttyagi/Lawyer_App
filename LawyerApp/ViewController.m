//
//  ViewController.m
//  LawyerApp
//
//  Created by Nishant Tyagi on 11/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    int radius = 1000;
    core_longitude = 151.1957362;
    core_latitude = -33.8670522;

    self.myLawyerData = [NSMutableArray new];
    
    NSString *type  = @"lawyer";
    NSString *apiURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%d&types=%@&sensor=true&key=AIzaSyAj9U6SK4yxy0eEry0_KtiFyY-lCp-mOXU",core_latitude,core_longitude,radius,type];
    
    NSURL *url = [NSURL URLWithString:apiURL];
    
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error = [[NSError alloc] init];
    NSMutableDictionary *myLawyerDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    
    
    NSMutableArray *resultsMA = [myLawyerDict objectForKey:@"results"];
    
    
    for (int i = 0; i < [resultsMA count]; i++) {
        
        NSMutableDictionary *dict = [[[resultsMA objectAtIndex:i] objectForKey:@"geometry"] objectForKey:@"location"];
        NSString *latitude = [dict objectForKey:@"lat"];
        NSString *longitude = [dict objectForKey:@"lng"];
        NSString *name = [[resultsMA objectAtIndex:i] objectForKey:@"name"];
        NSString *iconLink = [[resultsMA objectAtIndex:i] objectForKey:@"icon"];
        NSString *address = [[resultsMA objectAtIndex:i] objectForKey:@"vicinity"];

        NSDictionary *tempDict = @{@"lat": latitude, @"lng":longitude,@"name":name,@"iconLink":iconLink,@"address":address};
        
        NSLog(@"lat : %@, %@",latitude,longitude);
        
        [self.myLawyerData addObject:tempDict];
    }
    
    NSLog(@"myLawyerData  : %@",self.myLawyerData);
    
    [self loadingMap];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadingMap
{
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1f, 0.1f);
    
    
    MKCoordinateRegion region = MKCoordinateRegionMake(locationCordinate, span);
    region.center.latitude = core_latitude;
    region.center.longitude = core_longitude;
    
    [self.map setRegion:region];
    
    
    for (int i =0 ; i < [self.myLawyerData count]; i++)
    {
        NSMutableDictionary *dict = [self.myLawyerData objectAtIndex:i];

        float latitude = [[dict objectForKey:@"lat"] floatValue];
        float longitude = [[dict objectForKey:@"lng"] floatValue];

        CLLocationCoordinate2D cordinate = CLLocationCoordinate2DMake(latitude, longitude);

        MyAnnotation *ann = [[MyAnnotation alloc] initWithName:[dict objectForKey:@"name"] address:[dict objectForKey:@"address"] coordinate:cordinate andIconPathIs:[dict objectForKey:@"iconLink"]];
        
        [self.map addAnnotation:ann];
    }
    
    NSLog(@"annotations : %@",self.map.annotations);
    
}

#pragma mark -
#pragma mark MKMapView Delegates & Datasources -
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    MKPinAnnotationView *pinView = nil;
    
    static NSString *cellIdentifier = @"pinIdentifier";

    MyAnnotation *ann = (MyAnnotation *)annotation;
    NSLog(@"Link : %@",ann.iconPath);
    
    pinView = (MKPinAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:cellIdentifier];
    
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:cellIdentifier];
        
        pinView.canShowCallout = YES;
        pinView.opaque = NO;
        pinView.enabled = YES;
        pinView.canShowCallout = YES;
        pinView.rightCalloutAccessoryView=nil;
        pinView.animatesDrop = YES;
        pinView.pinColor = MKPinAnnotationColorGreen;
        pinView.tag = 111;
        
    }
    
    UIImage *image = [UIImage imageWithData:[NSData  dataWithContentsOfURL:[NSURL URLWithString:ann.iconPath]]];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    [imgView setImage:image];
    
    [pinView addSubview:imgView];
    
    
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(-10, 2, 14, 21)];
    [rightBtn setImage:[UIImage imageNamed:@"rightOrangeArrow"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    pinView.rightCalloutAccessoryView = rightBtn;
    
    return pinView;
    
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
    NSLog(@"didSelectAnnotationView INIT");
    
    MyAnnotation *ann = (MyAnnotation*) view.annotation;
    
    NSLog(@"ann : %@ ::: %@",ann.title, ann.address);
    
    
    NSLog(@"didSelectAnnotationView LATE");
    
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"controle tapped : %@",control);
    for (id currentAnnotation in self.map.annotations) {
        if ([currentAnnotation isKindOfClass:[MyAnnotation class]]) {
            [self.map deselectAnnotation:currentAnnotation animated:YES];
        }
    }
}


-(IBAction)rightBtnClicked:(UIButton *)sender
{
    
}

@end
