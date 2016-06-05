//
//  ViewController.m
//  SimpleTools
//
//  Created by jiangqin on 16/6/2.
//
//

#import "ViewController.h"
#import "objcipc.h"
#import "Define.h"
#include "OpenUDID.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* openUDID = [OpenUDID value];
    NSLog(@"openUDID:%@",openUDID);
}

- (IBAction)firstAction:(id)sender {
    [OBJCIPC sendMessageToSpringBoardWithMessageName:FirstNofi dictionary:nil replyHandler:^(NSDictionary *response) {
        NSLog(@"response:%@",response);
    }];
}
- (IBAction)secondAction:(id)sender {
    [OBJCIPC sendMessageToSpringBoardWithMessageName:SecondNofi dictionary:nil replyHandler:^(NSDictionary *response) {
        NSLog(@"response:%@",response);
    }];
}
- (IBAction)thirdAction:(id)sender {
    NSString* openUDID = [OpenUDID value];
    NSDictionary *dic = @{@"key":openUDID};
    [OBJCIPC sendMessageToSpringBoardWithMessageName:ThirdNofi dictionary:dic replyHandler:^(NSDictionary *response) {
        NSLog(@"response:%@",response);
    }];
}

- (IBAction)logOutAction:(id)sender {
        [OBJCIPC sendMessageToSpringBoardWithMessageName:LogOut dictionary:nil replyHandler:^(NSDictionary *response) {
            NSLog(@"logOut");
        }];
}

- (IBAction)rebootAction:(id)sender {
    [OBJCIPC sendMessageToSpringBoardWithMessageName:Reboot dictionary:nil replyHandler:^(NSDictionary *response) {
        NSLog(@"reboot");
    }];
}
- (IBAction)powerDownAction:(id)sender {
    [OBJCIPC sendMessageToSpringBoardWithMessageName:PowerDown dictionary:nil replyHandler:^(NSDictionary *response) {
        NSLog(@"powerDown");
    }];
}

@end
