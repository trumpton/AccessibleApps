#
# Build script for Linux
#
#

export QT_SELECT=qt5

mkdir -p build
mkdir -p build/ContactManager
mkdir -p build/CopyFiles
mkdir -p build/EasyNotepad
mkdir -p build/EncPad
mkdir -p build/EncryptFolder
mkdir -p build/GoogleFetch
mkdir -p build/KeyBackup
mkdir -p build/ParseWeb

(cd build/ContactManager ; qmake ../../ContactManager/ContactManager.pro; make )
(cd build/CopyFiles ; qmake ../../CopyFiles/CopyFiles.pro; make )
(cd build/EasyNotepad ; qmake ../../EasyNotepad/EasyNotepad.pro; make )
(cd build/EncPad ; qmake ../../EncPad/EncPad.pro; make )
(cd build/EncryptFolder ; qmake ../../EncryptFolder/EncryptFolder.pro; make )
(cd build/GoogleFetch ; qmake ../../GoogleFetch/GoogleFetch.pro; make )
(cd build/KeyBackup ; qmake ../../KeyBackup/KeyBackup.pro; make )
(cd build/ParseWeb ; qmake ../../ParseWeb/ParseWeb.pro; make )

