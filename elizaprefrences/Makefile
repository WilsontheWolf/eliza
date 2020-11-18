TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ElizaPrefrences

ElizaPrefrences_FILES = EPWRootListController.m
ElizaPrefrences_FRAMEWORKS = UIKit
ElizaPrefrences_PRIVATE_FRAMEWORKS = Preferences
ElizaPrefrences_INSTALL_PATH = /Library/PreferenceBundles
ElizaPrefrences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
