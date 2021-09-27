GO_EASY_ON_ME = 1

ARCHS = armv7 arm64
TARGET = iphone:clang:10.3
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = redditwallpaper

redditwallpaper_FILES = Tweak.x
SnooScreens_FRAMEWORKS = UIKit CoreGraphics
SnooScreens_PRIVATE_FRAMEWORKS = PersistentConnection PhotoLibrary SpringBoardFoundation

include $(THEOS_MAKE_PATH)/tweak.mk
