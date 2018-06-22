#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

protected:
    void closeEvent(QCloseEvent *event) override;

private slots:
    void autoExecute();

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    bool doabort ;
    Ui::MainWindow *ui;
    bool doCopy(QString src, QString dst, QString outputfolder, bool root) ;
};

#endif // MAINWINDOW_H
