#!/usr/bin/env bash
# Copyright (c) 2016-2019 The coinBit Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

ZEOD=${ZEOD:-$BINDIR/zeod}
ZEOCLI=${ZEOCLI:-$BINDIR/zeo-cli}
ZEOTX=${ZEOTX:-$BINDIR/zeo-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/zeo-wallet}
ZEOQT=${ZEOQT:-$BINDIR/qt/zeo-qt}

[ ! -x $ZEOD ] && echo "$ZEOD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a ZEOVER <<< "$($ZEOCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for zeod if --version-string is not set,
# but has different outcomes for zeo-qt and zeo-cli.
echo "[COPYRIGHT]" > footer.h2m
$ZEOD --version | sed -n '1!p' >> footer.h2m

for cmd in $ZEOD $ZEOCLI $ZEOTX $WALLET_TOOL $ZEOQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${ZEOVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${ZEOVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
