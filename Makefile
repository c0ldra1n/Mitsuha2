
include $(THEOS)/makefiles/common.mk

ARCHS = arm64
TARGET = iphone:10.2:10.2
GO_EASY_ON_ME=1

SUBPROJECTS += Music

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 Music; open com.apple.Music"
