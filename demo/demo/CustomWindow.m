//
//  CustomWindow.m
//  demo
//
//  Created by jiangqin on 16/6/2.
//
//

#import "CustomWindow.h"
@interface CustomWindow()<UIAlertViewDelegate>
@property (strong ,nonatomic) UIViewController *vc;
@property (assign ,nonatomic, getter=isShow) BOOL show;
@end

@implementation CustomWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}


- (void)initialize{
    self.vc = [((UIViewController *)[NSClassFromString(@"MainViewController") alloc]) init];
    self.rootViewController   = self.vc;
    self.backgroundColor   = [UIColor clearColor];
    [self setWindowLevel:1];
    [self setHidden:NO];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    self.vc.view.frame = CGRectMake(0, 0, w, 40);
//    self.vc.view.center = self.center;
//        self.vc.view.backgroundColor = [UIColor orangeColor];
    
    //    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    //    tag.numberOfTapsRequired = 1;
    //    [self.vc.view addGestureRecognizer:tag];
    //
    //    tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    //    tag.numberOfTapsRequired = 3;
    //    tag.numberOfTouchesRequired = 3;
    //    [self.vc.view addGestureRecognizer:tag];
    
}
-(void)tap:(UITapGestureRecognizer *)tap{
    if (tap.view.alpha==1) {
        tap.view.alpha=0.2;
    }
    else{
        tap.view.alpha = 1;
    }
}

-(void)tapHandle:(UITapGestureRecognizer *)tap{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您想要干什么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注销",@"重启",@"关机", nil];
    [alertView show];
    self.show = YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        system("killall -9 SpringBoard");
    }
    else if(buttonIndex ==2){
        system("reboot");
    }
    else if(buttonIndex ==3){
        id SpringBoard = [UIApplication sharedApplication];
        [SpringBoard powerDown];
    }
    else{
        
    }
    self.show = NO;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"view:%@ event:%@",view,event);
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:view];
    
    CGPoint vcPoint = [self.vc.view convertPoint:point fromView:self];
    
    if ([self.vc.view  pointInside:vcPoint withEvent:event]) {
        if (!self.isShow) {
             [self tapHandle:nil];
        }
    }
    
    
    NSLog(@"view.hidden:%d touchPoint:%@",view.hidden,NSStringFromCGPoint(touchPoint));
    
    //3.如果touch到了controller.view 就返回nil把事件传递到下层window.refer:http://stackoverflow.com/questions/14740921/passing-touches-between-stacked-uiwindows
    if (view == self.rootViewController.view || view.hidden == YES) {
        return view;
    }
    return nil;
}


@end
