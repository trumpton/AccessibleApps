#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QSettings>
#include <QFileDialog>
#include <QString>

#define sDomain "trumpton.uk"
#define sApplication "TextFileEncryption"


MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    readIni() ;
}

void MainWindow::addLog(QString message)
{
    ui->report->appendPlainText(message) ;
}

void MainWindow::readIni()
{
    QSettings ini(sDomain, sApplication) ;
    encryptedKey=ini.value("A").toByteArray() ;
    encryptedHash=ini.value("B").toByteArray() ;
    passwordHash=ini.value("C").toByteArray() ;
    password=ini.value("D").toByteArray() ;
    addLog("Current Key Parameters:") ;
    addLog(QString("    A: ") + encryptedKey.toHex()) ;
    addLog(QString("    B: ") + encryptedHash.toHex()) ;
    addLog(QString("    C: ") + passwordHash.toHex()) ;
    addLog(QString("    D: ") + password.toHex()) ;
}

void MainWindow::writeIni()
{
    return ;
    QSettings ini(sDomain, sApplication) ;
    ini.setValue("A", encryptedKey) ;
    ini.setValue("B", encryptedHash) ;
    ini.setValue("C", passwordHash) ;
    ini.setValue("D", password) ;
}

bool MainWindow::backupIni()
{
    QFileDialog dlg ;
    QString filename = dlg.getSaveFileName(this, "Save Key Parameters", QString(), QString("*.keysafe")) ;
    if (!filename.isEmpty()) {
        if (filename.right(8).compare(".keysafe")!=0) filename = filename + ".keysafe" ;
        QSettings saveini(filename, QSettings::IniFormat);
        saveini.setValue("A", encryptedKey) ;
        saveini.setValue("B", encryptedHash) ;
        saveini.setValue("C", passwordHash) ;
        saveini.setValue("D", password) ;
        if (saveini.status()==QSettings::NoError) {
            addLog(QString("Backing Up Key Parameters to: ") + filename) ;
            return true ;
        } else {
            addLog(QString("Backing Up Key Parameters failed to write ini file.")) ;
            return false ;
        }
    } else {
        addLog(QString("Backing Up Key Parameters unsuccessful.")) ;
        return false ;
    }
}

bool MainWindow::restoreIni()
{
    QFileDialog dlg ;
    QString filename = dlg.getOpenFileName(this, "Save Key Parameters", QString(), QString("*.keysafe")) ;
    if (!filename.isEmpty()) {
        QSettings loadini(filename, QSettings::IniFormat);
        encryptedKey=loadini.value("A").toByteArray() ;
        encryptedHash=loadini.value("B").toByteArray() ;
        passwordHash=loadini.value("C").toByteArray() ;
        password=loadini.value("D").toByteArray() ;
        if (loadini.status()==QSettings::NoError) {
            addLog(QString("Restoring Key Parameters from: ") + filename) ;
            return true ;
        } else {
            addLog(QString("Restoring Key Parameters failed to read ini file.")) ;
            return false ;
        }
    } else {
        addLog(QString("Restoring Key Parameters unsuccessful.")) ;
        return false ;
    }
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_action_Backup_Keys_triggered()
{
    backupIni() ;
}

void MainWindow::on_action_Restore_Keys_triggered()
{
    if (restoreIni()) {
        writeIni() ;
        readIni() ;
    }
}

void MainWindow::on_actionE_xit_triggered()
{
    // Exit Application
    this->close() ;
}
