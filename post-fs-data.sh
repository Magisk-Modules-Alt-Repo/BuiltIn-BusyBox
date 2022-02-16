# Module's own path (local path)
MODDIR=${0%/*}

# System XBIN path
XBINDIR=/system/xbin

# Local XBIN and (or) BIN paths for mounting
BBXBINDIR=$MODDIR$XBINDIR
BBBINDIR=$MODDIR/system/bin

# Use local XBIN path if System XBIN path exists, otherwise use local BIN path
if [ -d $XBINDIR ]
then
  BBDIR=$BBXBINDIR
else
  BBDIR=$BBBINDIR
fi

# Local busybox binary path for mounting
BBBIN=$BBDIR/busybox

# Clean-up local XBIN and BIN paths
rm -rf $BBXBINDIR
rm -rf $BBBINDIR

# Create local path for mounting busybox
mkdir -p $BBDIR

# Copy the Magisk built-in busybox locally and install and create symlinks
cp /data/adb/magisk/busybox $BBBIN
$BBBIN --install -s $BBDIR
