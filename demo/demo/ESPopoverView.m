//
//  ESPopoverView.m
//  CareU
//
//  Created by jiangqin on 16/3/5.
//  Copyright © 2016年 深圳创达云睿智能科技有限公司. All rights reserved.
//

#import "ESPopoverView.h"


@implementation ESPopoverView

+ (instancetype)searchPopoverViewForView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[ESPopoverView class]]) {
            return (__kindof ESPopoverView *)subView;
        }
    }
    
    return nil;
}

#pragma mark - Public Class Methods

+ (instancetype)popoverViewForView:(UIView *)view {
    return [[[self class] alloc] initWithFrame:view.bounds];
}

+ (instancetype)showWithCompletion:(void (^)(void))completion {
    return [self showInView:nil withCompletion:completion];
}

+ (instancetype)showInView:(UIView *)view withCompletion:(void (^)(void))completion {
    ESPopoverView *popoverView = [self popoverViewForView:view];
    [popoverView showInView:view withCompletion:completion];
    return popoverView;
}

+ (void)dismissWithCompletion:(void (^)(void))completion {
    return [self dismissInView:nil withCompletion:completion];
}

+ (void)dismissInView:(UIView *)view withCompletion:(void (^)(void))completion {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    ESPopoverView *popoverView = [self searchPopoverViewForView:view];
    [popoverView dismissWithCompletion:completion];
}

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    _contentView = [[UIView alloc] initWithFrame:self.bounds];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:_contentView];

}


#pragma mark - Public

- (void)showInView:(UIView *)view withCompletion:(void (^)(void))completion {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    self.frame = view.bounds;
    [view addSubview:self];
    
    _contentView.alpha = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         _contentView.alpha = 1;
                     } completion:^(BOOL finished) {
                         if (completion) {
                             completion();
                         }
                     }];
}

- (void)dismissWithCompletion:(void (^)(void))completion {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         _contentView.alpha = 0;
                     } completion:^(BOOL finished) {
                         if (completion) {
                             completion();
                         }
                         
                         [self removeFromSuperview];
                     }];
}

@end
