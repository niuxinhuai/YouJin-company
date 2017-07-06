//
//  LocationManager.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/7.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager()<CLLocationManagerDelegate>

//@property (nonatomic, assign)

@property (strong ,nonatomic) CLLocationManager *locationManager;

@end

@implementation LocationManager


+ (instancetype)sharedLocationManagerWithDelegate:(id<LocationManagerDelegate>)delegate {
    LocationManager *locationManager = [[LocationManager alloc] init];
    locationManager.delegate = delegate;
    return locationManager;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self start];
    }
    return self;
}


- (void)start {
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)stop {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - <CLLocationManagerDelegate>

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.current = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:self.current completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.city = placeMark.locality;
            if (!self.city || self.city.length == 0) {
                self.city = @"无法定位当前城市";
            }else {
                self.city = [self.city substringToIndex:self.city.length - 1];
            }
            if (!self.hasCalledUpdateLocation && [self.delegate respondsToSelector:@selector(locationManagerUpdateLocation:)]) {
                [self.delegate locationManagerUpdateLocation:self];
            }
            self.hasCalledUpdateLocation = YES;
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(locationManager:refuseToUsePositioningSystem:)]) {
            [self.delegate locationManager:self refuseToUsePositioningSystem:@"未开启定位"];
        }
    }
    if ([error code] == kCLErrorLocationUnknown) {
        if (!self.hasCalledSendFailMessage && [self.delegate respondsToSelector:@selector(locationManager:locateFailure:)]) {
            [self.delegate locationManager:self locateFailure:@"无法获取位置信息"];
        }
        self.hasCalledSendFailMessage = YES;
    }
}

#pragma mark - reget

- (CLLocationManager*)locationManager {
    if(_locationManager ==  nil) {
        _locationManager    =   [[CLLocationManager  alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 50;
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_8_0
        [_locationManager requestAlwaysAuthorization];
#endif
    }
    return _locationManager;
}

@end
