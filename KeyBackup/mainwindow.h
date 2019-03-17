#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QByteArray>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

    // Read and Write Ini Parameters
    void readIni() ;
    void writeIni() ;

    // Save and Restore Ini Parameters
    bool backupIni() ;
    bool restoreIni() ;

private slots:
    void on_action_Backup_Keys_triggered();

    void on_action_Restore_Keys_triggered();

    void on_actionE_xit_triggered();

private:
    Ui::MainWindow *ui;
    QByteArray encryptedKey ;
    QByteArray encryptedHash ;
    QByteArray passwordHash ;
    QByteArray password ;

    void addLog(QString message) ;


};

#endif // MAINWINDOW_H
