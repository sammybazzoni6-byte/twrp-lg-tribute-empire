# TWRP device tree: LG Tribute Empire (LM-X220PM, codename mcv1s)
# MediaTek MT6750 (ro.product.board=mt6755), Android 8.1, A-only, 32-bit userspace.
# Values below were read from the stock recovery.img / device dumps unless marked GUESS.

DEVICE_PATH := device/lge/mcv1s

# Architecture (bootopt=64S3,32N2,32N2 -> 32-bit normal world; abilist=armeabi-v7a,armeabi)
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_SMP := true

# Platform
TARGET_BOARD_PLATFORM := mt6750
TARGET_BOOTLOADER_BOARD_NAME := mt6755
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Kernel: prebuilt stock zImage with appended DTB (no separate dt in boot header)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/zImage-dtb
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,32N2 androidboot.hardware=mcv1s androidboot.selinux=permissive buildvariant=user
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x05000000
BOARD_SECOND_OFFSET := 0x00f00000
BOARD_KERNEL_TAGS_OFFSET := 0x04000000
BOARD_MKBOOTIMG_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --second_offset $(BOARD_SECOND_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)

# Partition sizes (bytes) from /proc/partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 20971520
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 22020096
BOARD_CACHEIMAGE_PARTITION_SIZE := 536870912
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 4798283776
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 536870912
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 9124184064
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SUPPRESS_SECURE_ERASE := true
RECOVERY_SDCARD_ON_DATA := true

# Display / input  (GUESS: verify on first boot)
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TW_THEME := portrait_hdpi
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 120

# TWRP
TW_USE_TOOLBOX := true
TW_INCLUDE_NTFS_3G := true
TW_NO_REBOOT_BOOTLOADER := false
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_DEFAULT_EXTERNAL_STORAGE := true
TW_DEVICE_VERSION := mcv1s-1

# Not enabled: /data decryption (Android 8.1 FDE via Trustonic TEE). Flash zips from the SD card.
# TW_INCLUDE_CRYPTO := true
