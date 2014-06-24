export ARCHS = armv7 armv7s arm64
export SDKVERSION = 7.1
export THEOS_BUILD_DIR = build_dir

include theos/makefiles/common.mk

BUNDLE_NAME = BatteryPercentFS
BatteryPercentFS_FILES = Switch.x
BatteryPercentFS_FRAMEWORKS = UIKit
BatteryPercentFS_LIBRARIES = flipswitch
BatteryPercentFS_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk