export ARCHS = arm64 arm64e

TARGET := iphone:clang:latest:12.0
INSTALL_TARGET_PROCESSES = SpringBoard Prefrences


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Eliza

Eliza_FILES = Tweak.x
Eliza_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += elizaprefrences
include $(THEOS_MAKE_PATH)/aggregate.mk
