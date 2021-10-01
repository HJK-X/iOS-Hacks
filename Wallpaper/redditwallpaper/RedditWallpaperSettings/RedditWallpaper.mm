#import <Preferences/PSListController.h>
static NSString *const settingsPath = @"/var/mobile/Library/Preferences/com.hjk.redditwallpaper.plist";
static NSDictionary *prefs;

@interface RedditWallpaperListController: PSListController {
}
@end

@implementation RedditWallpaperListController
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)wallpaper {
    prefs = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
    NSString* redditUrl = [prefs objectForKey:@"url"];
    NSLog(@"%@",redditUrl);
}
@end


// @interface SSSubredditListController : PSListController {
//     int subNumber;
// }
// @end

// @interface SnooScreensListController: PSEditableListController <UITableViewDataSource> {
//     NSMutableArray *specifiers;
// }
// @end

// @implementation SnooScreensListController
// - (id)specifiers {
// 	if(_specifiers == nil) {
//         extern NSString* PSDeletionActionKey;
//         specifiers = [[NSMutableArray alloc] init];
//         PSSpecifier *spec;
//         spec = [PSSpecifier emptyGroupSpecifier];
//         [spec setProperty:@"SSCustomCell" forKey:@"footerCellClass"];
//         [specifiers addObject:spec];
//         spec = [PSSpecifier emptyGroupSpecifier];
//         [specifiers addObject:spec];
//         prefs = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
//         int count = [prefs objectForKey:@"count"] ? [[prefs objectForKey:@"count"] intValue] : 1;
//         for (int i=1; i<=count; i++) {
//             spec = [PSSpecifier preferenceSpecifierNamed:[NSString stringWithFormat:@"Subreddit %d", i]
//                                                   target:self
//                                                      set:NULL
//                                                      get:NULL
//                                                   detail:objc_getClass("SSSubredditListController")
//                                                     cell:PSLinkCell
//                                                     edit:Nil];
//             [spec setProperty:@(i) forKey:@"subNumber"];
//             [spec setProperty:[prefs objectForKey:[NSString stringWithFormat:@"sub%d-subreddit", i]] forKey:@"subreddit"];
//             [spec setProperty:NSClassFromString(@"SSSubredditCell") forKey:@"cellClass"];
//             [spec setProperty:NSStringFromSelector(@selector(removedSpecifier:)) forKey:PSDeletionActionKey];
//             [specifiers addObject:spec];
            
//         }
        
//         spec = [PSSpecifier preferenceSpecifierNamed:@"Add subreddit..."
//                                               target:self
//                                                  set:NULL
//                                                  get:NULL
//                                               detail:Nil
//                                                 cell:PSButtonCell
//                                                 edit:Nil];
//         spec->action = @selector(newSubreddit);
//         [spec setProperty:NSClassFromString(@"SSTintedCell") forKey:@"cellClass"];
//         [specifiers addObject:spec];
        
//         spec = [PSSpecifier emptyGroupSpecifier];
//         [spec setProperty:@"Saves the wallpaper you currently have set" forKey:@"footerText"];
//         [specifiers addObject:spec];
        
//         spec = [PSSpecifier preferenceSpecifierNamed:@"Save Wallpaper"
//                                               target:self
//                                                  set:NULL
//                                                  get:NULL
//                                               detail:Nil
//                                                 cell:PSButtonCell
//                                                 edit:Nil];
//         spec->action = @selector(saveWallpaper);
//         [spec setProperty:NSClassFromString(@"SSTintedCell") forKey:@"cellClass"];
//         [specifiers addObject:spec];
        
        
//         _specifiers = [[NSArray arrayWithArray:specifiers] retain];
// 	}
// 	return _specifiers;
// }

// -(void)viewWillAppear:(BOOL)animated {
//     [super viewWillAppear:animated];
//     if (!self.isMovingToParentViewController) {
//         [self reloadSpecifiers];
//     }
// }

