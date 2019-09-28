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

BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 boot_cpus=0-5 selinux=0

BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
#BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x0000000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100 --dt device/letv/max1/dt.img

# prebuilt kernel
#TARGET_PREBUILT_KERNEL := device/letv/max1/kernel
# else uncomment below to build from sauce
TARGET_KERNEL_SOURCE := kernel/letv/msm8994
TARGET_KERNEL_CONFIG := max1-perf_defconfig
# build compressed with dtb attached
#BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
# build uncompressed with dtb attached
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_USES_UNCOMPRESSED_KERNEL := true
# build uncompressed without dtb attached
#BOARD_KERNEL_IMAGE_NAME := Image

# FIXME: AlexSmith - see if TARGET_INIT_VENDOR_LIB is needed.
#TARGET_INIT_VENDOR_LIB := libinit_msm
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

# FIXME: AlexSmith - once kernel, init and sepolicy are compiled,
# remove them from PRODUCT_COPY_FILES.
PRODUCT_COPY_FILES += \
	device/letv/max1/extras/init:init \
	device/letv/max1/extras/sepolicy:sepolicy \
	device/letv/max1/extras/file_contexts:file_contexts \
	device/letv/max1/extras/property_contexts:property_contexts \
	device/letv/max1/extras/seapp_contexts:seapp_contexts \
	device/letv/max1/extras/service_contexts:service_contexts \
	device/letv/max1/extras/meu_arq.txt:meu_arq.txt

# twrp
TW_THEME := portrait_hdpi
TW_NO_USB_STORAGE := true
#TW_INCLUDE_CRYPTO := true
BOARD_SUPPRESS_SECURE_ERASE := true
RECOVERY_SDCARD_ON_DATA := true
BOARD_HAS_NO_REAL_SDCARD := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
