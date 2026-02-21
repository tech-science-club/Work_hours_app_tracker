#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QObject>
#include <qqmlintegration.h>
#include <QWidget>
#include <QString>
#include <QCalendar>
#include <QDateTime>
#include <QVector>
#include <QTimer>
#include <QJsonObject>
#include <QJsonDocument>

class MainWindow : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString storagePath READ storagePath) //added from exmple
    Q_PROPERTY(bool js_startBtn MEMBER js_startBtn)
    Q_PROPERTY(bool js_pauseBtn MEMBER js_pauseBtn)
    Q_PROPERTY(QString js_startTime MEMBER js_startTime)
    Q_PROPERTY(QString js_pauseTime MEMBER js_pauseTime)

    Q_PROPERTY(bool js_status MEMBER js_status)

    Q_PROPERTY(bool startButState MEMBER startButState)    ///!!!!
    Q_PROPERTY(bool pauseBtnState MEMBER pauseBtnState)
    Q_PROPERTY(bool endBtnState MEMBER endBtnState)
public:
    explicit MainWindow(QObject *parent = nullptr);
    //from example bellow
    QString storagePath() const { return m_storagePath; }
    // Q_INVOKABLE bool saveData(const QString &filename, const QString &data);
    // Q_INVOKABLE QString loadData(const QString &filename);
    // Q_INVOKABLE QStringList listFiles();
    QString m_storagePath;

signals:
    void startButPressed(QString startedTime);
    void stopButPressed();
    void totalTimeShow(QString totalTime);
    void sendDataToPopup(QString, int, QString);
    void sendDateHeader(QString);
    void sendModifiedData(QString, QString);
    void sendHoursToTotalHrsInPopUp(QString);
    void sendArrayToChart(QVector<QString>, QVector<QString>);
    void sendCounterToBtn(QString, bool);
    void sendCounterToPauseBtn(QString, bool);

public slots:
    void onStart();
    void onPause();
    void onEnd();
    QString calculatetime(QString);
    void depictDateData(QString);
    void overWrite(QString, QString);
    void monthInfo(QString);
    void writeToCSV(const QStringList&, const QStringList&, QString);
    void timecounterForStart();
    void onTimeout();
    void stopCounter();
    void timecounterForPause();
    void on_pTimeout();
    void stopPCounter();
    void exitSaveData();
    void saveAppStatus();
    void loadAppStatus();


private:
    bool js_startBtn;
    bool js_pauseBtn;
    QString js_startTime;
    QString js_pauseTime;
    bool js_status;
    QString jsonAppDataFile;
    QDateTime currentDatetime = QDateTime::currentDateTime();
    QTimer *timer = nullptr;
    QTimer *pause_timer = nullptr;
    QTimer *monitor_timer = nullptr;
    int elapsedSeconds = 0;
    int pause_elapsedSeconds = 0;
    qint64 diffSeconds = 0;
    qint64 pause_diffSeconds = 0;
    qint64 PdiffSeconds = 0;
    QString csvPath;
    QString cntr;
    QString diffStr = " ";
    QString diffStr_pause = " ";
    int diff_sec = 0;
    QString pause_cntr;
    QString startedTime;
    QDateTime startedtime;
    QDateTime pause_Time;
    QString totalTime;
    QString endedTime;
    QString startedTimeInfoPath;
    QString bufPath;
    QString pauseTime;
    QString date;
    QString timeForPause;
    QString dateNameFile = QDateTime::currentDateTime().toString("dd_MMMM_yyyy");
    QString end_time;
    QString startTimeStamp;
    bool startFlag = false;
    bool js_justStarted;
    bool startedTimeFlag = false;
    QString jsonAppDataPath;
    bool AppIsRunning = false;
    bool startBtnState_pressed = false;
    bool pauseBtnState_pressed = false;
    bool endBtnState_pressed = false;

    bool startButState;
    bool pauseBtnState;
    bool endBtnState;

    void initializePath();
};

#endif // MAINWINDOW_H
