#
# Copyright (C) 2018 The MoKee Open Source Project
#
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
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),oscar)
include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

IMS_LIBS := libimscamera_jni.so libimsmedia_jni.so
IMS_SYMLINKS := $(addprefix $(TARGET_OUT_APPS)/ims/lib/arm64/,$(notdir $(IMS_LIBS)))
$(IMS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "IMS lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(IMS_SYMLINKS)

RFS_MSM_ADSP_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/adsp/
$(RFS_MSM_ADSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM ADSP folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/lpass $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/adsp $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MSM_MPSS_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/mpss/
$(RFS_MSM_MPSS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM MPSS folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/modem $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/mpss $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

RFS_MSM_SLPI_SYMLINKS := $(TARGET_OUT_VENDOR)/rfs/msm/slpi/
$(RFS_MSM_SLPI_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM SLPI folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly/vendor
	$(hide) ln -sf /data/vendor/tombstones/rfs/modem $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/slpi $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware
	$(hide) ln -sf /vendor/firmware $@/readonly/vendor/firmware

ALL_DEFAULT_INSTALLED_MODULES += $(RFS_MSM_ADSP_SYMLINKS) $(RFS_MSM_MPSS_SYMLINKS) $(RFS_MSM_SLPI_SYMLINKS)

WCNSS_INI_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/prima/WCNSS_qcom_cfg.ini
$(WCNSS_INI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS config ini link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /data/misc/wifi/$(notdir $@) $@

WCNSS_NV_FILES := WCNSS_qcom_wlan_nv.bin WCNSS_wlan_dictionary.dat
WCNSS_NV_SYMLINK := $(addprefix $(TARGET_OUT_VENDOR)/firmware/wlan/prima/,$(notdir $(WCNSS_NV_FILES)))
$(WCNSS_NV_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS NV link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/etc/wifi/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_INI_SYMLINK) $(WCNSS_NV_SYMLINK)

GOODIXFP_IMGS := goodixfp.b00 goodixfp.b01 goodixfp.b02 goodixfp.b03 \
                 goodixfp.b04 goodixfp.b05 goodixfp.b06 goodixfp.mdt
GOODIXFP_SYMLINK := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(GOODIXFP_IMGS)))
$(GOODIXFP_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Goodix images link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(GOODIXFP_SYMLINK)

endif
