# TWRP device tree: LG Tribute Empire (LM-X220PM / mcv1s)

UNTESTED first-pass tree. Generated from dumps of a real LM-X220PM
(stock recovery.img, partition table, fstab, cmdline, build.prop).

## Verified from your device
- MT6750 / ro.product.board mt6755, Android 8.1.0, A-only, ARM32 userspace (kernel 3.18.79)
- Boot header v0, page size 2048, kernel 0x40008000, ramdisk 0x45000000, tags 0x44000000,
  second 0x40f00000 (base 0x40000000), DTB appended to the zImage (68,560 bytes)
- Recovery partition = 22,020,096 bytes; stock kernel 9.1 MB, so the TWRP ramdisk must stay
  under ~12 MB compressed
- Partition names/fstab, /misc = `para`, ext4 for system/vendor/cache/data
- Bootloader state: orange / unlocked

## Guesses to verify on first boot
- Screen pixel format and theme (RGBX_8888, portrait_hdpi)
- Backlight path and USB gadget behavior (legacy android_usb, see recovery/root/init.recovery.mcv1s.rc)
- SD card node (/dev/block/mmcblk1p1)
- /data decryption is NOT included (FDE + Trustonic TEE). Flash from SD card.

## Build (Linux / WSL2, ~100 GB free, 16 GB RAM recommended)
    mkdir ~/twrp && cd ~/twrp
    repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-8.1
    repo sync -c -j8 --force-sync --no-clone-bundle --no-tags
    mkdir -p device/lge && cp -r /path/to/twrp_device_lge_mcv1s device/lge/mcv1s
    source build/envsetup.sh
    lunch omni_mcv1s-eng
    mka recoveryimage

Output: out/target/product/mcv1s/recovery.img  (must be <= 22,020,096 bytes)
If the build errors with a branch or toolchain problem, retry with `-b twrp-9.0`.

## Test safely
    adb reboot bootloader
    fastboot boot recovery.img
Many LG MTK bootloaders do not support `fastboot boot`. If it fails, flash instead:
    fastboot flash recovery recovery.img
and keep your dumped stock recovery.img to restore with the same command.
Back up nvram/nvdata/nvcfg/proinfo/persist/seccfg first.
