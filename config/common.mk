PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/slim/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/slim/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/slim/prebuilt/common/bin/50-rom.sh:system/addon.d/50-rom.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/slim/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Rom's additional init file
PRODUCT_COPY_FILES += \
    vendor/slim/prebuilt/common/etc/init.rom.rc:root/init.rom.rc

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Mkshrc.
PRODUCT_COPY_FILES += \
    vendor/slim/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# An other files
PRODUCT_COPY_FILES += \
    vendor/slim/prebuilt/common/xbin/clean:system/xbin/clean \
    vendor/slim/prebuilt/common/xbin/sysro:system/xbin/sysro \
    vendor/slim/prebuilt/common/xbin/sysrw:system/xbin/sysrw \
    vendor/slim/prebuilt/common/xbin/wget:system/xbin/wget \

# Required packages
PRODUCT_PACKAGES += \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Dolby
PRODUCT_PACKAGES += \
    libswdap \
    libdlbdapstorage

# Media effects
PRODUCT_PACKAGES += \
    com.google.android.media.effects

PRODUCT_COPY_FILES += \
    vendor/slim/proprietary/Media/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml
    
# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra Optional packages
PRODUCT_PACKAGES += \
    LatinIME \
    BluetoothExt \
    Calculator \
    Music \
    SoundRecorder\
    Wallpapers \
    PLauncher \
    Amaze \
    NewPipeYT

# Chromium
PRODUCT_PACKAGES += \
    Chromium 

PRODUCT_COPY_FILES += \
    vendor/slim/proprietary/Chromium/lib/arm/libchrome.so:system/app/Chromium/lib/arm/libchrome.so \
    vendor/slim/proprietary/Chromium/lib/arm/libchromium_android_linker.so:system/app/Chromium/lib/arm/libchromium_android_linker.so \
    vendor/slim/proprietary/Chromium/lib/arm/libcrashpad_handler.so:system/app/Chromium/lib/arm/libcrashpad_handler.so

## Slim Framework
include frameworks/opt/slim/slim_framework.mk

## Slim DayNight theming overlays
include vendor/slim/overlays/overlays.mk

## Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs

WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Default sounds    
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.alarm_alert=Tourmaline.ogg \
    ro.config.notification_sound=Omicron.ogg \
    ro.config.ringtone=Strontium.ogg

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/slim/overlay/common \
    vendor/slim/overlay/dictionaries

# Versioning System
PRODUCT_VERSION_MAJOR = 6.0.1
PRODUCT_VERSION_MINOR = build
PRODUCT_VERSION_MAINTENANCE = 2.1
SLIM_BUILD_TYPE := Dhollmen
SLIM_POSTFIX := -$(shell date +"%Y%m%d")
PLATFORM_VERSION_CODENAME := $(SLIM_BUILD_TYPE)

# Set all versions
SLIM_VERSION := Slim-$(PRODUCT_VERSION_MAJOR)-$(SLIM_BUILD_TYPE)$(SLIM_POSTFIX)
SLIM_MOD_VERSION := Slim-$(SLIM_BUILD)-$(PRODUCT_VERSION_MAJOR)-$(SLIM_BUILD_TYPE)$(SLIM_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    slim.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.slim.version=$(SLIM_VERSION) \
    ro.modversion=$(SLIM_MOD_VERSION) \
    ro.slim.buildtype=$(SLIM_BUILD_TYPE)

EXTENDED_POST_PROCESS_PROPS := vendor/slim/tools/slim_process_props.py
