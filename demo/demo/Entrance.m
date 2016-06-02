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

@end
