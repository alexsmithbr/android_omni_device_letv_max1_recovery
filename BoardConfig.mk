# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8994
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := msm8994
TARGET_BOARD_PLATFORM_GPU := qcom-adreno430

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_SMP := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

#
# Parameters for mkbootimg:
#

# mkbootimg --kernel split_img/recovery-zImage 
#           --ramdisk ramdisk-new.cpio.gz
#           --cmdline 'console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 boot_cpus=0-5'
#           --board ''
#           --base ffff8000
#           --pagesize 4096
#           --kernel_offset 00008000
#           --ramdisk_offset 01008000
#           --second_offset 00f08000
#           --tags_offset 00008100
#           --os_version ''
#           --os_patch_level ''
#           --header_version ''
#           --hash sha1
#           --dt split_img/recovery-dtb
#           -o image-new.img
#
# mkbootimg --kernel /home/android_build/android/omnirom_src/out/target/product/max1/kernel
#           --ramdisk /home/android_build/android/omnirom_src/out/target/product/max1/ramdisk-recovery.img
#           --cmdline \"console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 boot_cpus=0-5 selinux=0 buildvariant=eng\"
#           --base 0x00000000
#           --pagesize 4096
#           --dt /home/android_build/android/omnirom_src/out/target/product/max1/dt.img
#           --os_version 7.1.2
#           --os_patch_level 2017-11-06
#           --output /home/android_build/android/omnirom_src/out/target/product/max1/recovery.img
#           --id

# Parameter --cmdline
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 boot_cpus=0-5 selinux=0
# Parameter --base
BOARD_KERNEL_BASE := 0x00008000
# Parameter --pagesize
BOARD_KERNEL_PAGESIZE := 4096
# This is not parameter --ramdisk_offset. See build/core/Makefile
# and look for BOARD_RAMDISK_OFFSET
BOARD_RAMDISK_OFFSET := 0x01008000

# The following parameters must be passed directly to mkbootimg
# Parameter --kernel_offset
# Parameter --ramdisk_offset
# Parameter --second_offset
# Parameter --tags_offset
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x0008000 --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --second_offset 0x00f08000 --tags_offset 0x00008100

# prebuilt kernel
#TARGET_PREBUILT_KERNEL := device/letv/max1/kernel
# else uncomment below to build from sauce
TARGET_KERNEL_SOURCE := kernel/letv/msm8994
TARGET_KERNEL_CONFIG := max1-perf_defconfig
# build uncompressed with dtb attached
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_USES_UNCOMPRESSED_KERNEL := true
BOARD_KERNEL_SEPARATED_DT := true
TARGET_CUSTOM_DTBTOOL := dtbToolV3

# FIXME: AlexSmith - Configure vendor init. Not sure this is needed.
#TARGET_INIT_VENDOR_LIB := libinit_msm
#TARGET_LIBINIT_DEFINES_FILE := device/letv/max1/init/init_max1.cpp

TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/

BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 805306368
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57906019840
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_HAS_NO_SELECT_BUTTON := true

# AlexSmith - see if USB comes up with this. Files using this variable:
# find \( -name "*.mk" -or -name "Makefile" \) -exec grep -H BOARD_USES_QCOM {} \;
# ./vendor/qcom/opensource_dataservices/Android.mk:ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
# ./build/core/qcom_target.mk:ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
# ./hardware/qcom/keymaster/Android.mk:ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
#
# It compiles rmnet (https://www.kernel.org/doc/Documentation/networking/rmnet.txt), datatop
# and sockev.
# 

BOARD_USES_QCOM_HARDWARE := true

# twrp
TW_THEME := portrait_hdpi
TW_NO_USB_STORAGE := true
#TW_INCLUDE_CRYPTO := true
BOARD_SUPPRESS_SECURE_ERASE := true
RECOVERY_SDCARD_ON_DATA := true
BOARD_HAS_NO_REAL_SDCARD := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
