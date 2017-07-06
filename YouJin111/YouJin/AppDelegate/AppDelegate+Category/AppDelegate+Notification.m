//
//  AppDelegate+Notification.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/5.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "AppDelegate+Notification.h"
#import <QYSDK.h>

@implementation AppDelegate (Notification)



- (void)configureNotification {
    [[QYSDK sharedSDK] registerAppId:QYAppKey appName:@"有金"];
    if ([[UIApplication sharedApplication]
         respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge
        | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}


- (void) setBadgeNumberWhenEnterBackground {
    NSInteger count = [[[QYSDK sharedSDK] conversationManager] allUnreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[QYSDK sharedSDK] updateApnsToken:deviceToken];
}


@end
