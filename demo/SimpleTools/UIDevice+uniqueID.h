//
//  UIDevice+uniqueID.h
//  demo
//
//  Created by Pellet Mo on 16/6/5.
//
//

#import <UIKit/UIKit.h>

@interface UIDevice (uniqueID)
- (NSString *) uniqueID;

- (NSString *) wifiMAC;
- (NSString *) bluetoothMAC;
- (NSString *) serialNumber;
- (NSString *) deviceIMEI;
- (NSString *)deviceECID;
@end
