SDKVERSION = 7.0
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk
TWEAK_NAME = NoWallpaperZoomAnimation
NoWallpaperZoomAnimation_FILES = Tweak.xm
NoWallpaperZoomAnimation_FRAMEWORKS = UIKit
NoWallpaperZoomAnimation_LIBRARIES = Accessibility

include $(THEOS_MAKE_PATH)/tweak.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp -R Resources $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NoWallpaperZoomAnimation$(ECHO_END)
	$(ECHO_NOTHING)find $(THEOS_STAGING_DIR) -name .DS_Store | xargs rm -rf$(ECHO_END)
