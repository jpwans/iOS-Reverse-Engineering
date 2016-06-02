//
//  UIResponder+AMExample.h
//  demo
//
//  Created by Pellet Mo on 16/6/3.
//
//

#import <UIKit/UIKit.h>

@interface UIResponder (AMExample)
- (BOOL)canPerformAction; //(we will check here if the selected text is longer than 0 characters)
- (void)performMyAction; //this method will do the actual 'work' of our Plugin
@end
