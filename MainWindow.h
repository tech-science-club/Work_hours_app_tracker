#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QObject>
#include <QWidget>
#include <QString>
#include <QCalendar>
#include <QDateTime>
#include <QVector>
#include <QTimer>

class MainWindow : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString storagePath READ storagePath) //added from exmple
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
    void sendCounterToBtn(QString);
    void sendCounterToPauseBtn(QString);

public slots:
    void getCurrentDateTime();
    QString console();
    void writeDataTime(QString);
    void endTime(QString);
    QString calculatetime(QString);
    void depictDateData(QString);
    void overWrite(QString, QString);
    void monthInfo(QString);
    void writeToCSV(const QStringList&, const QStringList&, QString);
    void timecounter();
    void onTimeout();
    void stopCounter();
    void timecounterForPause();
    void on_pTimeout();
    void stopPCounter();
    void exitSaveData();
    void autoStart();
    void LaunchInfo();
    void colectAppData(QString, QString);


private:
    QTimer *timer = nullptr;
    QTimer *pause_timer = nullptr;
    int elapsedSeconds = 0;
    int pause_elapsedSeconds = 0;
    qint64 diffSeconds = 0;
    QString csvPath;
    QString cntr;
    QString diffStr;
    QString diffStr_pause;
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
    bool startFlag = true;
    bool* pauseFlag;
    bool stopFlag;
    QString appDataPath;
    QString isRunning = "false";
    void initializePath();
};

#endif // MAINWINDOW_H
