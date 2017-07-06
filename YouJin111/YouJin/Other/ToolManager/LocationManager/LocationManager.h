//
//  LocationManager.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/7.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate;


@interface LocationManager : NSObject

@property (strong, nonatomic) CLLocation *current;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) id<LocationManagerDelegate> delegate;
@property (nonatomic, assign) BOOL hasCalledUpdateLocation;
@property (nonatomic, assign) BOOL hasCalledSendFailMessage;
+ (instancetype)sharedLocationManagerWithDelegate:(id<LocationManagerDelegate>)delegate;
- (void)start;
- (void)stop;

@end

@protocol LocationManagerDelegate <NSObject>

@optional
- (void)locationManagerUpdateLocation:(LocationManager *)manager;
- (void)locationManager:(LocationManager *)manager refuseToUsePositioningSystem:(NSString *)message;
- (void)locationManager:(LocationManager *)manager locateFailure:(NSString *)message;

@end
