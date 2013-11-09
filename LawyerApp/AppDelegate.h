//
//  AppDelegate.h
//  LawyerApp
//
//  Created by Nishant Tyagi on 11/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;


-(void)initializeLocationManager;

@end
