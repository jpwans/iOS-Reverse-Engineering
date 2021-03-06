//
//  UIDevice2.h
//  demo
//
//  Created by Pellet Mo on 16/6/3.
//
//


#import <UIKit/UIDevice.h>
//#import "UIKit-Structs.h"
#import <Foundation/NSObject.h>
//#import <Availability2.h>

@class NSString;

@interface UIDevice ()
+(int)currentDeviceOrientationAllowingAmbiguous:(BOOL)ambiguous;
-(id)buildVersion;
-(void)setOrientation:(int)orientation;
-(void)beginGeneratingDeviceOrientationNotifications;
-(void)endGeneratingDeviceOrientationNotifications;
-(void)setOrientation:(int)orientation animated:(BOOL)animated __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_3_2);
@end

@interface UIDevice (UIDevicePrivate)
@property(readonly, retain, nonatomic) NSString* buildVersion;
@property(assign, nonatomic) int orientation;
-(void)_setProximityState:(BOOL)state;
-(void)_setBatteryState:(int)state;
-(void)_setBatteryLevel:(float)level;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
-(BOOL)isWildcat;
-(void)setIsWildcat:(BOOL)wildcat;
#endif
@end

@interface UIDevice (Private)
-(void)_enableDeviceOrientationEvents:(BOOL)events;
@end