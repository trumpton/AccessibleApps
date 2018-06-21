#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QDebug>
#include <QApplication>
#include <QDir>
#include <QFile>
#include <QCoreApplication>
#include <QMessageBox>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{

    ui->setupUi(this);

    if (QCoreApplication::arguments().size()<3) {
        // Error
        QMessageBox::critical(NULL, "Copy Files", "Usage: CopyFiles SourceDir DestDir") ;
    } else {
        // Run
        show() ;
        QDir src(QCoreApplication::arguments().at(1)) ;
        QDir dst(QCoreApplication::arguments().at(2)) ;
        if (!doCopy(src.absolutePath(), dst.absolutePath(), true)) {
            QMessageBox::critical(NULL, "Copy Files", "Error Copying Files") ;
        }
    }

    qApp->quit() ;
}

MainWindow::~MainWindow()
{
    delete ui;
}

bool MainWindow::doCopy(QString src, QString dst, bool root)
{
    QDir dir(src);
    if (! dir.exists())
        return false;

    if (root) {
        dir.mkpath(dst) ;
        ui->progressBar->setMaximum(dir.entryList(QDir::Files).size() +
                              dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot).size() );
        ui->progressBar->setValue(0) ;
        ui->label->setText(QString("Copying ") + src + QString(" to ") + dst) ;
        qApp->processEvents() ;
    }
    int index=0 ;

    QStringList dirs = dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot) ;
    foreach (QString d, dirs) {
        QString src_path = src + QDir::separator() + d ;
        QString dst_path = dst + QDir::separator() + d ;
        dir.mkpath(dst_path);
        if (!doCopy(src_path, dst_path, false)) return false ;
        if (root) ui->progressBar->setValue(++index) ;
    }

    qInfo() << "Copying Folder" << src << " to " << dst << "\n" ;

    QStringList files = dir.entryList(QDir::Files) ;
    foreach (QString f, files) {
        QString dst_path = dst + QDir::separator() + f ;
        QString src_path = src + QDir::separator() + f ;
        qInfo() << "Copying File" << src_path << " to " << dst_path << "\n" ;
        ui->label->setText(src_path) ;
        qApp->processEvents() ;
        QFile::remove(dst_path) ;
        if (!QFile::copy(src_path, dst_path)) return false ;
        if (root) ui->progressBar->setValue(++index) ;
        qApp->processEvents() ;
    }

    if (root) ui->label->setText("Complete") ;

    return true ;
}
