MODDIR=${0%/*}

XBINDIR=/system/xbin
if [ -d $XBINDIR ]
then
BBDIR=$MODDIR$XBINDIR
else
BBDIR=$BBDIR/system/bin
fi

BBBIN=$BBDIR/busybox

mkdir -p $BBDIR
cp /data/adb/magisk/busybox $BBBIN
$BBBIN --install -s $BBDIR
