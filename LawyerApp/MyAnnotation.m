//
//  MyAnnotation.m
//  MapExample
//
//  Created by Nishant Tyagi on 11/9/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;
@synthesize iconPath = _iconPath;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate andIconPathIs:(NSString *)iconPath
{
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        _iconPath = iconPath;
    }
    return self;
}

-(NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _name;
}

-(NSString *)subtitle {
    return _address;
}



@end
