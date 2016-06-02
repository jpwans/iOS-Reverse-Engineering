#line 1 "/Users/jiangqin/Documents/Demo/demo/demo/demo.xm"
#import "Entrance.h"


__attribute__((constructor))
static void initializer(void) {
    int sr = setuid(0);
    NSLog(@"sr :%d",sr);
    int ssr = setsid();
    NSLog(@"ssr :%d",ssr);
    NSLog(@"initializer from demo");
    [Entrance sharedInstance];
    
}





