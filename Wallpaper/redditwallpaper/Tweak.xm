@import Foundation;
@import UIKit;
#import <substrate.h>
#import "vm_writeData.h"

// To MSHook Offsets, use https://iosgods.com/topic/22718-mshook-offsets/
// To Generate Tweak.xm and Preferences Plist https://iosgods.com/topic/24138-code-inject/

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.hjk.redditwallpaper.plist"

inline bool GetPrefBool(NSString *key) {
		return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}


// Add your MS/Flex/MSHook Code here. Examples can be found on iOSGods.


%ctor {

	// Code Injection example
    if(GetPrefBool(@"key1")) {
      vm_writeData(0x123456, 0x123456); // 
    }

    if(GetPrefBool(@"key2")) {
      vm_writeData(0x10963C, 0xC0F8AC70); // 
    }

    if(GetPrefBool(@"key3")) {
      vm_writeData(0x1806B8, 0x381C); // ARMv7Offsets
      vm_writeData(0x2FA51C, 0x381C); // 
      vm_writeData(0x1001D98E0, 0x1F2003D5); // ARM64Offsets
      vm_writeData(0x10038DD0C, 0x1F2003D5); // 
    }

}



// Automatic Popup Code
void setup() {
    UIAlertController *igcredits = [UIAlertController alertControllerWithTitle:@"Made for iOSGods.com" message:@"RedditWallpaper Cheats by hjk for iOSGods.com!\n\nVisit the hack's official topic on iOSGods for more information and updates!" preferredStyle:UIAlertControllerStyleAlert];


    UIAlertAction *iosgods = [UIAlertAction actionWithTitle:@"Visit iOSGods.com!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:@"https://iosgods.com/forum/13-free-jailbroken-cydia-cheats/"];
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            if (success) {
                //NSLog(@"Opened url");
            }
        }];
        
    }];
    
    UIAlertAction *clubs = [UIAlertAction actionWithTitle:@"Visit the Clubs!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:@"https://iosgods.com/clubs/"];
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            if (success) {
                //NSLog(@"Opened url");
            }
        }];
    }];
    
    UIAlertAction *thankyou = [UIAlertAction actionWithTitle:@"Thank you!" style:UIAlertActionStyleCancel handler:nil];
    
    [igcredits addAction:iosgods];
    [igcredits addAction:clubs];
    [igcredits addAction:thankyou];


    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:igcredits animated:true completion:nil];
}

void unsubscribeToLaunchEvent(void);

static void didFinishLaunching(CFNotificationCenterRef center, void *observer,
                               CFStringRef name, const void *object, CFDictionaryRef info) {
    setup();
    unsubscribeToLaunchEvent();
}

const char *authObserver = "authObserver";

void subscribeToLaunchEvent() {
    CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), authObserver, &didFinishLaunching,
                                    (CFStringRef)UIApplicationDidFinishLaunchingNotification,
                                    NULL, CFNotificationSuspensionBehaviorDrop);
}

void unsubscribeToLaunchEvent() {
    CFNotificationCenterRemoveObserver(CFNotificationCenterGetLocalCenter(), authObserver,
                                       (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL);
}

__attribute__((constructor)) static void initialize() {
    subscribeToLaunchEvent();
}
