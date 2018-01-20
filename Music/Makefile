include $(THEOS)/makefiles/common.mk

ARCHS = arm64
TARGET = iphone:10.2:10.2
TWEAK_NAME = MitsuhaXIMusic
$(TWEAK_NAME)_FILES = Tweak.xmi $(wildcard ../MSH*.*m*)

$(TWEAK_NAME)_CFLAGS += -D THEOSBUILD=1 -D HBLogError=NSLog -w
$(TWEAK_NAME)_CFLAGS += -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Music; open com.apple.Music"