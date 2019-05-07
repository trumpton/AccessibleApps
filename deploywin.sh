#!/bin/sh

if [ ! -f buildvars.inc ]; then
	echo "Creating a default buildvars.inc.  Please edit / check this file and re-run"
	cp deploy/src/buildvars.example.inc buildvars.inc
	exit
fi

source ./buildvars.inc

PATH=${QTHOME}/bin:${QTINST}/bin:${PATH}
WINDEPLOYQT=${QTHOME}/bin/windeployqt.exe
BINARYCREATOR=${QTINST}/bin/binarycreator.exe
REPOGEN=${QTINST}/bin/repogen.exe

#
# Clear Old Files
#

rm -rf repository/*
rm -rf deploy/packages/com.trumpton.base/data/bin/*
rm -rf deploy/packages/com.trumpton.base/data/doc/*

rm -f deploy/packages/com.trumpton.base.contactmanager/data/bin/*
rm -f deploy/packages/com.trumpton.base.easynotepad/data/bin/*
rm -f deploy/packages/com.trumpton.base.parseweb/data/bin/*
rm -f deploy/packages/com.trumpton.base.encryptfolder/data/bin/*
rm -f deploy/packages/com.trumpton.base.keybackup/data/bin/*
rm -f deploy/packages/com.trumpton.base.encpad/data/bin/*
rm -f deploy/packages/com.trumpton.base.googlefetch/data/bin/*

#
# Transfer Executable
#

mkdir -p deploy/packages/com.trumpton.base/data/bin
mkdir -p deploy/packages/com.trumpton.base/data/doc

cp -f ${COPYFILES}/CopyFiles.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT CopyFiles.exe)


#
# ContactManager
#

CMVER=$(cat ContactManager/version.h | grep BUILDVERSION | cut -d\" -f2)
CMDAT=$(cat ContactManager/version.h | grep BUILDDATE | cut -d\" -f2)
CMDIR=deploy/packages/com.trumpton.base.contactmanager
rm -f $CMDIR/meta/package.xml
cat $CMDIR/meta/package.src | sed -e s/RELEASEVERSION/$CMVER/ | sed -e s/RELEASEDATE/$CMDAT/g > $CMDIR/meta/package.xml

mkdir -p $CMDIR/data/bin
cp -f ${CONTACTMANAGER}/ContactManager.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT ContactManager.exe)
mv deploy/packages/com.trumpton.base/data/bin/ContactManager.exe deploy/packages/com.trumpton.base.contactmanager/data/bin


#
# EasyNotepad
#
ENVER=$(cat EasyNotepad/version.h | grep BUILDVERSION | cut -d\" -f2)
ENDAT=$(cat EasyNotepad/version.h | grep BUILDDATE | cut -d\" -f2)
ENDIR=deploy/packages/com.trumpton.base.easynotepad
rm -f $ENDIR/meta/package.xml
cat $ENDIR/meta/package.src | sed -e s/RELEASEVERSION/$ENVER/ | sed -e s/RELEASEDATE/$ENDAT/g > $ENDIR/meta/package.xml

mkdir -p $ENDIR/data/bin
cp -f ${EASYNOTEPAD}/EasyNotepad.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT EasyNotepad.exe)
mv deploy/packages/com.trumpton.base/data/bin/EasyNotepad.exe deploy/packages/com.trumpton.base.easynotepad/data/bin


#
# ParseWeb
#
PWVER=$(cat ParseWeb/version.h | grep BUILDVERSION | cut -d\" -f2)
PWDAT=$(cat ParseWeb/version.h | grep BUILDDATE | cut -d\" -f2)
PWDIR=deploy/packages/com.trumpton.base.parseweb
rm -r $PWDIR/meta/package.xml
cat $PWDIR/meta/package.src | sed -e s/RELEASEVERSION/$PWVER/ | sed -e s/RELEASEDATE/$PWDAT/g > $PWDIR/meta/package.xml

mkdir -p $PWDIR/data/bin
cp -f ${PARSEWEB}/ParseWeb.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT ParseWeb.exe)
mv deploy/packages/com.trumpton.base/data/bin/ParseWeb.exe deploy/packages/com.trumpton.base.parseweb/data/bin


#
# EncryptFolder
#
EFVER=$(cat EncryptFolder/version.h | grep BUILDVERSION | cut -d\" -f2)
EFDAT=$(cat EncryptFolder/version.h | grep BUILDDATE | cut -d\" -f2)
EFDIR=deploy/packages/com.trumpton.base.encryptfolder
rm -r $EFDIR/meta/package.xml
cat $EFDIR/meta/package.src | sed -e s/RELEASEVERSION/$EFVER/ | sed -e s/RELEASEDATE/$EFDAT/g > $EFDIR/meta/package.xml

mkdir -p $EFDIR/data/bin
cp -f ${ENCRYPTFOLDER}/EncryptFolder.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT EncryptFolder.exe)
mv deploy/packages/com.trumpton.base/data/bin/EncryptFolder.exe ${EFDIR}/data/bin

#
# KeyBackup
#
KBVER=$(cat KeyBackup/version.h | grep BUILDVERSION | cut -d\" -f2)
KBDAT=$(cat KeyBackup/version.h | grep BUILDDATE | cut -d\" -f2)
KBDIR=deploy/packages/com.trumpton.base.keybackup
rm -r $KBDIR/meta/package.xml
cat $KBDIR/meta/package.src | sed -e s/RELEASEVERSION/$KBVER/ | sed -e s/RELEASEDATE/$KBDAT/g > $KBDIR/meta/package.xml

mkdir -p $KBDIR/data/bin
cp -f ${KEYBACKUP}/KeyBackup.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT KeyBackup.exe)
mv deploy/packages/com.trumpton.base/data/bin/KeyBackup.exe ${KBDIR}/data/bin


#
# EncPad
#
EPVER=$(cat EncPad/version.h | grep BUILDVERSION | cut -d\" -f2)
EPDAT=$(cat EncPad/version.h | grep BUILDDATE | cut -d\" -f2)
EPDIR=deploy/packages/com.trumpton.base.encpad
rm -r $EPDIR/meta/package.xml
cat $EPDIR/meta/package.src | sed -e s/RELEASEVERSION/$EPVER/ | sed -e s/RELEASEDATE/$EPDAT/g > $EPDIR/meta/package.xml

mkdir -p $EPDIR/data/bin
cp -f ${ENCPAD}/EncPad.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT EncPad.exe)
mv deploy/packages/com.trumpton.base/data/bin/EncPad.exe ${EPDIR}/data/bin


#
# GoogleFetch
#
GFVER=$(cat GoogleFetch/version.h | grep BUILDVERSION | cut -d\" -f2)
GFDAT=$(cat GoogleFetch/version.h | grep BUILDDATE | cut -d\" -f2)
GFDIR=deploy/packages/com.trumpton.base.googlefetch
rm -r $GFDIR/meta/package.xml
cat $GFDIR/meta/package.src | sed -e s/RELEASEVERSION/$GFVER/ | sed -e s/RELEASEDATE/$GFDAT/g > $GFDIR/meta/package.xml

mkdir -p $GFDIR/data/bin
cp -f ${GOOGLEFETCH}/GoogleFetch.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT GoogleFetch.exe)
mv deploy/packages/com.trumpton.base/data/bin/GoogleFetch.exe ${GFDIR}/data/bin


#
# Transfer additional DLLs and EXEs
#

cp -R deploy/src/contactmanager/* deploy/packages/com.trumpton.base.contactmanager/data
cp -R deploy/src/easynotepad/* deploy/packages/com.trumpton.base.easynotepad/data

#
# Transfer SSL files, not detected by the $WINDEPLOYQT program
#

cp -R deploy/src/openssl64/* deploy/packages/com.trumpton.base/data

#
# Generate offline installer
#

${BINARYCREATOR} --offline-only -p deploy/packages -c deploy/config/config-win64-${QTVERSION}.xml repository/${APPNAME}OfflineInstaller.exe

#
# Generate online installer
#

${BINARYCREATOR} --online-only -p deploy/packages -c deploy/config/config-win64-${QTVERSION}.xml repository/${APPNAME}Installer.exe

#
# Generate online packages
#

${REPOGEN} -p deploy/packages repository/${REPONAME}-win64-${QTVERSION}


