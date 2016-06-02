//
//  UIResponder+AMExample.m
//  demo
//
//  Created by Pellet Mo on 16/6/3.
//
//

#import "UIResponder+AMExample.h"

@implementation UIResponder (AMExample)
+ (void)load {
    
    /*
     This will call Action Menu's registerAction:title:canPerform method
     which is Action Menu's extension to UIMenuController
     */
    
    [[UIMenuController sharedMenuController] registerAction:@selector(performMyAction)
                                                      title:@"Example"
                                                 canPerform:@selector(canPerformAction)];
    
}

- (BOOL)canPerformAction {
    //returns TRUE if the selected text is longer than 0 characters
    return [[self selectedTextualRepresentation] length] > 0;
}

- (void)performMyAction {
    
    //get the selected text
    NSString *selection = [self selectedTextualRepresentation];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Selected Text"
                                                 message:selection delegate:nil
                                       cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [av show]; //shows the alert
    [av release]; //releases the object to avoid memory leaks
    
}
@end
