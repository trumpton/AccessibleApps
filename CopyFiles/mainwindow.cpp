#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QDebug>
#include <QApplication>
#include <QDir>
#include <QFile>
#include <QCoreApplication>
#include <QMessageBox>
#include <QTimer>
#include <QCloseEvent>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    doabort=false ;
    ui->setupUi(this);
    ui->labelFolder->setText("Processing ...") ;
    ui->labelFile->setText("") ;
    ui->progressBar->setValue(0) ;
//    setAttribute(Qt::WA_DeleteOnClose);
    QTimer::singleShot(500, this, SLOT(autoExecute())) ;
}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::autoExecute()
{
    if (QCoreApplication::arguments().size()<3) {

        // Error
        QMessageBox::critical(NULL, "Copy Files", "Usage: CopyFiles SourceDir DestDir") ;

    } else {

        // Run
        QString srcname, dstname ;

        srcname = QCoreApplication::arguments().at(1) ;
        dstname = QCoreApplication::arguments().at(2) ;

        QDir src(srcname) ;
        QDir dst(dstname) ;

        if (!doCopy(src.absolutePath(), dst.absolutePath(), QString(""), true)) {
            QMessageBox::critical(NULL, "Copy Files", "Error Copying Files") ;
        }
    }
     QApplication::exit() ;
}

// Close on 'X'
void MainWindow::closeEvent (QCloseEvent *event)
{
    doabort=true ;
}


// Copy One File / Folder
bool MainWindow::doCopy(QString src, QString dst, QString outputfolder, bool root)
{
    QDir dir(src);
    if (! dir.exists())
        return false;

    if (root) {
        dir.mkpath(dst) ;
        ui->progressBar->setMaximum(dir.entryList(QDir::Files).size() +
                              dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot).size() );
    }

    ui->labelFolder->setText(outputfolder) ;
    qApp->processEvents() ;

    if (!outputfolder.isEmpty()) outputfolder = outputfolder + "/" ;
    int index=0 ;

    QStringList dirs = dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot) ;
    foreach (QString d, dirs) {
        QString src_path = src + QDir::separator() + d ;
        QString dst_path = dst + QDir::separator() + d ;
        dir.mkpath(dst_path);
        if (doabort || !doCopy(src_path, dst_path, outputfolder + d, false)) return false ;
        if (root) ui->progressBar->setValue(++index) ;
    }

    QStringList files = dir.entryList(QDir::Files) ;
    foreach (QString f, files) {
        QString dst_path = dst + QDir::separator() + f ;
        QString src_path = src + QDir::separator() + f ;
        ui->labelFile->setText(f) ;
        qApp->processEvents() ;
        QFile::remove(dst_path) ;
        if (doabort || !QFile::copy(src_path, dst_path)) return false ;
        if (root) ui->progressBar->setValue(++index) ;
        qApp->processEvents() ;
    }

    if (root) {
        ui->labelFolder->setText("Complete") ;
        ui->labelFile->setText("") ;
    }

    return true ;
}
