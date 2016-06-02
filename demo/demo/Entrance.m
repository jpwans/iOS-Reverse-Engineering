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
            [[CustomWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
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
    
    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:@"logout" handler:^NSDictionary *(NSDictionary * message) {
         system("killall -9 SpringBoard");
        return nil;
    }];
    
    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:@"reboot" handler:^NSDictionary *(NSDictionary * message) {
        system("reboot");
        return nil;
    }];
    
    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:@"powerDown" handler:^NSDictionary *(NSDictionary * message) {
        id SpringBoard = [UIApplication sharedApplication];
        [SpringBoard powerDown];
        return nil;
    }];

}


@end
