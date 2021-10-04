#import <Preferences/PSListController.h>

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
@end

// vim:ft=objc
