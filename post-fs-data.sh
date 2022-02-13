MODDIR=${0%/*}
BBDIR=$MODDIR/system/xbin
BBBIN=$BBDIR/busybox

mkdir -p $BBDIR
cp /data/adb/magisk/busybox $BBBIN
$BBBIN --install -s $BBDIR
