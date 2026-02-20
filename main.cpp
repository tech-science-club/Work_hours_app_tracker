//#include <QGuiApplication>                  //qtcharts does not work with this module, take a look here in the docs: https://doc.qt.io/archives/qt-5.15/qtcharts-qmlmodule.html#:~:text=Note%3A%20Since,with%20QApplication.
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSurfaceFormat>
#include <QThread>
#include "MainWindow.h"
#include <QLoggingCategory>
#include <QFontDatabase>

void loadCustomFonts()
{

qDebug() << "=== Loading Custom Fonts ===";

// Load font ONCE
int fontId = QFontDatabase::addApplicationFont("qrc:/assets/fonts/Square721_BT.ttf");

if (fontId == -1) {
    qWarning() << "Failed to load Square721BT.ttf";
    qWarning() << "Font might already be loaded or file not found";
    return;
}

// Query font families for THIS specific font file
QStringList families = QFontDatabase::applicationFontFamilies(fontId);
qDebug() << "✓ Loaded font families:" << families;

// families should contain: ("Square721 BT", "Square721 Cn BT", ...)
}

void debugAvailableFonts()
{
    qDebug() << "\n=== Available Font Families ===";

    QStringList allFonts = QFontDatabase::families();
    qDebug() << "Total fonts:" << allFonts.size();

    // Show only Square721 fonts
    for (const QString &family : allFonts) {
        if (family.contains("Square")) {
            qDebug() << "  -" << family;
        }
    }
}
int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    QFontDatabase::addApplicationFont(":/fonts/Square721_BT.ttf");
    QFontDatabase::addApplicationFont(":/fonts/Candara.ttf");
    // Verify it's available
    //qDebug() << "Available fonts:" << QFontDatabase::families().filter("Square");
    //
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
    // Load fonts

    return app.exec();
}
