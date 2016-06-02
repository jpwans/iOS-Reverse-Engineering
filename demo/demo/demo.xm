#import "Entrance.h"

// Initializer dylib 的入口点
__attribute__((constructor))
static void initializer(void) {
    int sr = setuid(0);
    NSLog(@"sr :%d",sr);
    int ssr = setsid();
    NSLog(@"ssr :%d",ssr);
    NSLog(@"initializer from demo");
    [Entrance sharedInstance];
    
}

//dlopen("/usr/lib/libapplist.dylib", RTLD_NOW);



