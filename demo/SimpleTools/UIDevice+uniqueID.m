////
////  UIDevice+uniqueID.m
////  demo
////
////  Created by Pellet Mo on 16/6/5.
////
////
//
//#import "UIDevice+uniqueID.h"
//#include <arpa/inet.h>
//#include <net/if.h>
//#include <net/if_dl.h>
//#include <arpa/inet.h>
//#include <ifaddrs.h>
//#import <mach/mach_port.h>
//#import <CommonCrypto/CommonDigest.h>
//#import <IOKit/IOKitLib.h> // add by U.
//#import <CoreFoundation/CoreFoundation.h>
//NSArray *getValue(NSString *iosearch);
//
//
//// thanks Erica Sadun!
//// (spent time on this without realizing you had already wrote what I was looking for!)
//NSArray *getValue(NSString *iosearch)
//{
//    mach_port_t          masterPort;
//    CFTypeID             propID = (CFTypeID) NULL;
//    unsigned int         bufSize;
//    
//    kern_return_t kr = IOMasterPort(MACH_PORT_NULL, &masterPort);
//    if (kr != noErr) return nil;
//    
//    io_registry_entry_t entry = IORegistryGetRootEntry(masterPort);
//    if (entry == MACH_PORT_NULL) return nil;
//    
//    CFTypeRef prop = IORegistryEntrySearchCFProperty(entry, kIODeviceTreePlane, (__bridge CFStringRef) iosearch, nil, kIORegistryIterateRecursively);
//    if (!prop) return nil;
//    
//    propID = CFGetTypeID(prop);
//    if (!(propID == CFDataGetTypeID()))
//    {
//        mach_port_deallocate(mach_task_self(), masterPort);
//        return nil;
//    }
//    
//    CFDataRef propData = (CFDataRef) prop;
//    if (!propData) return nil;
//    
//    bufSize = CFDataGetLength(propData);
//    if (!bufSize) return nil;
//    
//    NSString *p1 = [[NSString alloc] initWithBytes:CFDataGetBytePtr(propData) length:bufSize encoding:1];
//    mach_port_deallocate(mach_task_self(), masterPort);
//    return [p1 componentsSeparatedByString:@"\0"];
//}
//@implementation UIDevice (uniqueID)
//// UDID = SHA1(SerialNumber + IMEI + WiFiAddress + BluetoothAddress)
//// http://iphonedevwiki.net/index.php/Lockdownd
///** add by U: 这网址里说了, iphone4之后，公示应该是：SHA1(SerialNumber + ECID + WiFiAddress + BluetoothAddress).
// 而实际真机测试发现- deviceIMEI函数获取不到IMEI.
// 所以修改了这函数. */
//- (NSString *) uniqueID
//{
//    
//    // Returns a random hash if run in the simulator
//#if TARGET_IPHONE_SIMULATOR
//    
//    return [[[[[NSProcessInfo processInfo] globallyUniqueString] stringByReplacingOccurrencesOfString:@"-" withString:@""] substringToIndex:40] lowercaseString];
//    
//#endif
//    
//    NSString *concat = [NSString stringWithFormat:@"%@%@%@%@",
//                        [self serialNumber],
//                        [self deviceECID],//[self deviceIMEI],
//                        [self wifiMAC],
//                        [self bluetoothMAC]];
//    
//    
//    const char *cconcat = [concat UTF8String];
//    
//    unsigned char result[20];
//    CC_SHA1(cconcat,strlen(cconcat),result);
//    
//    NSMutableString *hash = [NSMutableString string];
//    int i;
//    for (i=0; i < 20; i++)
//    {
//        [hash appendFormat:@"%02x",result[i]];
//    }
//    
//    return [hash lowercaseString];
//}
//
//
//- (NSString *) wifiMAC
//{
//    struct ifaddrs *interfaces;
//    const struct ifaddrs *tmpaddr;
//    
//    if (getifaddrs(&interfaces)==0)
//    {
//        tmpaddr = interfaces;
//        
//        while (tmpaddr != NULL)
//        {
//            if (strcmp(tmpaddr->ifa_name,"en0")==0)
//            {
//                struct sockaddr_dl *dl_addr = ((struct sockaddr_dl *)tmpaddr->ifa_addr);
//                uint8_t *base = (uint8_t *)&dl_addr->sdl_data[dl_addr->sdl_nlen];
//                
//                NSMutableString *s = [NSMutableString string];
//                
//                int i;
//                
//                for (i=0; i < dl_addr->sdl_alen; i++)
//                {
//                    [s appendFormat:(i!=0)?@":%02x":@"%02x",base[i]];
//                }
//                
//                return s;
//            }
//            
//            tmpaddr = tmpaddr->ifa_next;
//        }
//        
//        freeifaddrs(interfaces);
//    }
//    return @"00:00:00:00:00:00";
//    
//}
//
//
//// I hope someone will find a better way to do this
//- (NSString *) bluetoothMAC
//{
//    mach_port_t port;
//    
//    IOMasterPort(MACH_PORT_NULL,&port);
//    
//    CFMutableDictionaryRef bt_dict = IOServiceNameMatching("bluetooth");
//    mach_port_t btservice = IOServiceGetMatchingService(port, bt_dict);
//    
//    CFDataRef bt_data = (CFDataRef)IORegistryEntrySearchCFProperty(btservice,"IODevicTree",(CFStringRef)@"local-mac-address", kCFAllocatorDefault, 1);
//    
//    NSString *string = [((__bridge NSData *)bt_data) description];
//    
//    string = [string stringByReplacingOccurrencesOfString:@"<" withString:@""];
//    string = [string stringByReplacingOccurrencesOfString:@">" withString:@""];
//    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    
//    NSMutableString *btAddr = [NSMutableString string];
//    
//    int x=0;
//    while (x<12)
//    {
//        x++;
//        [btAddr appendFormat:((x!=12&&x%2==0)?@"%C:":@"%C"),[string characterAtIndex:(x-1)]];
//    }
//    
//    return btAddr;
//}
//
//- (NSString *) serialNumber
//{
//    return [getValue(@"serial-number") objectAtIndex:0];
//}
//
//- (NSString *) deviceIMEI
//{
//    return [getValue(@"device-imei") objectAtIndex:0];
//}
//
//
///// add by U:
////
//- (NSString *)deviceECID
//{
//    NSString * res = nil;
//    if (CFMutableDictionaryRef dict = IOServiceMatching("IOPlatformExpertDevice")) {
//        if (io_service_t service = IOServiceGetMatchingService(kIOMasterPortDefault, dict)) {
//            if (CFTypeRef ecid = IORegistryEntrySearchCFProperty(service, kIODeviceTreePlane, CFSTR("unique-chip-id"), kCFAllocatorDefault, kIORegistryIterateRecursively)) {
//                NSData *data((NSData *) ecid);
//                size_t length([data length]);
//                uint8_t bytes[length];
//                [data getBytes:bytes];
//                char string[length * 2 + 1];
//                for (size_t i(0); i != length; ++i)
//                    sprintf(string + i * 2, "%.2X", bytes[length - i - 1]);
//                printf("%s", string);
//                res = [[[NSString alloc] initWithCString:string encoding:NSASCIIStringEncoding] autorelease];
//                CFRelease(ecid);
//            }
//            IOObjectRelease(service);
//        }
//    }
//    return res;
//}
//@end
