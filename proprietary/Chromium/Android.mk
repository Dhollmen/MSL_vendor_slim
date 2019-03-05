# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH:= $(call my-dir)

# Install package

include $(CLEAR_VARS)
LOCAL_MODULE := Chromium
LOCAL_MODULE_OWNER := Chromium
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := platform
include $(BUILD_PREBUILT)

# Install libraries

include $(CLEAR_VARS)
LOCAL_MODULE := libchrome
LOCAL_MODULE_OWNER := Chromium
LOCAL_MODULE_SUFFIX := .so
LOCAL_SRC_FILES := lib/arm/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_STRIP_MODULE := true
LOCAL_PACK_MODULE_RELOCATIONS := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libchromium_android_linker
LOCAL_MODULE_OWNER := Chromium
LOCAL_MODULE_SUFFIX := .so
LOCAL_SRC_FILES := lib/arm/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_STRIP_MODULE := true
LOCAL_PACK_MODULE_RELOCATIONS := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libcrashpad_handler
LOCAL_MODULE_OWNER := Chromium
LOCAL_MODULE_SUFFIX := .so
LOCAL_SRC_FILES := lib/arm/$(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_STRIP_MODULE := true
LOCAL_PACK_MODULE_RELOCATIONS := false
include $(BUILD_PREBUILT)

# Create SymLinks

CROMIUM_SYSMLINK :=  $(TARGET_OUT)/app/Chromium/lib/arm

LIBCHROME_SYMLINK_1 := $(CROMIUM_SYSMLINK)/libchrome.so
$(LIBCHROME_SYMLINK_1): LIBCHROME_FILE_1 := /system/lib/libchrome.so
$(LIBCHROME_SYMLINK_1): $(LOCAL_INSTALLED_MODULE) $(LOCAL_PATH)/Android.mk
	@echo "Symlink: $@ -> $(LIBCHROME_FILE_1)"
	@mkdir -p $(CROMIUM_SYSMLINK)
	@rm -f $@
	$(hide) ln -fs $(LIBCHROME_FILE_1) $@

ALL_DEFAULT_INSTALLED_MODULES += $(LIBCHROME_SYMLINK_1)
all_modules: $(LIBCHROME_SYMLINK_1)

LIBCHROME_SYMLINK_2 := $(CROMIUM_SYSMLINK)/libchromium_android_linker.so
$(LIBCHROME_SYMLINK_2): LIBCHROME_FILE_2 := /system/lib/libchromium_android_linker.so
$(LIBCHROME_SYMLINK_2): $(LOCAL_INSTALLED_MODULE) $(LOCAL_PATH)/Android.mk
	@echo "Symlink: $@ -> $(LIBCHROME_FILE_2)"
	@mkdir -p $(CROMIUM_SYSMLINK)
	@rm -f $@
	$(hide) ln -fs $(LIBCHROME_FILE_2) $@

ALL_DEFAULT_INSTALLED_MODULES += $(LIBCHROME_SYMLINK_2)
all_modules: $(LIBCHROME_SYMLINK_2)

LIBCHROME_SYMLINK_3 := $(CROMIUM_SYSMLINK)/libcrashpad_handler.so
$(LIBCHROME_SYMLINK_3): LIBCHROME_FILE_3 := /system/lib/libcrashpad_handler.so
$(LIBCHROME_SYMLINK_3): $(LOCAL_INSTALLED_MODULE) $(LOCAL_PATH)/Android.mk
	@echo "Symlink: $@ -> $(LIBCHROME_FILE_3)"
	@mkdir -p $(CROMIUM_SYSMLINK)
	@rm -f $@
	$(hide) ln -fs $(LIBCHROME_FILE_3) $@

ALL_DEFAULT_INSTALLED_MODULES += $(LIBCHROME_SYMLINK_3)
all_modules: $(LIBCHROME_SYMLINK_3)
