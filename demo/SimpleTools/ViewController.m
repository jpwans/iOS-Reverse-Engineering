//
//  ViewController.m
//  SimpleTools
//
//  Created by jiangqin on 16/6/2.
//
//

#import "ViewController.h"
#import "objcipc.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)logOutAction:(id)sender {
        [OBJCIPC sendMessageToSpringBoardWithMessageName:@"logout" dictionary:nil replyHandler:^(NSDictionary *response) {
            NSLog(@"logOut");
        }];
}

- (IBAction)rebootAction:(id)sender {
    [OBJCIPC sendMessageToSpringBoardWithMessageName:@"reboot" dictionary:nil replyHandler:^(NSDictionary *response) {
        NSLog(@"reboot");
    }];
}
- (IBAction)powerDownAction:(id)sender {
    [OBJCIPC sendMessageToSpringBoardWithMessageName:@"powerDown" dictionary:nil replyHandler:^(NSDictionary *response) {
        NSLog(@"powerDown");
    }];
}

@end
