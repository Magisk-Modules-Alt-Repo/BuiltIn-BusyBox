#!/system/bin/sh

# Magisk Module: Magisk built-in BusyBox v1.0.4
# Copyright (c) zgfg @ xda, 2022-
# GitHub source: https://github.com/zgfg/BuiltIn-BusyBox

# Module's own path (local path)
MODDIR=${0%/*}

# System XBIN path
BINDIR=/system/bin
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

# List provided applets
Applets=$($MAGISKBBBIN --list)
Applets="$Applets"$'\n'"$BBBIN"

# Create local symlinks for busybox applets
mkdir -p $BBDIR
cd $BBDIR
for Applet in $Applets
do
  # Skip if applet already found in the path
  Check=$(which $Applet)
  if [ -z "$Check" ]
  then
	# Create symlink
    ln -s $MAGISKBBBIN $Applet
  fi
done
