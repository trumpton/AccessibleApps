@echo off

rem
rem edit the following to change the location and version of QT and MSVC
rem (note AA is the location of the AccessibleApps source - normally this folder)
rem

set QTHOME=C:\dev\Qt
set QTVER=6.7.3
set MSVCVER=2019
set AA=%cd%

rem
rem here be dragons
rem 

set PWD=%cd%

call "%QTHOME%\%QTVER%\msvc%MSVCVER%_64\bin\qtenv2.bat"
cd %PWD%
call "C:\Program Files (x86)\Microsoft Visual Studio\%MSVCVER%\Community\VC\Auxiliary\Build\vcvars64.bat"
cd %PWD%

echo ""
echo "Environment Has been set up for QT %QTVER% (in %QTHOME%) and MSVC %MSVCVER%"