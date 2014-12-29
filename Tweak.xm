#import <substrate.h>

@interface SBPrototypeController : NSObject
+ (SBPrototypeController *)sharedInstance;
- (BOOL)isShowingSettingsUI;
@end

extern "C" Boolean _AXSReduceMotionEnabled();

NSString *const tweakEnabledKey = @"SBUINoWallpaperZoomAnimation";
NSString *const tweakUpToMotionKey = @"SBUINoWallpaperZoomAnimationUpToMotion";
BOOL shouldNotHook = NO;

static BOOL optionEnabled(NSString *key, BOOL defaultValue)
{
	id r = [[NSUserDefaults standardUserDefaults] objectForKey:key];
	return r != nil ? [r boolValue] : defaultValue;
}

static CGRect newRect(CGRect defaultRect)
{
	BOOL isShowingSettingsUI = [[%c(SBPrototypeController) sharedInstance] isShowingSettingsUI];
	BOOL tweakEnabled = optionEnabled(tweakEnabledKey, YES);
	BOOL tweakUpToMotion = optionEnabled(tweakUpToMotionKey, NO);
	if (!tweakEnabled || shouldNotHook || isShowingSettingsUI)
		return defaultRect;
	CGRect nothingRect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
	if (tweakUpToMotion)
		return _AXSReduceMotionEnabled() ? nothingRect : defaultRect;
	return nothingRect;
}

%hook SBFadeAnimationSettings

+ (id)settingsControllerModule
{
	shouldNotHook = YES;
	id orig = %orig;
	shouldNotHook = NO;
	return orig;
}

- (CGRect)wallpaperOutContentsRect
{
	return newRect(%orig);
}

- (CGRect)wallpaperInContentsRect
{
	return newRect(%orig);
}

%end
