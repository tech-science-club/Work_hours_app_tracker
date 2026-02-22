#include "MainWindow.h"
#include <QDateTime>
#include <QStandardPaths>
#include <Qfile>
#include <QDir>
#include <QTime>
//#include <QElapsedTimer>

MainWindow::MainWindow(QObject *parent):QObject(parent) {

    initializePath();
    loadAppStatus();
}

void MainWindow::initializePath()
{
    // Android
#ifdef Q_OS_ANDROID

    m_storagePath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    csvPath = QStandardPaths::writableLocation(QStandardPaths::DownloadLocation);// + "/WorkTracker/csv/";
    bufPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/buffer/buffer.txt";
    jsonAppDataPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/buffer/";
#else
    // For Desktop: Documents folder
    m_storagePath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/WorkTracker/";
    csvPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/WorkTracker/csv/";
    bufPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/WorkTracker/buffer/buffer.txt";
    jsonAppDataPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/WorkTracker/";
#endif

    // Create directory if it doesn't exist
    QDir dir;
    if (!dir.exists(m_storagePath)||!dir.exists(csvPath)) {
        if (dir.mkpath(m_storagePath)&&dir.mkpath(csvPath)) {
            qDebug() << "Created storage directory:" << m_storagePath << '\n'<< csvPath <<'\n';
        } else {
            qWarning() << "Failed to create directory:" << m_storagePath<< '\n'<< csvPath <<'\n';
        }
    }

    qDebug() << "Storage path initialized:" << m_storagePath << '\n'<< csvPath <<'\n';
    //emit storagePathChanged();

    if (!dir.exists(jsonAppDataPath)){
        qDebug() << "path does not exist:" << jsonAppDataPath;
        dir.mkpath(jsonAppDataPath);
        if (dir.exists(jsonAppDataPath)){
            qDebug() << "path is created:" << jsonAppDataPath;
        //return;
        }
    }
    else{
        qDebug() << "path to json dir :" << jsonAppDataPath;
    }

    //QString jsonFilePath = jsonAppDataPath + "appData.json";
    jsonAppDataFile = QDir(jsonAppDataPath).filePath("appData.json");
    qDebug() << "path to json file :" << jsonAppDataFile;
}

void MainWindow::onStart()
    {
    AppIsRunning = true;
    startBtnState_pressed = true;
    if (pauseBtnState_pressed){
        pauseBtnState_pressed = false;
    }

    startedtime = QDateTime::currentDateTime();
    startedTime  = QDateTime::currentDateTime().toString("HH:mm:ss");
    if (startedTimeFlag == false){
        startTimeStamp = startedTime;
        startedTimeFlag = true;
    }
    timecounterForStart();
    emit startButPressed(startTimeStamp);

    // qDebug()<<"startbtnstate "<< startBtnState_pressed<<'\n';
    // qDebug()<<"pausetbtnstate "<< pauseBtnState_pressed<<'\n';
    // qDebug()<<"endtbtnstate "<< endBtnState_pressed<<'\n';
    //startedTimeInfoPath = "C://Users//dimap//Documents//WH//user//" + dateNameFile + ".txt";
    startedTimeInfoPath = m_storagePath + "/" + dateNameFile + ".txt";

    QFile file(startedTimeInfoPath);
    if (startFlag == true)
    {
        if(file.open(QIODevice::ReadWrite | QIODevice::Append | QIODevice::Text))
        {
            file.write(date.toUtf8());
            file.write("start "+ startedTime.toUtf8());
            file.write("\n");
            file.close();

        }
    }
    startFlag = false;
    saveAppStatus();
}

void MainWindow::timecounterForStart(){
    if (!timer) {
        timer = new QTimer(this);
        connect(timer, &QTimer::timeout, this, &MainWindow::onTimeout);
    }
    timer->start(1000);
    qDebug() << "diff_datetime before start counter: " << diffStr;


}

void MainWindow::onTimeout()
{

    QDateTime nowdatetime = QDateTime::currentDateTime();
    diffSeconds = startedtime.secsTo(nowdatetime) + diff_sec;
    diffStr = QTime(0,0,0).addSecs(diffSeconds).toString("HH:mm:ss");
    emit sendCounterToBtn(diffStr, startBtnState_pressed);
    //qDebug() << "diff_datetime from cpp: " << diffStr;


}

