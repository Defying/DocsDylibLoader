SDKVERSION = 9.3

include theos/makefiles/common.mk

ARCHS = armv7 arm64

TWEAK_NAME = DocsDylibLoader
DocsDylibLoader_FILES = Tweak.xm
DocsDylibLoader_LDFLAGS += -Wl,-segalign,4000 -framework UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
