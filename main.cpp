//#include <QGuiApplication>                  //qtcharts does not work with this module, take a look here in the docs: https://doc.qt.io/archives/qt-5.15/qtcharts-qmlmodule.html#:~:text=Note%3A%20Since,with%20QApplication.
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSurfaceFormat>
#include <QThread>
#include "MainWindow.h"
#include <QLoggingCategory>

void PrintDateTime()
{
    while (true) {
        QString dateTimeStr =
            QDateTime::currentDateTime().toString("yyyy-MM-dd HH:mm:ss");

        qDebug() << dateTimeStr;
        QThread::sleep(1);
    }
}

int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    /*-----------declararion of custom class -----------*/
    MainWindow mv;
    engine.rootContext()->setContextProperty("mainwindow", &mv);

    engine.loadFromModule("WH", "Main");

    return app.exec();
}
