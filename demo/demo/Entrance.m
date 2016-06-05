//
//  Entrance.m
//  demo
//
//  Created by jiangqin on 16/6/2.
//
//

#import "Entrance.h"
#import <UIKit/UIKit.h>
#import <dlfcn.h>
#import "CustomWindow.h"
#import "objcipc.h"
#import <substrate.h>
#import "Define.h"
#import "ALApplicationList.h"
#import "UIDevice2.h"
@interface LSApplicationProxy
+(id)applicationProxyForIdentifier:(id)arg1;
-(NSUUID*)deviceIdentifierForVendor;
@end


@implementation Entrance
+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerNotifications];
    }
    return self;
}



-(void)registerNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeKeyWindow:) name:UIWindowDidBecomeKeyNotification object:nil];
    [self setup];
}

- (void)didBecomeKeyWindow:(NSNotification *)noti
{
    
    if (self.isLoaded == NO) {
        NSLog(@"add window");
        dispatch_async(dispatch_get_main_queue(), ^{
//            CustomWindow *window =
//            [[CustomWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//            [window setWindowLevel:1];
//            [window setHidden:NO];
            self.loaded   = YES;
        });
    }
}
-(void)setup{
//    serviceConfig = [WatchDogConfig objectForKey:@"serviceConfig"];
//    
//    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:@"WD.ServiceIP.Get"
//                                                         handler:^NSDictionary *(NSDictionary *message) {
//                                                             return serviceConfig;
//                                                         }];
//    NSDictionary *dict = @{@"key":@"value",@"key2":@"value2"};
//    else if(buttonIndex ==2){
//        system("reboot");
//    }
//    else if(buttonIndex ==3){
//        id SpringBoard = [UIApplication sharedApplication];
//        [SpringBoard powerDown];
    
    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:LogOut handler:^NSDictionary *(NSDictionary * message) {
         system("killall -9 SpringBoard");
        return nil;
    }];
    
    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:Reboot handler:^NSDictionary *(NSDictionary * message) {
        system("reboot");
        return nil;
    }];
    
    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:PowerDown handler:^NSDictionary *(NSDictionary * message) {
        id SpringBoard = [UIApplication sharedApplication];
        [SpringBoard powerDown];
        return nil;
    }];

    
    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:FirstNofi handler:^NSDictionary *(NSDictionary * message) {
        NSArray *sortedDisplayIdentifiers;
        NSDictionary *applications = [[ALApplicationList sharedApplicationList] applicationsFilteredUsingPredicate:[NSPredicate predicateWithFormat:@"isSystemApplication = TRUE"]
                                                                                                  onlyVisible:YES titleSortedIdentifiers:&sortedDisplayIdentifiers];
        enum {
            ALApplicationIconSizeSmall = 29,
            ALApplicationIconSizeLarge = 59
        };
//        NSString *displayIdentifier = [displayIdentifiers objectAtIndex:idx];
//        UIImage *icon = [apps iconOfSize:ALApplicationIconSizeSmall forDisplayIdentifier:displayIdentifier];
        NSDictionary *response = @{@"Identifiers":sortedDisplayIdentifiers,@"applications":applications};
        return response;
    }];
    
    
    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:SecondNofi handler:^NSDictionary *(NSDictionary * message) {
        NSString* realIdentifierForVendor =
        [[NSClassFromString(@"LSApplicationProxy") applicationProxyForIdentifier:[NSBundle mainBundle].bundleIdentifier] deviceIdentifierForVendor].UUIDString;
        return @{@"realIdentifierForVendor":realIdentifierForVendor};
    }];
    
    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:ThirdNofi handler:^NSDictionary *(NSDictionary * message) {
        NSLog(@"tweak:%@",message);
        [[UIDevice  currentDevice] _setBatteryLevel:0.3];
        NSString *ver = [[UIDevice currentDevice] buildVersion];
        [[UIDevice currentDevice ]playInputClick];
        return @{@"key":ver};
    }];
}


@end