// -(void)saveWallpaper {
//     NSString *link;
//     //NSString *settingsPath = @"/var/mobile/Library/Preferences/com.milodarling.snooscreens.plist";
//     prefs = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
//     link = [prefs objectForKey:@"currentWallpaper"];
//     if (!link) {
//         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SnooScreens"
//                                                         message:[NSString stringWithFormat:@"You don't have a wallpaper link saved! This means that you last used this on an older version that did not yet support this feature. After setting another wallpaper with SnooScreens, this feature should work."]
//                                                        delegate:self
//                                               cancelButtonTitle:@"Ok"
//                                               otherButtonTitles:nil];
//         [alert show];
//         [alert release];
//         return;
//     }
//     NSURL *url = [NSURL URLWithString:link];
//     NSError *imageError = nil;
//     NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:&imageError];
//     if (imageError) {
//         NSLog(@"[%@] Error downloading image: %@", "ASD", imageError);
//         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SnooScreens"
//                                                          message:[NSString stringWithFormat:@"There was an error downloading the image %@ from imgur. Perhaps imgur is blocked on your Internet connection?", url]
//                                                         delegate:self
//                                                cancelButtonTitle:@"Ok"
//                                                otherButtonTitles:nil];
//         [alert show];
//         [alert release];
//         return;
//     }
//     UIImage *rawImage = [UIImage imageWithData:data];
//     UIImageWriteToSavedPhotosAlbum(rawImage, nil, nil, nil);
// }

// -(void)newSubreddit {
//     prefs = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
//     int count = [prefs objectForKey:@"count"] ? [[prefs objectForKey:@"count"] intValue] : 1;
//     count++;
//     NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
//     [defaults addEntriesFromDictionary:prefs];
//     [defaults setObject:[NSNumber numberWithInt:count] forKey:@"count"];
//     [defaults writeToFile:settingsPath atomically:YES];
//     [self reloadSpecifiers];
// }

// -(void)removedSpecifier:(PSSpecifier *)specifier {
//     prefs = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
//     int count = [prefs objectForKey:@"count"] ? [[prefs objectForKey:@"count"] intValue] : 1;
//     NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
//     [defaults addEntriesFromDictionary:prefs];
//     int index = [specifier.properties[@"subNumber"] intValue];
//     for (int i=index; i<=count; i++) {
//         NSArray *keys = @[ @"-subreddit",
//                            @"-wallpaperMode",
//                            @"-allowBoobies",
//                            @"-savePhoto",
//                            @"-random" ];
//         for (NSString *key in keys) {
//             NSString *currentKey = [NSString stringWithFormat:@"sub%d%@", i+1, key];
//             NSString *newKey = [NSString stringWithFormat:@"sub%d%@", i, key];
//             id object = [defaults objectForKey:currentKey];
//             if (object)
//                 [defaults setObject:object forKey:newKey];
//             else
//                 [defaults removeObjectForKey:newKey];
//         }
//     }
//     count--;
//     [defaults setObject:@(count) forKey:@"count"];
//     [defaults writeToFile:settingsPath atomically:YES];
//     [self performSelector:@selector(reloadSpecifiers) withObject:nil afterDelay:0.3f];
// }

// - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//     // Return YES if you want the specified item to be editable.
//     DebugLogC(@"indexPath: %@, length: %lu", indexPath, (unsigned long)indexPath.length);
//     UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//     if ([cell.textLabel.text isEqualToString:@"More"]) {
//         return NO;
//     }
//     return YES;
// }

// @end

// @interface SSCustomCell : PSTableCell {
    
// }
// @end

// @implementation SSCustomCell

// - (id)initWithSpecifier:(id)specifier {
//     self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
//     if (self) {
        
//     }
//     return self;
// }

// - (CGFloat)preferredHeightForWidth:(CGFloat)arg1 {
//     return 90.f;
// }

// @end


// @implementation SSSubredditListController

// -(void)setSpecifier:(PSSpecifier *)specifier {
//     subNumber = [specifier.properties[@"subNumber"] intValue];
//     [super setSpecifier:specifier];
    
// }

// -(id)specifiers {
//     if (_specifiers == nil) {
        
//         NSLog(@"[SnooScreens] We got called!");
//         NSMutableArray *specifiers = [[NSMutableArray alloc] init];
//         NSString *methodName = [NSString stringWithFormat:@"sub%d", subNumber];
        
