ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = RedditWallpaper
$(BUNDLE_NAME)_FILES = RedditWallpaper.mm
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_FRAMEWORKS = UIKit
$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/RedditWallpaper.plist$(ECHO_END)
	$(ECHO_NOTHING)sed -i "s/"\&"/"\&amp\;"/g" entry.plist && sed -i "s/"\&"/"\&amp\;"/g" Resources/Root.plist$(ECHO_END) # Replace '&' with '&amp;' to prevent blank preferences