void MainWindow::stopCounter()
{
    diff_sec = diffSeconds;
    if (timer){
        timer->stop();
    }
    qDebug()<<"start counter is stopped";
}

void MainWindow::timecounterForPause(){
    pause_Time = QDateTime::currentDateTime();
    qDebug()<<"from timercounter forPause "<< startFlag;
    if (!pause_timer) {
        pause_timer = new QTimer(this);
        connect(pause_timer, &QTimer::timeout, this, &MainWindow::on_pTimeout);
    }
    pause_timer->start(1000);

}

void MainWindow::on_pTimeout()
{
    QDateTime nowdatetime = QDateTime::currentDateTime();
    qint64 diffSeconds = pause_Time.secsTo(nowdatetime) + pause_diffSeconds;
    diffStr_pause = QTime(0,0,0).addSecs(diffSeconds).toString("HH:mm:ss");
    emit sendCounterToPauseBtn(diffStr_pause, pauseBtnState_pressed);
    saveAppStatus();
}

void MainWindow::stopPCounter()
{
    if (pause_timer){
        pause_timer->stop();
    }
    pause_diffSeconds = 0;
    qDebug()<<"pause counter is stopped";
}

void MainWindow::onPause()
    {
    pauseBtnState_pressed = true;
    startBtnState_pressed = false;

    // qDebug()<<"startbtnstate "<< startBtnState_pressed<<'\n';
    // qDebug()<<"pausetbtnstate "<< pauseBtnState_pressed<<'\n';
    // qDebug()<<"endtbtnstate "<< endBtnState_pressed<<'\n';

    pauseTime           = QDateTime::currentDateTime().toString("HH:mm:ss");
    startedTimeInfoPath = m_storagePath + "/" + dateNameFile + ".txt";
    //startedTimeInfoPath = "C://Users//dimap//Documents//WH//user//"+dateNameFile+".txt";
    //bufPath             = "C://Users//dimap//Documents//WH//user//buff.txt";
    QFile file(startedTimeInfoPath);
    QFile fileBuf(bufPath);
    qDebug()<<"from writeDataTime "<< pauseTime;
    if (startFlag == false)
    {
        if(file.open(QIODevice::ReadWrite | QIODevice::Append | QIODevice::Text))
            {
                file.write("pause " + pauseTime.toUtf8());
                file.write("\n");
                file.close();
                startFlag = true;
            }
    }
    //qDebug()<<"from writeDataTime "<< startFlag;
    saveAppStatus();
    }

void MainWindow::onEnd()
    {
        startBtnState_pressed = false;
        pauseBtnState_pressed = false;
        endBtnState_pressed   = true;
        startedTimeFlag = false;
        // qDebug()<<"startbtnstate "<< startBtnState_pressed<<'\n';
        // qDebug()<<"pausetbtnstate "<< pauseBtnState_pressed<<'\n';
        // qDebug()<<"endtbtnstate "<< endBtnState_pressed<<'\n';
        end_time = QDateTime::currentDateTime().toString("HH:mm:ss");
        startedTimeInfoPath = m_storagePath + "/" + dateNameFile + ".txt";
        //startedTimeInfoPath = "C://Users//dimap//Documents//WH//user//"+dateNameFile+".txt";
        QFile file(startedTimeInfoPath);
        QFile fileBuf(bufPath);
        qDebug()<<end_time<<'\n';
         qDebug()<<"start flag "<< startFlag<<'\n';
        if (startFlag == false)
        {
            if(file.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text))
            {
                file.write("end " + end_time.toUtf8());
                file.write("\n");
                file.close();
                startFlag = true;
            }
        }
        diff_sec = 0;
        AppIsRunning = false;
        saveAppStatus();
        //qDebug()<<"diff sec "<< diff_sec<<'\n';
    }

