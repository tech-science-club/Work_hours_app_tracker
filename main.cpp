//#include <QGuiApplication>                  //qtcharts does not work with this module, take a look here in the docs: https://doc.qt.io/archives/qt-5.15/qtcharts-qmlmodule.html#:~:text=Note%3A%20Since,with%20QApplication.
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSurfaceFormat>
#include <QThread>
#include "MainWindow.h"
#include <QLoggingCategory>
#include <QFontDatabase>

int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    QFontDatabase::addApplicationFont(":/fonts/Square721_BT.ttf");
    QFontDatabase::addApplicationFont(":/fonts/Candara.ttf");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    MainWindow mv;
    engine.rootContext()->setContextProperty("mainwindow", &mv);
    engine.loadFromModule("WH", "Main");
    // Load fonts

    return app.exec();
}