//         DebugLogC(@"Creating first specifier");
//         NSArray *suggestions = [NSArray arrayWithObjects:@"Need a suggestion? How about /r/EarthPorn?", @"Here's a tip: I support mulitreddits! Try /user/CastleCorp/m/find_me_wallpapers", @"Can't think of a subreddit? Why not /r/wallpaper?", @"Out of ideas? Try /r/spaceporn!", @"Need another suggestion? How does /r/CityPorn sound?", @"There's even a subreddit for wallpapers that look nice with SnooScreens! Try /r/SnooScreens!", nil];
//         int randomIndex = arc4random_uniform([suggestions count]);
//         PSSpecifier *spec = [PSSpecifier groupSpecifierWithHeader:[NSString stringWithFormat:@"Subreddit %d", subNumber] footer:[suggestions objectAtIndex:randomIndex]];
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating second specifier");
//         PSTextFieldSpecifier *textSpec = [PSTextFieldSpecifier preferenceSpecifierNamed:@"Subreddit"
//                                                                                 target:self
//                                                                                    set:@selector(setPreferenceValue:specifier:)
//                                                                                    get:@selector(readPreferenceValue:)
//                                                                                 detail:Nil
//                                                                                   cell:PSEditTextCell
//                                                                                   edit:Nil];
//         [textSpec setProperty:@"/r/" forKey:@"default"];
//         [textSpec setProperty:[NSString stringWithFormat:@"%@-subreddit", methodName] forKey:@"key"];
//         [specifiers addObject:textSpec];
        
//         [specifiers addObject:[PSSpecifier emptyGroupSpecifier]];
        
//         spec = [PSSpecifier preferenceSpecifierNamed:@"Enabled"
//                                               target:self
//                                                  set:@selector(setPreferenceValue:specifier:)
//                                                  get:@selector(readPreferenceValue:)
//                                               detail:Nil
//                                                 cell:PSSwitchCell
//                                                 edit:Nil];
//         [spec setProperty:[NSString stringWithFormat:@"%@-enabled", methodName] forKey:@"key"];
//         [spec setProperty:@YES forKey:@"default"];
//         [specifiers addObject:spec];
        
        
//         DebugLogC(@"Creating third specifier");
//         spec = [PSSpecifier emptyGroupSpecifier];
//         [spec setProperty:@"Pick an activation method for this subreddit." forKey:@"footerText"];
//         [spec setProperty:@"PSGroupCell" forKey:@"cell"];
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating fourth specifier");
//         spec = [PSSpecifier preferenceSpecifierNamed:@"Activation Method"
//                                               target:self
//                                                  set:NULL
//                                                  get:NULL
//                                               detail:Nil
//                                                 cell:PSLinkCell
//                                                 edit:Nil];
//         [spec setProperty:@YES forKey:@"isContoller"];
//         [spec setProperty:[NSString stringWithFormat:@"com.milodarling.snooscreens.%@", methodName] forKey:@"activatorListener"];
//         [spec setProperty:@"/System/Library/PreferenceBundles/LibActivator.bundle" forKey:@"lazy-bundle"];
//         spec->action = @selector(lazyLoadBundle:);
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating fifth specifier");
//         spec = [PSSpecifier emptyGroupSpecifier];
//         [spec setProperty:@"Apply to home screen, lock screen, or both." forKey:@"footerText"];
//         [spec setProperty:@"PSGroupCell" forKey:@"cell"];
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating sixth specifier");
//         spec = [PSSpecifier preferenceSpecifierNamed:@"Set to"
//                                               target:self
//                                                  set:@selector(setPreferenceValue:specifier:)
//                                                  get:@selector(readPreferenceValue:)
//                                               detail:NSClassFromString(@"PSListItemsController")
//                                                 cell:PSLinkListCell
//                                                 edit:Nil];
//         [spec setProperty:[NSString stringWithFormat:@"%@-wallpaperMode", methodName] forKey:@"key"];
//         [spec setProperty:NSStringFromSelector(@selector(titlesDataSource)) forKey:@"titlesDataSource"];
//         [spec setProperty:NSStringFromSelector(@selector(valuesDataSource)) forKey:@"valuesDataSource"];
//         //spec->_values = [NSArray arrayWithObjects:@"1", @"2", @"0", nil];
//         [spec setProperty:@"0" forKey:@"default"];
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating seventh specifier");
//         spec = [PSSpecifier emptyGroupSpecifier];
//         [spec setProperty:@"Allow NSFW images to be saved & set as your wallpaper." forKey:@"footerText"];
//         [spec setProperty:@"PSGroupCell" forKey:@"cell"];
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating eighth specifier");
//         spec = [PSSpecifier preferenceSpecifierNamed:@"Allow NSFW images"
//                                               target:self
//                                                  set:@selector(setPreferenceValue:specifier:)
//                                                  get:@selector(readPreferenceValue:)
//                                               detail:Nil
//                                                 cell:PSSwitchCell
//                                                 edit:Nil];
//         [spec setProperty:[NSString stringWithFormat:@"%@-allowBoobies", methodName] forKey:@"key"];
//         [spec setProperty:@NO forKey:@"default"];
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating ninth specifier");
//         spec = [PSSpecifier emptyGroupSpecifier];
//         [spec setProperty:@"Save the photo to your photo library after setting it as your wallpaper." forKey:@"footerText"];
//         [spec setProperty:@"PSGroupCell" forKey:@"cell"];
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating tenth specifier");
//         spec = [PSSpecifier preferenceSpecifierNamed:@"Save photo"
//                                               target:self
//                                                  set:@selector(setPreferenceValue:specifier:)
//                                                  get:@selector(readPreferenceValue:)
//                                               detail:Nil
//                                                 cell:PSSwitchCell
//                                                 edit:Nil];
//         [spec setProperty:[NSString stringWithFormat:@"%@-savePhoto", methodName] forKey:@"key"];
//         [spec setProperty:@NO forKey:@"default"];
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating eleventh specifier");
//         spec = [PSSpecifier emptyGroupSpecifier];
//         [spec setProperty:@"Use a random image. If this is disabled, the top image will be grabbed." forKey:@"footerText"];
//         [spec setProperty:@"PSGroupCell" forKey:@"cell"];
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating twelfth specifier");
//         spec = [PSSpecifier preferenceSpecifierNamed:@"Random image"
//                                               target:self
//                                                  set:@selector(setPreferenceValue:specifier:)
//                                                  get:@selector(readPreferenceValue:)
//                                               detail:Nil
//                                                 cell:PSSwitchCell
//                                                 edit:Nil];
//         [spec setProperty:[NSString stringWithFormat:@"%@-random", methodName] forKey:@"key"];
//         [spec setProperty:@NO forKey:@"default"];
//         [specifiers addObject:spec];
        
