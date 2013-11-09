//
//  ViewController.h
//  LawyerApp
//
//  Created by Nishant Tyagi on 11/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
@interface ViewController : UIViewController<MKMapViewDelegate>
{
    
}
@property (nonatomic , strong) IBOutlet MKMapView *map;

@property (nonatomic , strong) NSMutableArray *myLawyerData;
@end
