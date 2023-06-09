#!/system/bin/sh

# Magisk Module: Magisk built-in BusyBox v1.0.6a
# Copyright (c) zgfg @ xda, 2022-
# GitHub source: https://github.com/zgfg/BuiltIn-BusyBox

# Module's own path (local path)
MODDIR=${0%/*}

# Log file for debugging
LogFile="$MODDIR/service.log"
exec 2>$LogFile 1>&2
set -x
date +%c

# Log Magisk version and magisk --path
magisk -c
magisk --path

# Log results for BusyBox
BB=busybox
which $BB
$BB | head -n 1
SDIR=$(which $BB | sed "s,/$BB$,,")
if [ -d $SDIR ]
then
  cd $SDIR
  pwd
  ls -la | grep $BB | grep ^lr.x | rev | cut -d ' ' -f 3 | rev
  ls -la | grep $BB | grep ^lr.x | wc -l
fi

# Log results for ToyBox-Ext
TBEXT=toybox-ext
which $TBEXT
$TBEXT --version
SDIR=$(which $TBEXT | sed "s,/$TBEXT$,,")
if [ -d $SDIR ]
then
  cd $SDIR
  pwd
  ls -la | grep $TBEXT | grep ^lr.x | rev | cut -d ' ' -f 3 | rev
  ls -la | grep $TBEXT | grep ^lr.x | wc -l
fi

# Log results for stock ToyBox
TB=toybox
which $TB
$TB --version
SDIR=$(which $TB | sed "s,/$TB$,,")
if [ -d $SDIR ]
then
  cd $SDIR
  pwd
  ls -la | grep $TB | grep -v $TBEXT | grep ^lr.x | rev | cut -d ' ' -f 3 | rev
  ls -la | grep $TB | grep -v $TBEXT | grep ^lr.x | wc -l
fi
