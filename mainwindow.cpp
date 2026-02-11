#include "MainWindow.h"
#include <QDateTime>
#include <QStandardPaths>
#include <Qfile>
#include <QDir>
#include <QTime>
//#include <QElapsedTimer>
#include <QStandardPaths>


MainWindow::MainWindow(QObject *parent):QObject(parent) {

    initializePath();

    QFile file(bufPath);
    QString line;
    QTextStream in(&file);
    if(file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        while (!file.atEnd())
        {
            line = in.readLine().trimmed();
            if (line.isEmpty()){
                isRunning = "true";
                qDebug()<<"clear start";
            }else{
                QStringList parts = line.split(' ', Qt::SkipEmptyParts);
                qDebug()<<"read launch data";
                if ( parts[1] == "true"){
                    //autoStart();
                    qDebug()<<"was crashed";
                    }
                else{
                    isRunning = "true";
                    continue;
                }
            }
        }
        file.close();
        qDebug()<<"launch info "<< isRunning;

    }
    LaunchInfo();
}

void MainWindow::initializePath()
{
    // ✅ Get Android-appropriate storage location
#ifdef Q_OS_ANDROID
    // For Android: Internal app storage
    // Path: /data/data/com.yourcompany.yourapp/files
    m_storagePath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
#else
    // For Desktop: Documents folder
    m_storagePath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/WorkTracker/";
    csvPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/WorkTracker/csv/";
    bufPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/WorkTracker/buffer/buffer.txt";
    appDataPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/WorkTracker/buffer/appData.txt";
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
}

void MainWindow::LaunchInfo(){
    qDebug()<<"launch info started"<<'\n';
    QString time_stmp =QDateTime::currentDateTime().toString("dd/MM/yyyy-HH:mm:ss");

    QFile file(bufPath);
     QTextStream in(&file);
    if(file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        // file.write(time_stmp.toUtf8());
        // file.write(" ");
        // file.write(isRunning ? "true\n" : "false\n");
        QTextStream out(&file);
        in << time_stmp << " " << isRunning << "\n";
        file.close();
    }
    //return isRunning;
}

void MainWindow::autoStart(){
    qDebug()<<"autostart"<<'\n';
    QFile file(appDataPath);
    QString line;
    QTextStream in(&file);

    while (!file.atEnd())
    {
        line = in.readLine().trimmed();
        if (line.isEmpty()){
            break;
        }else{
            QStringList parts = line.split(' ', Qt::SkipEmptyParts);
            //isRunning = parts[1];
            diffStr = parts[1];
            diffStr_pause = parts[2];
            if (diffStr != "Start"){
                timecounter();
            }
            if (diffStr_pause != "Pause"){
                timecounterForPause();
            }
            //emit sendCounterToBtn(part[1]);
            //emit sendCounterToPauseBtn(part[2]);

        }
    }
    file.close();

}

void MainWindow::colectAppData(QString param1, QString param2){

    QString time_stmp =QDateTime::currentDateTime().toString("dd/MM/yy-HH:mm:ss");
    QFile file(appDataPath);
    //time_stmp
    if(file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        // file.write(time_stmp.toUtf8());
        // file.write(" ");
        // file.write(isRunning ? "true\n" : "false\n");
        QTextStream out(&file);
        out << time_stmp << " " << param1 << " " << param2<< "\n";
        file.close();
    }
}

void MainWindow::getCurrentDateTime()
    {
        startedtime = QDateTime::currentDateTime();
        startedTime  = QDateTime::currentDateTime().toString("HH:mm:ss");

        timecounter();
        emit startButPressed(startedTime);
        //qDebug()<<startedTime<<'\n';

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
        qDebug()<< startedTimeInfoPath <<'\n';
        startFlag = false;

    }

void MainWindow::timecounter(){
    if (!timer) {
        timer = new QTimer(this);
        connect(timer, &QTimer::timeout, this, &MainWindow::onTimeout);
    }
    timer->start(1000);
}

void MainWindow::onTimeout()
{

    //QTime t(0, 0, 0);
    QDateTime nowdatetime = QDateTime::currentDateTime();
    diffSeconds = startedtime.secsTo(nowdatetime);
    diffStr = QTime(0,0,0).addSecs(diffSeconds).toString("HH:mm:ss");
    //t = t.addSecs(diffSeconds);
    //cntr = t.toString("HH:mm:ss");
    emit sendCounterToBtn(diffStr);
    //diff_sec++;
    //diff_sec = QTime(0,0,0).addSecs(diffSeconds);
    //diffStr.toString("HH:mm:ss");
    qDebug() << "diff_datetime: " << diffStr;

}

void MainWindow::stopCounter()
{
    if (timer){
        timer->stop();
    }
    // if (stopFlag==true){
    //     diffSeconds = 0;
    // }
}

void MainWindow::timecounterForPause(){
    pause_Time = QDateTime::currentDateTime();

    if (!pause_timer) {
        pause_timer = new QTimer(this);
        connect(pause_timer, &QTimer::timeout, this, &MainWindow::on_pTimeout);
    }
    pause_timer->start(1000);
}

void MainWindow::on_pTimeout()
{
    QDateTime nowdatetime = QDateTime::currentDateTime();
    qint64 diffSeconds = pause_Time.secsTo(nowdatetime);
    diffStr_pause = QTime(0,0,0).addSecs(diffSeconds).toString("HH:mm:ss");
    //pause_elapsedSeconds++;
    //QTime t(0, 0, 0);
    //t = t.addSecs(pause_elapsedSeconds);
    //pause_cntr = t.toString("HH:mm:ss");
    emit sendCounterToPauseBtn(diffStr_pause);
}

