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
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 300, 300);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.center = self.view.center;
    button.backgroundColor = [ UIColor grayColor];
}


-(void) setUp {
    [OBJCIPC sendMessageToSpringBoardWithMessageName:@"WD.ServiceIP.Get"
                                          dictionary:@{@"key": @"value"}
                                        replyHandler:^(NSDictionary *response) {
                                            NSLog(@"response:%@",response);
                                        }];
    
//    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:@"logout" handler:^NSDictionary *(NSDictionary * message) {
//        system("killall -9 SpringBoard");
//        return nil;
//    }];
//    
//    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:@"reboot" handler:^NSDictionary *(NSDictionary * message) {
//        system("reboot");
//        return nil;
//    }];
//    
//    [OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:@"powerDown" handler:^NSDictionary *(NSDictionary * message) {
//        id SpringBoard = [UIApplication sharedApplication];
//        [SpringBoard powerDown];
//        return nil;
//    }];
//OBJCIPC sendMessageToSpringBoardWithMessageName:<#(NSString *)#> dictionary:<#(NSDictionary *)#>
}



@end
