#!/system/bin/sh

# Magisk Module: Magisk built-in BusyBox v1.0.4
# Copyright (c) zgfg @ xda, 2022-
# GitHub source: https://github.com/zgfg/BuiltIn-BusyBox

# Module's own path (local path)
MODDIR=${0%/*}

# System XBIN path
XBINDIR=/system/xbin
BINDIR=/system/bin

# Local XBIN and (or) BIN paths for mounting
BBXBINDIR=$MODDIR$XBINDIR
BBBINDIR=$MODDIR$BINDIR

# Use local XBIN path if System XBIN path exists, otherwise use local BIN path
if [ -d $XBINDIR ]
then
  SDIR=$XBINDIR
  BBDIR=$BBXBINDIR
else
  SDIR=$BINDIR
  BBDIR=$BBBINDIR			 
fi

# Clean-up local XBIN and BIN paths
rm -rf $BBXBINDIR
rm -rf $BBBINDIR
mkdir -p $BBDIR
cd $BBDIR

# Magisk built-in BusyBox
BBBIN=busybox
MAGISKBBBIN=/data/adb/magisk/$BBBIN

# List busybox applets
Applets="$BBBIN"$'\n'$($MAGISKBBBIN --list)

# Create symlinks for busybox applets
for Applet in $Applets
do
  # Skip if applet already found in the path
  Check=$(which $Applet)
  if [ -z "$Check" ] && [ ! -x "$SDIR/$Applet" ]
  then
	# Create symlink
    ln -s $MAGISKBBBIN $Applet
  fi
done