QString MainWindow::calculatetime(QString dateNameFile){

    struct TimeEntry {
        QString action;  // "start", "pause", "resume", "end"
        QTime time;
    };

    startedTimeInfoPath = m_storagePath + "/" + dateNameFile + ".txt";
    //startedTimeInfoPath = "C://Users//dimap//Documents//WH//user//"+dateNameFile+".txt";
    QFile file(startedTimeInfoPath);
    QTextStream in(&file);
    QList<TimeEntry> entries;

    if(file.open(QIODevice::ReadWrite | QIODevice::Text))
    {
        while (!in.atEnd()) {
            QString line = in.readLine().trimmed();
            if (line.isEmpty()) continue;

            //qDebug()<<line<<'\n';
            QStringList parts = line.split(' ', Qt::SkipEmptyParts);
            if (parts.size() < 2) continue;
            TimeEntry timeentry;
            timeentry.action = parts[0].toLower().remove('[').remove(']');
            timeentry.time   = QTime::fromString(parts[1], "hh:mm:ss");

            if (timeentry.time.isValid()){
                entries.append(timeentry);
            }
            }

    }
    file.close();

    int totalActiveSec = 0;
    bool _is_running = false;
    QTime lastStartTime;

    for (TimeEntry &timeentry : entries){

        if (timeentry.action=="start"){
            lastStartTime = timeentry.time;
            _is_running = true;
            //qDebug()<<"started at "<<timeentry.time.toString()<<'\n';
        }
        else if(timeentry.action == "pause" && _is_running){
            int duration = lastStartTime.secsTo(timeentry.time);
            totalActiveSec+=duration;
            _is_running = false;
            //qDebug()<<"paused at "<<timeentry.time.toString()<< " added sec "<< duration << '\n';
        }
        else if (timeentry.action == "end"&& _is_running){
            int duration = lastStartTime.secsTo(timeentry.time);
            totalActiveSec+=duration;
            _is_running = false;
            //qDebug()<<"ended at "<<timeentry.time.toString() <<" added sec "<< duration <<'\n';
        }
    }

    int hours = totalActiveSec / 3600;

    int min = (totalActiveSec % 3600) / 60;
    int sec = totalActiveSec % 60;
    totalTime = QString("%1:%2:%3")
                            .arg(hours, 2, 10, QChar('0'))
                            .arg(min, 2, 10, QChar('0'))
                            .arg(sec, 2, 10, QChar('0'));

    // qDebug() << "Total active time:" << totalActiveSec << "seconds"<<'\n';
    // qDebug() << "Total time:" << totalTime << "\n";

    emit totalTimeShow(totalTime);
    return QString::number(totalActiveSec);
    }

void MainWindow::depictDateData(QString date){
    //qDebug()<< "date from button "<< date <<'\n';

    QString cleaned = date;
    QString FileName;
    cleaned.replace(',', ' ');
    QStringList parts = cleaned.split(' ', Qt::SkipEmptyParts);
    int ln = parts[1].length();
    //qDebug()<<"lenth of date: "<< ln <<'\n';

    if (ln<2){
        FileName = "0"+parts[1]+"_"+parts[2]+"_"+parts[3];
    }
    else{
    FileName = parts[1]+"_"+parts[2]+"_"+parts[3];
    }

    QString fileInfoPath = m_storagePath + "/" + FileName+".txt";
    //qDebug()<<fileInfoPath;
    QFile file(fileInfoPath);
    QTextStream in(&file);
    emit sendDateHeader(FileName);
    int linecnt = 0;
    QString total_time = calculatetime(FileName);
    //qDebug()<<"from depictDateData "<<total_time;
    if(file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        while (!in.atEnd())
        {
            linecnt += 1;
            QString line = in.readLine().trimmed();

            emit sendDataToPopup(line, linecnt, total_time); //, total_time
        }
    }
    file.close();
}

void MainWindow::overWrite(QString data, QString date){
    //qDebug()<<"cpp side: "<< data<<" "<<date<<'\n';

    QString cleaned = data;
    cleaned.replace(',', ' ');
    QStringList parts = cleaned.split('\n', Qt::SkipEmptyParts);

    date.replace(' ', '_');
    QString fileInfoPath = m_storagePath + "/" +date+".txt";
    //qDebug()<<fileInfoPath;
    QFile file(fileInfoPath);

    if(file.open(QIODevice::WriteOnly |  QIODevice::Text))
        {
        QTextStream out(&file);
        for (QString& line : parts){
            out<<line<<"\n";
        }

    file.close();
    }
    //MainWindow mv;
    QString hours = calculatetime(date);
    //qDebug()<< "hours from overwrite "<<hours<<'\n';
    emit sendHoursToTotalHrsInPopUp(hours);
}

