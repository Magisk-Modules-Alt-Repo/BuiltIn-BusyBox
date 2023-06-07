#!/system/bin/sh

# Magisk Module: Magisk built-in BusyBox v1.0.6
# Copyright (c) zgfg @ xda, 2022-
# GitHub source: https://github.com/zgfg/BuiltIn-BusyBox

# Module's own path (local path)
MODDIR=${0%/*}

# Log file for debugging
LogFile="$MODDIR/service.log"
exec 2>$LogFile 1>&2
set -x

# Log time
date +%c

# Log Magisk version and magisk --path
magisk -c
magisk --path

# Choose XBIN or BIN path
SDIR=/system/xbin
if [ ! -d $SDIR ]
then
  SDIR=/system/bin
fi
cd $SDIR
pwd

# Log results
ls -l | grep busybox | rev | cut -d ' ' -f 3 | rev
ls -l | grep busybox | wc -l
ls -l | grep toybox | wc -l
ls -l | grep toybox-ext | wc -l
