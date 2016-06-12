//
//  LocationManagerDelegate.m
//  GeoLocation
//
//  Created by Fazle Rab on 10/14/15.
//  Copyright © 2015 Fazle Rab. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "LocationManagerDelegate.h"

@interface LocationManagerDelegate () 

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation LocationManagerDelegate

- (instancetype) init {
    self = [super init];
    
    BOOL enabled = [CLLocationManager locationServicesEnabled];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    NSLog(@"Location Service Enabled: %d\nAuthorizationStatus: %d", enabled, status);

    if (self && enabled
        && status != kCLAuthorizationStatusDenied
        && status != kCLAuthorizationStatusRestricted) {
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        if (status == kCLAuthorizationStatusNotDetermined) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    else {
        self = nil;
    }
    
    return self;
}

- (void) setup {
    NSLog(@"setup");
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"didChangeAuthorizationStatus: %d", status);
    if (status != kCLAuthorizationStatusNotDetermined) {
        [self setup];
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *loc = [locations lastObject];
    NSLog(@"Latitude: %f\n",loc.coordinate.latitude);
    NSLog(@"Longitude: %f\n\n",loc.coordinate.longitude);
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error.localizedDescription);
}

@end
