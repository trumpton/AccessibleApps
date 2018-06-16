
default:
	echo "make linux | win32 | clean"

clean:
	rm -rf repository/*

linux: envcheck linux-installer linux-repo linux-offline-installer

win32: envcheck win32-installer win32-repo win32-offline-installer

envcheck:
ifndef QTVERSION
	$(error QTVERSION variable not set, for example QTVERSION=5.9.5)
endif

linux-offline-installer:
	binarycreator --offline-only -p packages -c config/config-linux-$(QTVERSION).xml repository/TrumptonAppsOfflineInstaller.bin

linux-installer:
	binarycreator --online-only -p packages -c config/config-linux-$(QTVERSION).xml repository/TrumptonAppsInstaller.bin

linux-repo:
	repogen -p packages repository/trumptonapps-linux-$(QTVERSION)

win32-offline-installer:
	binarycreator.exe --offline-only -p packages -c config/config-win32-$(QTVERSION).xml repository/TrumptonAppsOfflineInstaller.exe

win32-installer:
	binarycreator.exe --online-only -p packages -c config/config-win32-$(QTVERSION).xml repository/TrumptonAppsInstaller.exe

win32-repo:
	repogen -p packages repository/trumptonapps-win32-$(QTVERSION)


