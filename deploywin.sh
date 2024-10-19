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

echo "deploywin - transferring CopyFiles.exe"

mkdir -p deploy/packages/com.trumpton.base/data/bin
mkdir -p deploy/packages/com.trumpton.base/data/doc

cp -f ${COPYFILES}/CopyFiles.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT CopyFiles.exe)


#
# ContactManager
#

echo "deploywin - transferring ContactManager.exe"

CMVER=$(cat ${CONTACTMANAGER}/../version.txt | grep GITHASH | cut -d\" -f2)
CMDAT=$(cat ${CONTACTMANAGER}/../version.txt | grep BUILDDATE | cut -d\" -f2)
CMDIR=deploy/packages/com.trumpton.base.contactmanager
rm -f $CMDIR/meta/package.xml
cat $CMDIR/meta/package.src | sed -e "s/RELEASEVERSION/$CMVER/g" | sed -e "s/RELEASEDATE/$CMDAT/g" > $CMDIR/meta/package.xml

mkdir -p $CMDIR/data/bin
cp -f ${CONTACTMANAGER}/ContactManager.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT ContactManager.exe)
mv deploy/packages/com.trumpton.base/data/bin/ContactManager.exe deploy/packages/com.trumpton.base.contactmanager/data/bin


#
# EasyNotepad
#

echo "deploywin - transferring EasyNotepad.exe"

ENVER=$(cat ${CONTACTMANAGER}/../version.txt | grep GITHASH | cut -d\" -f2)
ENDAT=$(cat ${CONTACTMANAGER}/../version.txt | grep BUILDDATE | cut -d\" -f2)
ENDIR=deploy/packages/com.trumpton.base.easynotepad
rm -f $ENDIR/meta/package.xml
cat $ENDIR/meta/package.src | sed -e "s/RELEASEVERSION/$ENVER/g" | sed -e "s/RELEASEDATE/$ENDAT/g" > $ENDIR/meta/package.xml

mkdir -p $ENDIR/data/bin
cp -f ${EASYNOTEPAD}/EasyNotepad.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT EasyNotepad.exe)
mv deploy/packages/com.trumpton.base/data/bin/EasyNotepad.exe deploy/packages/com.trumpton.base.easynotepad/data/bin


#
# ParseWeb
#

echo "deploywin - transferring ParseWeb.exe"

PWVER=$(cat ${PARSEWEB}/../version.txt | grep GITHASH | cut -d\" -f2)
PWDAT=$(cat ${PARSEWEB}/../version.txt | grep BUILDDATE | cut -d\" -f2)
PWDIR=deploy/packages/com.trumpton.base.parseweb
rm -r $PWDIR/meta/package.xml
cat $PWDIR/meta/package.src | sed -e "s/RELEASEVERSION/$PWVER/g" | sed -e "s/RELEASEDATE/$PWDAT/g" > $PWDIR/meta/package.xml

mkdir -p $PWDIR/data/bin
cp -f ${PARSEWEB}/ParseWeb.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT ParseWeb.exe)
mv deploy/packages/com.trumpton.base/data/bin/ParseWeb.exe deploy/packages/com.trumpton.base.parseweb/data/bin


#
# EncryptFolder
#

echo "deploywin - transferring EncryptFolder.exe"

EFVER=$(cat ${ENCRYPTFOLDER}/../version.txt | grep GITHASH | cut -d\" -f2)
EFDAT=$(cat ${ENCRYPTFOLDER}/../version.txt | grep BUILDDATE | cut -d\" -f2)
EFDIR=deploy/packages/com.trumpton.base.encryptfolder
rm -r $EFDIR/meta/package.xml
cat $EFDIR/meta/package.src | sed -e "s/RELEASEVERSION/$EFVER/g" | sed -e "s/RELEASEDATE/$EFDAT/g" > $EFDIR/meta/package.xml

mkdir -p $EFDIR/data/bin
cp -f ${ENCRYPTFOLDER}/EncryptFolder.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT EncryptFolder.exe)
mv deploy/packages/com.trumpton.base/data/bin/EncryptFolder.exe ${EFDIR}/data/bin

#
# KeyBackup
#

echo "deploywin - transferring KeyBackup.exe"

KBVER=$(cat ${KEYBACKUP}/../version.txt | grep GITHASH | cut -d\" -f2)
KBDAT=$(cat ${KEYBACKUP}/../version.txt | grep BUILDDATE | cut -d\" -f2)
KBDIR=deploy/packages/com.trumpton.base.keybackup
rm -r $KBDIR/meta/package.xml
cat $KBDIR/meta/package.src | sed -e "s/RELEASEVERSION/$KBVER/g" | sed -e "s/RELEASEDATE/$KBDAT/g" > $KBDIR/meta/package.xml

mkdir -p $KBDIR/data/bin
cp -f ${KEYBACKUP}/KeyBackup.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT KeyBackup.exe)
mv deploy/packages/com.trumpton.base/data/bin/KeyBackup.exe ${KBDIR}/data/bin


#
# EncPad
#

echo "deploywin - transferring EncPad.exe"

EPVER=$(cat ${ENCPAD}/../version.txt | grep GITHASH | cut -d\" -f2)
EPDAT=$(cat ${ENCPAD}/../version.txt | grep BUILDDATE | cut -d\" -f2)
EPDIR=deploy/packages/com.trumpton.base.encpad
rm -r $EPDIR/meta/package.xml
cat $EPDIR/meta/package.src | sed -e "s/RELEASEVERSION/$EPVER/g" | sed -e "s/RELEASEDATE/$EPDAT/g" > $EPDIR/meta/package.xml

mkdir -p $EPDIR/data/bin
cp -f ${ENCPAD}/EncPad.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT EncPad.exe)
mv deploy/packages/com.trumpton.base/data/bin/EncPad.exe ${EPDIR}/data/bin


#
# GoogleFetch
#

echo "deploywin - transferring GoogleFetch.exe"

GFVER=$(cat ${GOOGLEFETCH}/../version.txt | grep GITHASH | cut -d\" -f2)
GFDAT=$(cat ${GOOGLEFETCH}/../version.txt | grep BUILDDATE | cut -d\" -f2)
GFDIR=deploy/packages/com.trumpton.base.googlefetch
rm -r $GFDIR/meta/package.xml
cat $GFDIR/meta/package.src | sed -e "s/RELEASEVERSION/$GFVER/g" | sed -e "s/RELEASEDATE/$GFDAT/g" > $GFDIR/meta/package.xml

mkdir -p $GFDIR/data/bin
cp -f ${GOOGLEFETCH}/GoogleFetch.exe deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; $WINDEPLOYQT GoogleFetch.exe)
mv deploy/packages/com.trumpton.base/data/bin/GoogleFetch.exe ${GFDIR}/data/bin


#
# Transfer additional DLLs and EXEs
#

echo "deploywin - transferring DLLs and EXEs"

cp -R deploy/src/contactmanager/* deploy/packages/com.trumpton.base.contactmanager/data
cp -R deploy/src/easynotepad/* deploy/packages/com.trumpton.base.easynotepad/data

#
# Transfer SSL files, not detected by the $WINDEPLOYQT program
#

echo "deploywin - transferring SSL Files"

cp -R deploy/src/openssl64/* deploy/packages/com.trumpton.base/data

#
# Generate offline installer
#

echo "deploywin - Building Offline Installer"

${BINARYCREATOR} --offline-only -p deploy/packages -c deploy/config/config-win64-${QTVERSION}.xml repository/${APPNAME}OfflineInstaller.exe

#
# Generate online installer
#

echo "deploywin - Building Online Installer"

${BINARYCREATOR} --online-only -p deploy/packages -c deploy/config/config-win64-${QTVERSION}.xml repository/${APPNAME}Installer.exe

#
# Generate online packages
#

echo "deploywin - Building Online Packages"

${REPOGEN} -p deploy/packages repository/${REPONAME}-win64-${QTVERSION}