void MainWindow::monthInfo(QString month){
    //qDebug()<< "date from button "<< month <<'\n';

    QString filePath;
    QString sec_amount;
    QStringList parts;
    QStringList parts1;
    QStringList parts_txt_off;
    QDir directory(m_storagePath);
    MainWindow mv;
    QVector<QString> active_time;
    QVector<QString> day;

    //QStringList fileNames = directory.entryList(QDir::Files);
    //QString month_format = month.replace(' ', '_');
    const QStringList files = directory.entryList(QDir::Files);
    for (const QString &fileName : files) {
        parts = fileName.split("_",  Qt::SkipEmptyParts);
        parts_txt_off = fileName.split(".",  Qt::SkipEmptyParts);
        parts1 = month.split(" ",  Qt::SkipEmptyParts);
        if (parts.size() > 1) {
            if (parts[1]==parts1[0]){
                //qDebug() << fileName;
                filePath = m_storagePath + "/" +fileName;
                sec_amount = mv.calculatetime(parts_txt_off[0]);
                active_time.push_back(sec_amount);
                day.push_back(parts[0]);
            }
            //qDebug() << active_time << '\n';
        } else {
            qDebug() << "File doesn't have enough parts:" << fileName;
        }
    }

    emit sendArrayToChart(active_time, day);

}

void MainWindow::writeToCSV(const QStringList &days, const QStringList &hrs, QString name){
    //month.replace(' ', '_');
    //QString dirPath = csvPath + "/" + "csv";// +month+".csv";
    // QDir dir(csvPath);
    // if (!dir.exists()) {
    //     if (!dir.mkpath(".")) {
    //         qWarning() << "Cannot create directory:" << csvPath;
    //         return;
    //     }
    // }
    // QString fileCsvPath = QUrl(csvPath).toLocalFile();
    //QString fileCsvPath = dir.filePath(name + ".csv");
    //QString fileCsvPath = QUrl(file_CsvPath).toLocalFile();
    //QFile file(fileCsvPath);
    #ifdef Q_OS_ANDROID
    // QString fileCsvPath = QUrl(name).toLocalFile();
    // QFile file(fileCsvPath);
    QFile file(name);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Cannot open file:" << csvPath;
        return;
    }
    qDebug()<<"name "<<name<<'\n';
    QTextStream in(&file);
    in.setEncoding(QStringConverter::Utf8);
    int n = days.size();
    for (int i = 0; i < n; ++i) {
        in << days[i] << "," << hrs[i] << '\n';
    }

    file.close();

#else
    QDir dir(csvPath);
    if (!dir.exists()) {
        if (!dir.mkpath(".")) {
            qWarning() << "Cannot create directory:" << csvPath;
            return;
        }
    }
    //QString fileCsvPath = QUrl(csvPath).toLocalFile();
    //QString fileCsvPath = dir.filePath(name + ".txt");
    QString fileCsvPath = QUrl(name).toLocalFile();
    QFile file(fileCsvPath);
    //QFile file(name);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Cannot open file:" << csvPath;
        return;
    }
    //qDebug()<<"name "<<name<<'\n';
    QTextStream in(&file);
    in.setEncoding(QStringConverter::Utf8);
    int n = days.size();
    for (int i = 0; i < n; ++i) {
        in << days[i] << "," << hrs[i] << '\n';
    }

    file.close();
#endif
}

void MainWindow::exitSaveData(){
    QFile file(jsonAppDataFile);
    AppIsRunning = false;
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning() << "Failed to open state file for writing:" << file.errorString();
    }
    QJsonObject jsobj;
    jsobj["startBtn"] = false;
    jsobj["pauseBtn"] = false;
    jsobj["startTime"] = "HH:MM:SS";
    jsobj["pauseTime"] = "HH:MM:SS";
    jsobj["appStatus"] = false;

    QByteArray byteArray;
    byteArray = QJsonDocument(jsobj).toJson();
    file.write(byteArray);
    file.close();
    QTextStream textStream(stdout);
    // textStream << "Rendered json byteArray text: " <<'\n';
    // textStream << byteArray << '\n';

}
