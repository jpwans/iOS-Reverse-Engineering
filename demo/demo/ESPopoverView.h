//
//  ESPopoverView.h
//  CareU
//
//  Created by jiangqin on 16/3/5.
//  Copyright © 2016年 深圳创达云睿智能科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESPopoverView : UIView <UIGestureRecognizerDelegate>


@property (strong, readonly, nonatomic) UIView *contentView;

+ (instancetype)showWithCompletion:(void (^)(void))completion;
+ (instancetype)showInView:(UIView *)view withCompletion:(void (^)(void))completion;
+ (instancetype)popoverViewForView:(UIView *)view;

+ (void)dismissWithCompletion:(void (^)(void))completion;
+ (void)dismissInView:(UIView *)view withCompletion:(void (^)(void))completion;

- (void)showInView:(UIView *)view withCompletion:(void (^)(void))completion;
- (void)dismissWithCompletion:(void (^)(void))completion;

@end
