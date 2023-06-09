#!/system/bin/sh

# Magisk Module: Magisk built-in BusyBox v1.0.6a
# Copyright (c) zgfg @ xda, 2022-
# GitHub source: https://github.com/zgfg/BuiltIn-BusyBox

# Module's own path (local path)
MODDIR=${0%/*}

# Log file for debugging
LogFile="$MODDIR/post-fs-data.log"
exec 2>$LogFile 1>&2
set -x

# Log Magisk version and magisk --path
magisk -c
magisk --path

# Clean-up old stuff
rm -rf "$MODDIR/system"

# Choose XBIN or BIN path
SDIR=/system/xbin
if [ ! -d $SDIR ]
then
  SDIR=/system/bin
fi
BBDIR=$MODDIR$SDIR
mkdir -p $BBDIR
cd $BBDIR
pwd

# ToyBox-Ext path
TBDIR="/data/adb/modules/ToyBox-Ext/$SDIR"
								   
# Magisk built-in BusyBox
BB=busybox
BBBIN=/data/adb/magisk/$BB

# List BusyBox applets
$BBBIN --list | wc -l
Applets="$BB"$'\n'"$($BBBIN --list)"

# Create local symlinks for BusyBox applets
for Applet in $Applets
do
  Target=$SDIR/$Applet
  if [ ! -x $Target ]
  then
    # Create symlink
    ln -s $BBBIN $Applet

    # Remove local symlink for ToyBox applet (prefer BusyBox)
    Target=$TBDIR/$Applet
    if [ -h $Target ]
    then
      rm -f $Target
    fi
  fi
done

# Log results
ls -l $BB
$BBBIN | head -n 1
ls -l | grep $BB | grep ^lr.x | rev | cut -d ' ' -f 3 | rev
ls -l | grep $BB | grep ^lr.x | wc -l

