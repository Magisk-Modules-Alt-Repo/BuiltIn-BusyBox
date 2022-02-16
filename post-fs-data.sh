MODDIR=${0%/*}

XBINDIR=/system/xbin
BBXBINDIR=$MODDIR$XBINDIR
BBBINDIR=$MODDIR/system/bin

if [ -d $XBINDIR ]
then
  BBDIR=$BBXBINDIR
else
  BBDIR=$BBBINDIR
fi
BBBIN=$BBDIR/busybox

rm -rf $BBXBINDIR
rm -rf $BBBINDIR
mkdir -p $BBDIR

cp /data/adb/magisk/busybox $BBBIN
$BBBIN --install -s $BBDIR
