
include $(THEOS)/makefiles/common.mk

export ARCHS = arm64
export TARGET = iphone:11.2:11.2

SUBPROJECTS += Music Spotify Prefs

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 Music; open com.apple.Music"
