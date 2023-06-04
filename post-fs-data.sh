#!/system/bin/sh

# Magisk Module: Magisk built-in BusyBox v1.0.4
# Copyright (c) zgfg @ xda, 2022-
# GitHub source: https://github.com/zgfg/BuiltIn-BusyBox

# Module's own path (local path)
MODDIR=${0%/*}
cd $MODDIR

# Log for debugging
LogFile="$MODDIR/post-fs-data.log"
exec 2>$LogFile
set -x

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

# ToyBox path
TBDIR="/data/adb/modules/ToyBox-Ext/$SDIR"

# Magisk built-in BusyBox
BB=busybox
BBBIN=/data/adb/magisk/$BB

# List BusyBox applets
Applets="$BB"$'\n'"$($BBBIN --list)"

# Create symlinks for busybox applets
for Applet in $Applets
do
  Target=$SDIR/$Applet
  if [ ! -x $Target ] ||  [ -h $Target ]
  then
    # Create symlink
    ln -s $BBBIN $Applet

    # Remove symlink for ToyBox applet (prefer BusyBox)
    Target=$TBDIR/$Applet
    if [ -h $Target ]
    then
      rm -f $Target
    fi
  fi
done
