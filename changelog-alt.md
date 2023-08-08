#### Coffee
Support development by donating a [coffee](https://zgfg.github.io/PayPal.html)

#### Tip:
For additional applets, install [ToyBox-Ext](https://github.com/Magisk-Modules-Alt-Repo/ToyBox-Ext) module

#### v1.0.7
Instead of Magisk built-in BusyBox, you can also use a busybox binary of your choice (eg, latest NDK `busybox-arm...-selinux`). Copy the binary renamed as: 
`busybox` to: `/data/adb/modules/BuiltIn-BusyBox` folder and reboot. If binary not working, module will delete the file and fall-back to the Magisk built-in busybox binary

#### v1.0.6
Service fix for v1.0.5 (crashes and bootloops on some devices)

#### v1.0.5
Prefer BusyBox over ToyBox applets for the common applets (when both modules are installed)

#### v1.0.4
Symlink directly to the Magisk built-in busybox

#### v1.0.3
Create symlinks only for applets not found in the path

#### v1.0.2
Install to /system/bin if /system/xbin does not exist

#### v1.0.1
Released at Alt Repository

#### v1.0.0
Initial version - Systemless BusyBox installing by the Magisk built-in busybox binary
