#!/bin/sh

if [ ! -f buildvars.inc ]; then
	echo "Creating a default buildvars.inc.  Please edit / check this file and re-run"
	cp src/buildvars.example.inc buildvars.inc
	exit
fi

source ./buildvars.inc

PATH=${QTHOME}/bin:${QTINST}/bin:${PATH}

# Clear Old Files

rm -rf repository/*
rm -rf deploy/packages/com.trumpton.base/data/bin/*
rm -f deploy/packages/com.trumpton.base.contactmanager/data/bin/${CONTACTMANAGER}
rm -f deploy/packages/com.trumpton.base.easynotepad/data/bin/${EASYNOTEPAD}
rm -f deploy/packages/com.trumpton.base.parseweb/data/bin/${PARSEWEB}

# Transfer Executable

mkdir -p deploy/packages/com.trumpton.base/data/bin

mkdir -p deploy/packages/com.trumpton.base.contactmanager/data/bin
cp -f ${CONTACTMANAGER} deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; windeployqt.exe ${CONTACTMANAGER}.exe)
mv deploy/packages/com.trumpton.base/data/bin/${CONTACTMANAGER}.exe deploy/packages/com.trumpton.base.contactmanager/data/bin

mkdir -p deploy/packages/com.trumpton.base.easynotepad/data/bin
cp -f ${EASYNOTEPAD} deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; windeployqt.exe ${EASYNOTEPAD}.exe)
mv deploy/packages/com.trumpton.base/data/bin/${EASYNOTEPAD}.exe deploy/packages/com.trumpton.base.easynotepad/data/bin

mkdir -p deploy/packages/com.trumpton.base.parseweb/data/bin
cp -f ${PARSEWEB} deploy/packages/com.trumpton.base/data/bin
(cd deploy/packages/com.trumpton.base/data/bin; windeployqt.exe ${PARSEWEB}.exe)
mv deploy/packages/com.trumpton.base/data/bin/${PARSEWEB}.exe deploy/packages/com.trumpton.base.parseweb/data/bin


# Generate offline installer

binarycreator.exe --offline-only -p deploy/packages -c deploy/config/config-win64-${QTVERSION}.xml repository/${APPNAME}OfflineInstaller.exe

# Generate online installer

binarycreator.exe --online-only -p deploy/packages -c deploy/config/config-win64-${QTVERSION}.xml repository/${APPNAME}Installer.exe

# Generate online packages

repogen.exe -p deploy/packages repository/${REPONAME}-win64-${QTVERSION}


