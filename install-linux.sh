#!/bin/bash
#
# install-linux.sh
#
# Copies the built applications into ~/AccessibleApps, which is laid out as:
#
#   ~/AccessibleApps/bin/    executables, and the .ini files they load
#   ~/AccessibleApps/data/   databases, journals and message templates
#
# The ini files live in bin/ because that is where the apps look for them
# (after ~/TrumptonApps and their own home folder).  Their paths point at
# data/ instead of the default ~/TrumptonApps folder.
#
# Run this after dobuildlin.sh.  Re-running it copies only the executables
# that have changed.  Existing ini files are never overwritten.
#

SCRIPTDIR="$(cd "$(dirname "$0")" && pwd)"
INSTALLDIR="$HOME/AccessibleApps"
BINDIR="$INSTALLDIR/bin"
DATADIR="$INSTALLDIR/data"
EXAMPLES="$SCRIPTDIR/deploy/packages/com.trumpton.base.exampleconfiguration/data/ExampleConfiguration"

# Executables to install (built into build/<app>/<app> by dobuildlin.sh)
APPS="ContactManager CopyFiles EasyNotepad EncPad EncryptFolder GoogleFetch KeyBackup ParseWeb"

# Apps that load an ini file from their own folder
INIAPPS="ContactManager EasyNotepad ParseWeb"


#
# Create the folder layout
#
make_folders()
{
    mkdir -p "$BINDIR" "$DATADIR/ContactManager" "$DATADIR/EasyNotepad" || exit 1
}


#
# Copy each executable that is new or has changed since the last install
#
install_executables()
{
    local app src dst
    local missing=0

    echo "Executables:"
    for app in $APPS; do
        src="$SCRIPTDIR/build/$app/$app"
        dst="$BINDIR/$app"

        if [ ! -f "$src" ]; then
            echo "  $app: not built (run dobuildlin.sh $app), skipped"
            missing=1
            continue
        fi

        if [ ! -f "$dst" ]; then
            install -m 755 "$src" "$dst" || exit 1
            echo "  $app: installed"
        elif cmp -s "$src" "$dst"; then
            echo "  $app: unchanged"
        else
            install -m 755 "$src" "$dst" || exit 1
            echo "  $app: updated"
        fi
    done

    if [ $missing -eq 1 ]; then
        echo "  Some applications are not built.  Run ./dobuildlin.sh all to build them."
    fi
}


#
# Create ini files from the example configuration, unless one already exists.
# $CONFIG (~/TrumptonApps in the examples) becomes $HOME/AccessibleApps/data.
# The apps expand $HOME themselves when they read the file.
#
install_ini_files()
{
    local app dst

    echo "Ini files:"
    for app in $INIAPPS; do
        dst="$BINDIR/$app.ini"

        if [ -f "$dst" ]; then
            echo "  $app.ini: kept existing file"
            continue
        fi

        if [ ! -f "$EXAMPLES/$app.ini" ]; then
            echo "  $app.ini: no example found, skipped"
            continue
        fi

        # Leave the h1..hN help lines describing the variables unchanged
        sed '/^h[0-9]*=/!s#\$CONFIG#$HOME/AccessibleApps/data#g' "$EXAMPLES/$app.ini" > "$dst" || exit 1
        echo "  $app.ini: created from the example"
    done

    # ContactManager needs its message templates in its data folder
    if [ -d "$EXAMPLES/ContactManager/messages" ]; then
        mkdir -p "$DATADIR/ContactManager/messages"
        for f in "$EXAMPLES/ContactManager/messages/"*; do
            [ -e "$DATADIR/ContactManager/messages/$(basename "$f")" ] || cp "$f" "$DATADIR/ContactManager/messages/"
        done
    fi
}


#
# The apps check ~/TrumptonApps before bin/, so warn about any file there
#
warn_overrides()
{
    local f
    for f in "$HOME/TrumptonApps/ContactManager.ini" \
             "$HOME/ContactManager/ContactManager.ini" \
             "$HOME/TrumptonApps/EasyNotepad.ini" \
             "$HOME/EasyNotepad/EasyNotepad.ini" \
             "$HOME/TrumptonApps/ParseWeb.ini"; do
        if [ -f "$f" ]; then
            echo "WARNING: $f will be used in preference to $BINDIR"
        fi
    done
}


make_folders
install_executables
install_ini_files
warn_overrides

echo ""
echo "Installed to $INSTALLDIR"
echo "Run the programs from $BINDIR"
