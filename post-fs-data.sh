#!/system/bin/sh

# Magisk Module: Magisk built-in BusyBox v1.0.7
# Copyright (c) zgfg @ xda, 2022-
# GitHub source: https://github.com/zgfg/BuiltIn-BusyBox

# Module's own path (local path)
MODDIR=${0%/*}

# Log file for debugging
LogFile="$MODDIR/post-fs-data.log"
exec 3>&1 4>&2 2>$LogFile 1>&2
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

# ToyBox-Ext module path
TBDIR="/data/adb/modules/ToyBox-Ext/$SDIR"

# Check for local busybox binary
BB=busybox
BBBIN=$MODDIR/$BB
if [ -f $BBBIN ]
then
  chmod 755 $BBBIN
  if [ $($BBBIN --list | wc -l) -ge 128 ] && [ ! -z "$($BBBIN | head -n 1 | grep -i $BB)" ]
  then
    chcon u:object_r:system_file:s0 $BBBIN
    Applets=$BB$'\n'$($BBBIN --list)
  else
    rm -f $BBBIN
  fi
fi

# Otherwise use Magisk built-in busybox binary
if [ ! -x $BBBIN ]
then
  BBBIN=/data/adb/magisk/$BB
  $BBBIN --list | wc -l
  Applets=$BB$'\n'$($BBBIN --list)
fi

# Create local symlinks for BusyBox applets
for Applet in $Applets
do
  if [ ! -x $SDIR/$Applet ]
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
chmod 755 *
chcon u:object_r:system_file:s0 *

# Log results
ls -lZ $BB
$BBBIN | head -n 1
ls -l | grep $BB | grep ^lr.x | rev | cut -d ' ' -f 3 | rev
ls -l | grep $BB | grep ^lr.x | wc -l

set +x
exec 1>&3 2>&4 3>&- 4>&-
