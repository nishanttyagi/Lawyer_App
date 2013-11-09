//
//  Config.h
//  Calculator
//
//  Created by Nishant Tyagi on 11/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Config : NSObject
{

}

extern CLLocationCoordinate2D locationCordinate;
extern CLLocationManager *locationManager;

extern float core_latitude;
extern float core_longitude;

@end