void MainWindow::stopPCounter()
{
    if (pause_timer)
        pause_timer->stop();
        pause_elapsedSeconds = 0;

}

QString MainWindow::console(){
    return startedTime;
    }

void MainWindow::writeDataTime(QString timeForPause)
    {
    pauseTime           = QDateTime::currentDateTime().toString("HH:mm:ss");
    startedTimeInfoPath = m_storagePath + "/" + dateNameFile + ".txt";
    //startedTimeInfoPath = "C://Users//dimap//Documents//WH//user//"+dateNameFile+".txt";
    //bufPath             = "C://Users//dimap//Documents//WH//user//buff.txt";
    QFile file(startedTimeInfoPath);
    QFile fileBuf(bufPath);

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
    if(fileBuf.open(QIODevice::ReadWrite | QIODevice::Text))
    {

        fileBuf.write(timeForPause.toUtf8());

        fileBuf.close();
    }
    }

void MainWindow::endTime(QString end_time)
    {
        startedTimeInfoPath = m_storagePath + "/" + dateNameFile + ".txt";
        //startedTimeInfoPath = "C://Users//dimap//Documents//WH//user//"+dateNameFile+".txt";
        QFile file(startedTimeInfoPath);
        QFile fileBuf(bufPath);
        qDebug()<<end_time<<'\n';
        if (startFlag == false)
        {
            if(file.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text))
            {
                file.write("[end] " + end_time.toUtf8());
                file.write("\n");
                file.close();
                startFlag = true;
            }
        }
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
    QString hours_formated = QString::number(hours, 'f', 2);
    int min = (totalActiveSec % 3600) / 60;
    int sec = totalActiveSec % 60;
    totalTime = QString("%1:%2:%3")
                            .arg(hours, 2, 10, QChar('0'))
                            .arg(min, 2, 10, QChar('0'))
                            .arg(sec, 2, 10, QChar('0'));

    qDebug() << "Total active time:" << totalActiveSec << "seconds"<<'\n';
    qDebug() << "Total time:" << totalTime << "\n";

    emit totalTimeShow(totalTime);
    return QString::number(totalActiveSec);
    }

void MainWindow::depictDateData(QString date){
    qDebug()<< "date from button "<< date <<'\n';
    QString name;
    QString cleaned = date;
    QString FileName;
    cleaned.replace(',', ' ');
    QStringList parts = cleaned.split(' ', Qt::SkipEmptyParts);
    int ln = parts[1].length();
    qDebug()<<"lenth of date: "<< ln <<'\n';

    if (ln<2){
        FileName = "0"+parts[1]+"_"+parts[2]+"_"+parts[3];
    }
    else{
    FileName = parts[1]+"_"+parts[2]+"_"+parts[3];
    }

    QString fileInfoPath = m_storagePath + "/" + FileName+".txt";
    qDebug()<<fileInfoPath;
    QFile file(fileInfoPath);
    QTextStream in(&file);
    emit sendDateHeader(FileName);
    int linecnt = 0;
    QString total_time = calculatetime(FileName);
    qDebug()<<"from depictDateData "<<total_time;
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
    qDebug()<<"cpp side: "<< data<<" "<<date<<'\n';
    QString name;
    QString cleaned = data;
    cleaned.replace(',', ' ');
    QStringList parts = cleaned.split('\n', Qt::SkipEmptyParts);
    QString FileName = date;
    date.replace(' ', '_');
    QString fileInfoPath = m_storagePath + "/" +date+".txt";
    qDebug()<<fileInfoPath;
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
    qDebug()<< "hours from overwrite "<<hours<<'\n';
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
    for (const QString &fileName : directory.entryList(QDir::Files)) {
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
            qDebug() << active_time << '\n';
        } else {
            qDebug() << "File doesn't have enough parts:" << fileName;
        }
    }
    emit sendArrayToChart(active_time, day);

}

void MainWindow::writeToCSV(const QStringList &days, const QStringList &hrs, QString month){
    month.replace(' ', '_');
    //QString dirPath = csvPath + "/" + "csv";// +month+".csv";
    QDir dir(csvPath);
    if (!dir.exists()) {
        if (!dir.mkpath(".")) {
            qWarning() << "Cannot create directory:" << csvPath;
            return;
        }
    }
    QString fileCsvPath = dir.filePath(month + ".csv");
    QFile file(fileCsvPath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Cannot open file:" << csvPath;
        return;
    }
    QTextStream in(&file);
    int n = days.size();
    for (int i = 0; i < n; ++i) {
        in << days[i] << "," << hrs[i] << '\n';
    }
    file.close();
}

void MainWindow::exitSaveData(){
    qDebug()<<"exit, save data"<<'\n';
    isRunning = "false";
    QString time_stmp =QDateTime::currentDateTime().toString("dd/MM/yyyy-HH:mm:ss");
    QFile file(bufPath);
    if(file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        // file.write(time_stmp.toUtf8());
        // file.write(" ");
        // file.write(isRunning ? "true\n" : "false\n");
        QTextStream out(&file);
        out << time_stmp << " " << isRunning<< "\n";
        file.close();
    }
}
