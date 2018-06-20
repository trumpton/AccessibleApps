#!/bin/sh

if [ ! -f buildvars.inc ]; then
	echo "Creating a default buildvars.inc.  Please edit / check this file and re-run"
	cp src/buildvars.example.inc buildvars.inc
	exit
fi

source ./buildvars.inc

PATH=${QTHOME}/bin:${QTINST}/bin:${PATH}

#
# Clear Old Files
#

rm -rf repository/*
rm -rf deploy/packages/com.trumpton.base/data/bin/*
rm -rf deploy/packages/com.trumpton.base/data/doc/*

rm -f deploy/packages/com.trumpton.base.contactmanager/data/bin/*
rm -f deploy/packages/com.trumpton.base.easynotepad/data/bin/*
rm -f deploy/packages/com.trumpton.base.parseweb/data/bin/*

#
# Transfer Executable
#

mkdir -p deploy/packages/com.trumpton.base/data/bin
mkdir -p deploy/packages/com.trumpton.base/data/doc

mkdir -p deploy/packages/com.trumpton.base.contactmanager/data/bin
cp -f ${CONTACTMANAGER}/ContactManager.exe/ deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; windeployqt.exe ContactManager.exe)
mv deploy/packages/com.trumpton.base/data/bin/ContactManager.exe deploy/packages/com.trumpton.base.contactmanager/data/bin

mkdir -p deploy/packages/com.trumpton.base.easynotepad/data/bin
cp -f ${EASYNOTEPAD}/EasyNotepad.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; windeployqt.exe EasyNotepad.exe)
mv deploy/packages/com.trumpton.base/data/bin/EasyNotepad.exe deploy/packages/com.trumpton.base.easynotepad/data/bin

mkdir -p deploy/packages/com.trumpton.base.parseweb/data/bin
cp -f ${PARSEWEB}/ParseWeb.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; windeployqt.exe ParseWeb.exe)
mv deploy/packages/com.trumpton.base/data/bin/ParseWeb.exe deploy/packages/com.trumpton.base.parseweb/data/bin

#
# Transfer additional DLLs and EXEs
#

cp -R src/contactmanager/* deploy/packages/com.trumpton.base.contactmanager/data
cp -R src/easynotepad/* deploy/packages/com.trumpton.base.easynotepad/data

#
# Transfer SSL files, not detected by the windeployqt.exe program
#

cp src/openssl64.bin/*.dll deploy/packages/com.trumpton.base/data/bin
cp src/openssl64.bin/OpenSSL_License.txt deploy/packages/com.trumpton.base/data/doc

#
# Generate offline installer
#

binarycreator.exe --offline-only -p deploy/packages -c deploy/config/config-win64-${QTVERSION}.xml repository/${APPNAME}OfflineInstaller.exe

#
# Generate online installer
#

binarycreator.exe --online-only -p deploy/packages -c deploy/config/config-win64-${QTVERSION}.xml repository/${APPNAME}Installer.exe

# Generate online packages

repogen.exe -p deploy/packages repository/${REPONAME}-win64-${QTVERSION}


