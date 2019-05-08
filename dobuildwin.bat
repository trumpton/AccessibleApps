rem @echo off
rem
rem Microsoft Visual C++ / QT Build Script for Accessible Apps
rem


set AA=d:\Projects\AccessibleApps
set QMAKE=E:\Qt5.10.1\5.10.1\msvc2015_64\bin\qmake.exe
set WINDEPLOYQT=E:\Qt5.10.1\5.10.1\msvc2015_64\bin\windeployqt.exe

mkdir build
mkdir build\ContactManager
mkdir build\CopyFiles
mkdir build\EasyNotepad
mkdir build\EncPad
mkdir build\EncryptFolder
mkdir build\GoogleFetch
mkdir build\KeyBackup
mkdir build\ParseWeb
mkdir bin

rem
rem Contact Manager
rem

rem d:\projects\accessibleapps\contactmanager\googleaccess.h(5): fatal error C1083:
rem Cannot open include file: 'QDomElement': No such file or directory

cd %AA%\build\ContactManager
nmake clean
%QMAKE% %AA%\ContactManager\ContactManager.pro -spec win32-msvc
nmake
copy release\*.exe %AA%\bin
cd %AA%\bin
%WINDEPLOYQT% ContactManager.exe

rem
rem EncPad
rem

cd %AA%\build\EncPad
nmake clean
%QMAKE% %AA%\EncPad\EncPad.pro -spec win32-msvc
nmake
copy release\*.exe %AA%\bin
cd %AA%\bin
%WINDEPLOYQT% EncPad.exe


cd %AA%

