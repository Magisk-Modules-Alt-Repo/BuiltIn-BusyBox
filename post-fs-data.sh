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

# Clean-up local XBIN and BIN paths
rm -rf $BBXBINDIR
rm -rf $BBBINDIR

# busybox binary
BBBIN=busybox
MAGISKBBBIN=/data/adb/magisk/$BBBIN

# Install and list busybox applets using TMP dir
TMPDIR=$MODDIR/tmp
rm -rf $TMPDIR
mkdir -p $TMPDIR
$MAGISKBBBIN --install -s $TMPDIR
Applets=$(ls $TMPDIR)
rm -rf $TMPDIR

# Copy the Magisk built-in busybox locally
mkdir -p $BBDIR
cd $BBDIR
cp $MAGISKBBBIN $BBBIN

# Create symlinks for applets
for Applet in $Applets
do
  # Skip if applet already found in the path
  Check=$(which $Applet)
  if [ -z "$Check" ]
  then
    ln -s $BBBIN $Applet
  fi
done
