//
//  Entrance.h
//  demo
//
//  Created by jiangqin on 16/6/2.
//
//

#import <Foundation/Foundation.h>

@interface Entrance : NSObject
+ (instancetype)sharedInstance;
@property (assign ,nonatomic,getter=isLoaded) BOOL loaded;
@end