//         DebugLogC(@"Creating _specifiers");
//         _specifiers = [[specifiers copy] retain];
//     }
//     DebugLogC(@"returning _specifiers");
//     return _specifiers;
// }

// -(void)viewWillDisappear:(BOOL)animated {
//     [self.view endEditing:YES];
//     [super viewWillDisappear:animated];
// }

// -(id) readPreferenceValue:(PSSpecifier*)specifier {
//     NSDictionary *exampleTweakSettings = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
//     if (!exampleTweakSettings[specifier.properties[@"key"]]) {
//         return specifier.properties[@"default"];
//     }
//     return exampleTweakSettings[specifier.properties[@"key"]];
// }

// -(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
//     NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
//     [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:settingsPath]];
//     [defaults setObject:value forKey:specifier.properties[@"key"]];
//     [defaults writeToFile:settingsPath atomically:YES];
//     if ([[specifier name] isEqualToString:@"Subreddit"])
//         CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.milodarling.snooscreens/updateListeners"), NULL, NULL, YES);
//     else
//         CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.milodarling.snooscreens/prefsChanged"), NULL, NULL, YES);
// }

// -(NSArray *)titlesDataSource {
//     return [NSArray arrayWithObjects:@"Home Screen", @"Lock Screen", @"Both", nil];
// }

// -(NSArray *)valuesDataSource {
//     return [NSArray arrayWithObjects:@"1", @"2", @"0", nil];
// }

// -(void)loadView {
//     [super loadView];
//     self.navigationItem.title = [NSString stringWithFormat:@"Subreddit %d", subNumber];
// }

// @end


// @interface SSTintedCell : PSTableCell
// @end
// @implementation SSTintedCell

// - (void)layoutSubviews {
//     [super layoutSubviews];
//     self.textLabel.textColor = [UIColor colorWithRed:48.0f/255.0f green:56.0f/255.0f blue:103.0f/255.0f alpha:1.0];
// }

// @end

// @interface SSSubredditCell : PSTableCell
// @end

// @implementation SSSubredditCell

// -(void)layoutSubviews {
//     [super layoutSubviews];
//     //NSString *subreddit = [prefs]
//     self.detailTextLabel.text = self.specifier.properties[@"subreddit"];
//     self.detailTextLabel.textColor = [UIColor colorWithWhite:0.5568627451f alpha:1];
// }

// @end

// vim:ft=objc
