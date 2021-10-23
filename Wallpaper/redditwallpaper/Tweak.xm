@import Foundation;
@import UIKit;

#import "Tweak.h"

%group Lockscreen

%hook CSCoverSheetViewController

- (void)viewDidLoad { // add player to the lockscreen

    %orig;

    // player
    NSURL* url = [GcImagePickerUtils videoURLFromDefaults:@"com.hjk.redditwallpaper" withKey:@"url"];
    if (!url) return;

    playerItemLS = [AVPlayerItem playerItemWithURL:url];

    playerLS = [AVQueuePlayer playerWithPlayerItem:playerItemLS];
    playerLS.volume = [lockscreenVolumeValue doubleValue];
    [playerLS setPreventsDisplaySleepDuringVideoPlayback:NO];
    if ([lockscreenVolumeValue doubleValue] == 0.0) [playerLS setMuted:YES];
    else [playerLS setVolume:[lockscreenVolumeValue doubleValue]];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];

    playerLooperLS = [AVPlayerLooper playerLooperWithPlayer:playerLS templateItem:playerItemLS];

    playerLayerLS = [AVPlayerLayer playerLayerWithPlayer:playerLS];
    [playerLayerLS setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [playerLayerLS setFrame:[[[self view] layer] bounds]];
    [playerLayerLS setOpacity:[lockscreenOpacityValue doubleValue]];
    [[[self view] layer] insertSublayer:playerLayerLS atIndex:0];


    // dim and blur superview
    if (!dimBlurViewLS && ([lockscreenBlurAmountValue doubleValue] != 0.0 || [lockscreenDimValue doubleValue] != 0.0)) {
        dimBlurViewLS = [[UIView alloc] initWithFrame:[[self view] bounds]];
        [dimBlurViewLS setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [[self view] insertSubview:dimBlurViewLS atIndex:1];
    }

    // blur
    if (!blurLS && [lockscreenBlurAmountValue doubleValue] != 0.0) {
        if ([lockscreenBlurModeValue intValue] == 0)
            blurLS = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        else if ([lockscreenBlurModeValue intValue] == 1)
            blurLS = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

        blurViewLS = [[UIVisualEffectView alloc] initWithEffect:blurLS];
        [blurViewLS setFrame:[dimBlurViewLS bounds]];
        [blurViewLS setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [blurViewLS setClipsToBounds:YES];
        [blurViewLS setAlpha:[lockscreenBlurAmountValue doubleValue]];
        [dimBlurViewLS addSubview:blurViewLS];
    }

    // dim
    if (!dimViewLS && [lockscreenDimValue doubleValue] != 0.0) {
        dimViewLS = [[UIView alloc] initWithFrame:[[self view] bounds]];
        [dimViewLS setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [dimViewLS setBackgroundColor:[UIColor blackColor]];
        [dimViewLS setAlpha:[lockscreenDimValue doubleValue]];
        [dimBlurViewLS addSubview:dimViewLS];
    }

}

- (void)viewWillAppear:(BOOL)animated { // play when view appears

    %orig;

    isLockscreenVisible = YES;
    [self adjustFrame];
    [playerLS play];
    if (enableHomescreenWallpaperSwitch && isHomescreenVisible) [playerHS pause];

}

- (void)viewWillDisappear:(BOOL)animated { // pause when view disappears

    %orig;

    isLockscreenVisible = NO;
    [playerLS pause];
    if (enableHomescreenWallpaperSwitch && isHomescreenVisible) [playerHS play];

}

%new
- (void)adjustFrame { // adjust the frame
    
    [playerLayerLS setFrame:[[[self view] layer] bounds]];

}

%end

%end //group: LockScreen


%group Homescreen

%hook SBIconController

- (void)viewDidLoad { // add player to the homescreen

    %orig;

    // player
    NSURL* url = [GcImagePickerUtils videoURLFromDefaults:@"com.hjk.redditwallpaper" withKey:@"homescreenWallpaper"];
    if (!url) return;

    playerItemHS = [AVPlayerItem playerItemWithURL:url];

    playerHS = [AVQueuePlayer playerWithPlayerItem:playerItemHS];
    playerHS.volume = [homescreenVolumeValue doubleValue];
    [playerHS setPreventsDisplaySleepDuringVideoPlayback:NO];
    if ([homescreenVolumeValue doubleValue] == 0.0) [playerHS setMuted:YES];
    else [playerHS setVolume:[homescreenVolumeValue doubleValue]];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    playerLooperHS = [AVPlayerLooper playerLooperWithPlayer:playerHS templateItem:playerItemHS];

    playerLayerHS = [AVPlayerLayer playerLayerWithPlayer:playerHS];
    [playerLayerHS setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [playerLayerHS setFrame:[[[self view] layer] bounds]];
    [playerLayerHS setTransform:CATransform3DMakeScale(1.15, 1.15, 2)];
    [playerLayerHS setOpacity:[homescreenOpacityValue doubleValue]];
    [[[self view] layer] insertSublayer:playerLayerHS atIndex:0];


    // dim and blur superview
    if (!dimBlurViewHS && ([homescreenBlurAmountValue doubleValue] != 0.0 || [homescreenDimValue doubleValue] != 0.0)) {
        dimBlurViewHS = [[UIView alloc] initWithFrame:[[self view] bounds]];
        [[dimBlurViewHS layer] setTransform:CATransform3DMakeScale(1.15, 1.15, 2)];
        [dimBlurViewHS setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [[self view] insertSubview:dimBlurViewHS atIndex:1];
    }

    // blur
    if (!blurHS && [homescreenBlurAmountValue doubleValue] != 0.0) {
        if ([homescreenBlurModeValue intValue] == 0)
            blurHS = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        else if ([homescreenBlurModeValue intValue] == 1)
            blurHS = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

        blurViewHS = [[UIVisualEffectView alloc] initWithEffect:blurHS];
        [blurViewHS setFrame:[dimBlurViewHS bounds]];
        [blurViewHS setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [blurViewHS setClipsToBounds:YES];
        [blurViewHS setAlpha:[homescreenBlurAmountValue doubleValue]];
        [dimBlurViewHS addSubview:blurViewHS];
    }

    // dim
    if (!dimViewHS && [homescreenDimValue doubleValue] != 0.0) {
        dimViewHS = [[UIView alloc] initWithFrame:[[self view] bounds]];
        [dimViewHS setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [dimViewHS setBackgroundColor:[UIColor blackColor]];
        [dimViewHS setAlpha:[homescreenDimValue doubleValue]];
        [dimBlurViewHS addSubview:dimViewHS];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adjustFrame) name:@"enekoRotateNotification" object:nil];

}

- (void)viewWillAppear:(BOOL)animated { // play when view appears

    %orig;

    isHomescreenVisible = YES;
    [self adjustFrame];
    [playerHS play];

}

- (void)viewWillDisappear:(BOOL)animated { // pause when view disappears

    %orig;

    isHomescreenVisible = NO;
    [playerHS pause];

}

%new
- (void)adjustFrame { // adjust the frame
    
    [playerLayerHS setFrame:[[[self view] layer] bounds]];

}

%end

%hook CSCoverSheetViewController

- (void)viewWillAppear:(BOOL)animated { // pause when lockscreen appears

    %orig;

    isLockscreenVisible = YES;
    if (isHomescreenVisible) [playerHS pause];

}

- (void)viewWillDisappear:(BOOL)animated { // play when lockscreen disappears

    %orig;

    isLockscreenVisible = NO;
    if (isHomescreenVisible) [playerHS play];

}

%end

%end  //group: HomeScreen



%group RedditWallpaper

%hook SBBacklightController

- (void)turnOnScreenFullyWithBacklightSource:(long long)arg1 { // play when screen turned on

    %orig;

    screenIsOn = YES;
    if (!isLockscreenVisible) return;
    if (enableLockscreenWallpaperSwitch) [playerLS play];
    if (enableHomescreenWallpaperSwitch) [playerHS pause];
}

%end

%hook SBLockScreenManager

- (void)lockUIFromSource:(int)arg1 withOptions:(id)arg2 { // pause all players when locked

    %orig;

    isLockscreenVisible = YES;
    screenIsOn = NO;
    if (enableLockscreenWallpaperSwitch) [playerLS pause];
    if (enableHomescreenWallpaperSwitch) [playerHS pause];

}

%end

%hook SBMediaController

- (BOOL)isPlaying { // mute players when music is playing

    if ([lockscreenVolumeValue doubleValue] == 0.0 && [homescreenVolumeValue doubleValue] == 0.0) return %orig;

    BOOL orig = %orig;

    if (orig) {
        if (enableLockscreenWallpaperSwitch && [lockscreenVolumeValue doubleValue] != 0.0 && muteWhenMusicPlaysSwitch) [playerLS setVolume:0.0];
        if (enableHomescreenWallpaperSwitch && [homescreenVolumeValue doubleValue] != 0.0 && muteWhenMusicPlaysSwitch) [playerHS setVolume:0.0];
    } else {
        if (enableLockscreenWallpaperSwitch && [lockscreenVolumeValue doubleValue] != 0.0 && muteWhenMusicPlaysSwitch) [playerLS setVolume:[lockscreenVolumeValue doubleValue]];
        if (enableHomescreenWallpaperSwitch && [homescreenVolumeValue doubleValue] != 0.0 && muteWhenMusicPlaysSwitch) [playerHS setVolume:[homescreenVolumeValue doubleValue]];
    }

    return orig;

}

%end

%hook SBDashBoardCameraPageViewController

- (void)viewWillAppear:(BOOL)animated { // pause when lockscreen camera appears

    %orig;

    if (enableLockscreenWallpaperSwitch && isLockscreenVisible) [playerLS pause];
    isLockscreenVisible = NO;

}

- (void)viewWillDisappear:(BOOL)animated { // play when lockscreen camera disappears

    isLockscreenVisible = YES;
    if (enableLockscreenWallpaperSwitch && isLockscreenVisible) [playerLS play];

}

%end

%hook CSModalButton

- (void)didMoveToWindow { // pause when alarm/timer fires

    %orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (enableLockscreenWallpaperSwitch) [playerLS pause];
        if (enableHomescreenWallpaperSwitch) [playerHS pause];
    });

}

- (void)removeFromSuperview { // pause when alarm/timer was dismissed

    %orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (enableLockscreenWallpaperSwitch && screenIsOn) [playerLS play];
        if (enableHomescreenWallpaperSwitch) [playerHS pause];
    });

}

%end

%hook SBLockScreenEmergencyCallViewController

- (void)viewWillAppear:(BOOL)animated { // pause when emergency call pad appears

    %orig;

    isLockscreenVisible = NO;
    if (enableLockscreenWallpaperSwitch) [playerLS pause];

}

- (void)viewWillDisappear:(BOOL)animated { // play when emergency call pad disappears

    %orig;

    isLockscreenVisible = YES;
    if (enableLockscreenWallpaperSwitch) [playerLS play];

}

%end

%end //group: RedditWallpaper
 

%ctor {

    preferences = [NSMutableDictionary dictionaryWithContentsOfFile:PREFS_PLIST_PATH];

    enabled = prefs[@"Enabled"] ? [prefs[@"Enabled"] boolValue] : YES;
    if (!enabled) return;

    // lockscreen
    enableLockscreenWallpaperSwitch = YES;
    if (enableLockscreenWallpaperSwitch) {
        lockscreenVolumeValue = @"100.0";
        lockscreenBlurAmountValue = @"0";
        lockscreenBlurModeValue = @"0";
        lockscreenDimValue = @"0.0";
        lockscreenOpacityValue = @"1.0";
    }

    // homescreen
    enableHomescreenWallpaperSwitch = YES;
    if (enableHomescreenWallpaperSwitch) {
        homescreenVolumeValue = @"100.0";
        homescreenBlurAmountValue = @"0.0";
        homescreenBlurModeValue = @"0";
        homescreenDimValue = @"0.0";
        homescreenOpacityValue = @"1.0";
    }

    // miscellaneous
    muteWhenMusicPlaysSwitch = NO;

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    if (enableLockscreenWallpaperSwitch) %init(Lockscreen);
    if (enableHomescreenWallpaperSwitch) %init(Homescreen);
    if (enableLockscreenWallpaperSwitch || enableHomescreenWallpaperSwitch) %init(RedditWallpaper);

}