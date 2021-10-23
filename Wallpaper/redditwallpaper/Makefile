ARCHS = armv7 arm64
TARGET = iphone:clang:10.3
THEOS_PACKAGE_DIR_NAME = debs
#DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1
GO_EASY_ON_ME = 1


TWEAK_NAME = RedditWallpaper
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_FRAMEWORKS = UIKit CoreGraphics MediaPlayer AVFoundation
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = PersistentConnection PhotoLibrary SpringBoardFoundation
$(TWEAK_NAME)_LIBRARIES = gcuniversal
$(TWEAK_NAME)_LDFLAGS = -lactivator


SUBPROJECTS += RedditWallpaperSettings 

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/aggregate.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
