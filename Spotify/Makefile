include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MitsuhaXISpotify
$(TWEAK_NAME)_FILES = Tweak.xmi $(wildcard ../MSH*.*m*)

$(TWEAK_NAME)_CFLAGS += -D THEOSBUILD=1 -D HBLogError=NSLog -w
$(TWEAK_NAME)_CFLAGS += -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk