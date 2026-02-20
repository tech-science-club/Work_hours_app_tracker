import QtQuick 2.16
import QtQuick.Controls
import QtQuick.Layouts
import QtCharts 2.10
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects
import QtQuick.Dialogs

Window {
    id: window
    width: isMobile ? Screen.width : 480
    height: isMobile ? Screen.height : 1024
    visible: true
    color: "#ffffff"
    flags: Qt.Window
    readonly property bool isMobile: Qt.platform.os === "android"
                                     || Qt.platform.os === "ios"

    property bool isPortrait: width < height
    property bool isLandscape: width > height

    // }
    // Component.onCompleted: {
    //     console.log("Auto-starting from previous session", mainwindow.js_status)
    //     if (mainwindow.js_status) {
    //         // console.log("Auto-starting from previous session",
    //         //             mainwindow.js_startBtn)
    //         if (mainwindow.js_startBtn !== "Start"
    //                 || mainwindow.js_startBtn !== " ") {
    //             startButton.clicked()
    //             //mainwindow.startFlag === false
    //         }
    //         if (mainwindow.js_pauseBtn !== "Pause"
    //                 || mainwindow.js_pauseBtn !== " ") {
    //             breakButton.clicked()
    //         }
    //     }
    // }
    BorderImage {
        id: borderImage
        width: window.width
        height: window.height
        visible: true
        source: "rsc/background.jpg"
        clip: true
        // FontLoader {
        //     id: candara
        //     source: "qrc:/rsc/fonts/Candara.ttf"
        // }
        // FontLoader {
        //     id: Square721 BT
        //     source: "qrc:/rsc/fonts/square-721-bt/Square721 BTBTRoman.ttf"
        // }
        Text {
            id: currentDate
            x: 0
            y: 15
            width: parent.width
            height: parent.height * 0.05
            color: "#6c0052"

            font.pointSize: parent.height * 0.01 + parent.width * 0.02
            horizontalAlignment: Text.AlignHCenter

            text: dateText.text


            /*{
                //var now = new Date()
                //now.toLocaleDateString()
            }*/
            font.family: "Candara"
            style: Text.Raised
        }
    }

    Item {
        anchors.fill: parent

        states: [
            State {
                name: "vert"
                when: window.isPortrait

                PropertyChanges {
                    target: mainbox
                    // x: 0
                    // y: currentDate.height + 5
                    anchors.bottom: parent.bottom
                    //anchors.top: currentDate.bottom
                    anchors.bottomMargin: parent.height * 0.5
                    //anchors.topMargin: 10
                    anchors.top: parent.top
                    //anchors.bottomMargin: 10
                    anchors.topMargin: parent.height * 0.1
                }
                PropertyChanges {
                    target: calendarbox
                    height: parent.height * 0.40
                    width: parent.width
                    color: "#02ffffff"

                    // x: (parent.width - calendarbox.width) / 2
                    // y: mainbox.height + currentDate.height + 10
                    anchors.verticalCenter: undefined
                    anchors.left: undefined

                    anchors.right: undefined
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 50
                    anchors.centerIn: undefined
                }
                PropertyChanges {
                    target: chartBar
                    x: 0
                    y: statTitle.height + gridBox.height + 10
                    width: statContent.width
                    height: statContent.height * 0.68
                }

                PropertyChanges {
                    target: gridBox
                    x: 0
                    y: statTitle.height + 5
                    width: statContent.width
                    height: statContent.height * 0.1
                }

                PropertyChanges {
                    target: statRec1
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: undefined
                    anchors.top: undefined
                    anchors.bottom: undefined
                    anchors.centerIn: undefined
                    width: parent.width * 0.3
                    height: parent.height * 0.75
                }

                PropertyChanges {
                    target: statRec2
                    anchors.centerIn: parent
                    anchors.left: undefined
                    anchors.right: undefined
                    anchors.top: undefined
                    anchors.bottom: undefined
                    width: parent.width * 0.3
                    height: parent.height * 0.75
                }

                PropertyChanges {
                    target: statRec3
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: undefined
                    anchors.top: undefined
                    anchors.bottom: undefined
                    anchors.centerIn: undefined
                    width: parent.width * 0.3
                    height: parent.height * 0.75
                }
            },
            State {
                name: "hor"
                when: window.isLandscape

                PropertyChanges {
                    target: calendarbox
                    x: parent.width * 0.5
                    y: currentDate.height + 5
                    width: parent.width * 0.5
                    height: parent.height * 0.8
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.bottomMargin: 50
                    anchors.topMargin: parent.height * 0.1
                    anchors.right: parent.right
                    anchors.rightMargin: 25
                }
                PropertyChanges {
                    target: mainbox
                    x: 0
                    y: currentDate.height + 5
                    width: parent.width * 0.5
                    height: parent.height * 0.8
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.bottomMargin: 10
                    anchors.topMargin: parent.height * 0.1
                }

                PropertyChanges {
                    target: chartBar
                    x: 0
                    y: 0
                    width: statContent.width * 0.8
                    height: statContent.height
                    anchors.fill: undefined
                    anchors.left: undefined
                    anchors.right: undefined
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    // anchors.leftMargin: 0
                    // anchors.rightMargin: 0
                    // anchors.topMargin: 0
                    // anchors.bottomMargin: 0
                }

                PropertyChanges {
                    target: gridBox
                    x: chartBar.width + 5
                    y: 0
                    width: statContent.width * 0.2
                    height: statContent.height
                }

                PropertyChanges {
                    target: statRec1
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.horizontalCenter: undefined
                    anchors.left: undefined
                    anchors.right: undefined
                    anchors.bottom: undefined
                    anchors.verticalCenter: undefined
                    anchors.centerIn: undefined
                    width: gridBox.width
                    height: gridBox.height * 0.25
                }

                PropertyChanges {
                    target: statRec2
                    anchors.top: statRec1.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: undefined
                    anchors.left: undefined
                    anchors.right: undefined
                    anchors.bottom: undefined
                    anchors.verticalCenter: undefined
                    anchors.centerIn: undefined
                    width: gridBox.width
                    height: gridBox.height * 0.25
                }

                PropertyChanges {
                    target: statRec3
                    anchors.top: statRec2.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: undefined
                    anchors.left: undefined
                    anchors.right: undefined
                    anchors.bottom: undefined
                    anchors.verticalCenter: undefined
                    anchors.centerIn: undefined
                    width: gridBox.width
                    height: gridBox.height * 0.25
                }
            }
        ]
    }

    Rectangle {
        id: mainbox
        width: parent.width
        height: parent.height * 0.45
        color: "#00ffffff"
        x: 0
        y: currentDate.height + 5

        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 8.0
            samples: 17
            color: "#80000000" // Semi-transparent black
            transparentBorder: true
        }

        Rectangle {
            id: rectangle5
            x: 50
            width: parent.width
            height: parent.height * 0.05
            color: "#00ffffff"
            anchors.top: bottomRow.bottom
            anchors.topMargin: 1

            Row {
                id: row2
                //width: 302.1
                height: parent.height
                // anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.01
                //x: endButton.x + 10
                //y: rowLayout.y + 50
                spacing: 5
                Text {
                    id: startTime1
                    text: qsTr("Ended at:")
                    font.pointSize: (parent.width * 0.05 + parent.height * 0.5) / 2
                }

                Text {
                    id: endingTime

                    text: qsTr("HH:MM:SS")
                    font.pointSize: (parent.width * 0.05 + parent.height * 0.5) / 2
                }
            }
        }

        Rectangle {
            id: rectangle6
            x: 50
            width: parent.width
            height: parent.height * 0.05
            color: "#01ffffff"
            anchors.top: upperRow.bottom
            anchors.topMargin: 1

            Row {
                id: row
                x: 8
                // x: 2
                // y: 12
                //width: parent.width * 0.2
                height: parent.height
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.01
                spacing: 5
                Text {
                    id: startTime
                    text: qsTr("Started at:")
                    font.pointSize: (parent.width * 0.05 + parent.height * 0.5) / 2
                    //font.family: candara.name
                }

                Text {
                    id: startingTime
                    text: qsTr("HH:MM:SS")
                    font.pointSize: (parent.width * 0.05 + parent.height * 0.5) / 2
                }
            }
        }

        Row {
            id: bottomRow
            x: 0
            width: parent.width
            height: parent.height * 0.15
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 60

            RoundButton {
                id: endButton
                width: parent.width * 0.35
                height: parent.height // * 0.075
                radius: 10
                text: "End"
                anchors.left: parent.left
                anchors.leftMargin: 35

                bottomPadding: 10
                font.pointSize: parent.width * 0.025 + parent.height * 0.05
                font.family: "Square721 BT"

                onClicked: {
                    if (startButton.startButIsPressed === true) {
                        var date = new Date()
                        var endtime = Qt.formatTime(date, "hh:mm:ss")
                        var stopFlag = true

                        mainwindow.stopCounter()
                        mainwindow.stopPCounter()
                        mainwindow.endTime(endtime)
                        var now = new Date()
                        var formated_str = Qt.formatDate(now, "dd_MMMM_yyyy")
                        console.log("formated date in end btn: ", formated_str)

                        mainwindow.calculatetime(formated_str)
                        //countTimer.stop()
                        //breakTimer.stop()
                        //countTimer.counter = 0
                        //breakTimer.counter = 0
                        startButton.text = "Start"
                        breakButton.text = "Pause"
                        endingTime.text = endtime
                        startButtonBg.color = "#d6d7d7"
                        pauseButtonBg.color = "#d6d7d7"
                        startButton.startButIsPressed = false
                        mainwindow.js_startBtn = "Start"
                        mainwindow.js_pauseBtn = "Pause"
                        mainwindow.js_startTime = "HH:MM:SS"
                        mainwindow.js_status = 0
                        mainwindow.exitSaveData()
                    }
                }
                Image {
                    id: stopButton
                    x: parent.width * 5 / 6 - 10
                    width: parent.width / 6
                    height: parent.height / 2
                    anchors.verticalCenter: parent.verticalCenter
                    source: "images/stop-button.png"
                    fillMode: Image.PreserveAspectFit
                }
            }

            Item {
                id: item1
                width: parent.width * 0.2
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
            }

            RoundButton {
                id: resetButton
                width: parent.width * 0.35
                height: parent.height // * 0.075
                radius: 10
                text: "Reset"
                anchors.right: parent.right
                anchors.rightMargin: 35
                leftPadding: 20
                font.pixelSize: parent.width * 0.025 + parent.height * 0.05
                font.family: "Square721 BT"
                onClicked: {
                    summaryTime.font.pixelSize = mainbox.height * 0.05 + mainbox.width * 0.1
                    summaryTime.font.family = "Square721 BT"
                    summaryTime.font.bold = false
                    summaryTime.color = "#000000"
                    summaryTime.text = qsTr("HH:MM:SS")
                    startingTime.text = qsTr("HH:MM:SS")
                    endingTime.text = qsTr("HH:MM:SS")
                }
                Image {
                    id: reset
                    x: parent.width * 5 / 6 - 10
                    width: parent.width / 6
                    height: parent.height / 2
                    anchors.verticalCenter: parent.verticalCenter
                    source: "images/reset.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        Rectangle {
            id: rectangle3
            width: parent.width * 0.9
            height: parent.height * 0.35
            color: "#42ffffff"
            //color: "black"
            radius: 10

            Gradient {
                id: gradient2
                GradientStop {
                    position: 0.0
                    color: "#fdfdfd"
                }
                GradientStop {
                    position: 1.0
                    color: "#86525252"
                }
                orientation: Gradient.Vertical
            }

            anchors.verticalCenterOffset: -25
            anchors.centerIn: parent

            Text {
                id: summaryTime
                color: "#202020"
                text: qsTr("HH:MM:SS")
                font.pixelSize: mainbox.height * 0.05 + mainbox.width * 0.1
                font.family: "Square721 BT"
                font.bold: false
                style: Text.Outline
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 0
                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 8.0
                    samples: 17
                    color: "#80000000" // Semi-transparent black
                    transparentBorder: true
                }
            }
        }

        Row {

            id: upperRow
            width: parent.width
            height: parent.height * 0.2
            spacing: 5
            rightPadding: 20
            leftPadding: 20

            RoundButton {
                property bool startButIsPressed: false
                id: startButton
                width: parent.width * 0.40
                height: parent.height
                radius: 10
                text: "Start"
                anchors.left: parent.left
                anchors.leftMargin: 25
                leftInset: 5
                leftPadding: 5
                bottomPadding: 12
                //font.pointSize: parent.width * 0.025 + parent.height * 0.05
                contentItem: Row {
                    id: startButtonRow
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        id: startButtonText
                        text: startButton.text
                        font.family: "Square721 BT"
                        font.pointSize: parent.width * 0.1 + parent.height * 0.1
                        style: Text.Raised
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.fill: parent
                    }
                    Image {
                        id: playButton
                        //x: parent.width * 5 / 6 - 10
                        width: parent.width * 0.5
                        height: parent.height * 0.5
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        horizontalAlignment: Image.AlignRight
                        source: "rsc/play.png"
                        anchors.verticalCenterOffset: 0
                        fillMode: Image.PreserveAspectFit
                    }
                }
                background: Rectangle {
                    id: startButtonBg
                    radius: 10
                    color: "#d6d7d7"
                    layer.enabled: true
                    layer.effect: DropShadow {
                        horizontalOffset: 0
                        verticalOffset: 4
                        radius: 8.0
                        samples: 17
                        color: "#80000000" // Semi-transparent black
                        transparentBorder: true
                    }
                }

                onClicked: {
                    if (startButton.startButIsPressed === false) {
                        mainwindow.getCurrentDateTime()
                        startButton.font.pointSize = parent.width * 0.01 + parent.height * 0.02
                        mainwindow.stopPCounter()
                        if (breakButton.text !== "Pause") {
                            breakButton.text = "Pause"
                        }
                        startButtonBg.color = "#bc15ff00"
                        if (pauseButtonBg.color !== "#d6d7d7") {
                            pauseButtonBg.color = "#d6d7d7"
                        }
                        startButton.startButIsPressed = true
                        mainwindow.js_pauseBtn = "Pause"
                        mainwindow.startBtnState = true
                        // console.log("start but is pressed, property is set to ",
                        //             startButton.startButIsPressed)
                        console.log("start but is pressed, property is set to ",
                                    mainwindow.startBtnState)
                    }
                }
            }

            Item {
                id: item2
                width: parent.width * 0.2
                height: parent.height
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
            }

            RoundButton {

                id: breakButton
                width: parent.width * 0.40
                height: parent.height
                radius: 10
                text: "Pause"
                anchors.right: parent.right
                anchors.rightMargin: 25
                leftPadding: 20
                leftInset: 5
                bottomPadding: 12
                background: Rectangle {
                    id: pauseButtonBg
                    radius: 10
                    color: "#d6d7d7"
                    layer.enabled: true
                    layer.effect: DropShadow {
                        horizontalOffset: 0
                        verticalOffset: 4
                        radius: 8.0
                        samples: 17
                        color: "#80000000"
                        transparentBorder: true
                    }
                }
                contentItem: Row {
                    id: row1
                    anchors.centerIn: parent
                    spacing: 1

                    Image {
                        id: pause
                        width: parent.height * 0.5
                        height: parent.height * 0.5
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: -7
                        horizontalAlignment: Image.AlignRight
                        source: "rsc/squarePause.png"
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: pauseButtonText
                        text: breakButton.text
                        font.family: "Square721 BT"
                        font.pointSize: parent.width * 0.11 + parent.height * 0.11
                        style: Text.Raised
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.fill: parent
                    }
                }

                onClicked: {
                    if (startButton.startButIsPressed === true) {
                        mainwindow.writeDataTime(startButton.text)
                        startButton.text = "Start"
                        var stopFlag = false
                        mainwindow.stopCounter()
                        console.log(startButton.startButIsPressed)

                        mainwindow.timecounterForPause()
                        startButtonBg.color = "#d6d7d7"
                        pauseButtonBg.color = "#c1ffe100"
                        startButton.startButIsPressed = false
                        mainwindow.js_startBtn = "Start"
                    }
                }
            }
        }
    }

    Rectangle {
        id: calendarbox
        height: parent.height * 0.40
        width: parent.width
        color: "#99ffffff"
        x: (parent.width - calendarbox.width) / 2
        y: mainbox.height + currentDate.height + 10
        radius: 10
        //  Gradient {
        //     GradientStop {
        //         position: 0
        //         color: "#6a000000"
        //     }

        //     GradientStop {
        //         position: 1
        //         color: "#fee140"
        //     }
        //     orientation: Gradient.Vertical
        // }
        // gradient: Gradient {
        //     id: calendarBoxGradient

        //         GradientStop {
        //             position: 0.0
        //             color: "#fdfdfd"
        //         }
        //         GradientStop {
        //             position: 1.0
        //             color: "#86525252"

        //     }

        //     orientation: Gradient.Vertical
        // }
        ColumnLayout {
            id: column
            x: 0
            y: 0
            height: parent.height
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.bottomMargin: 0
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.minimumHeight: parent.height * 0.4
            spacing: 5

            // ----------- Header ---------------------------
            Rectangle {
                id: rectangle

                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.1
                width: parent.width
                height: parent.height * 0.1
                //color: "#c7ff96"
                radius: 8
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                RowLayout {
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5

                    Button {
                        id: toLeft
                        text: "◀"
                        flat: true
                        Layout.leftMargin: 5
                        Layout.fillHeight: true
                        height: rectangle.height * 0.8
                        //y: (rectangle.height - toLeft.height) / 2
                        onClicked: {
                            if (monthGrid.month === 0) {
                                monthGrid.month = 11
                                monthGrid.year--
                            } else {
                                monthGrid.month--
                            }
                        }
                    }

                    Button {
                        id: monthBut
                        visible: true
                        text: getMonthName(
                                  monthGrid.month) + " " + monthGrid.year
                        font.pixelSize: parent.width * 0.03 + parent.height * 0.075
                        highlighted: false
                        flat: true
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.bold: true
                        width: parent.width * 0.9
                        height: parent.height

                        //styleColor: "#f7f3f3"
                        //style: Text.Outline
                        //color: "#3f3f3f"
                        onClicked: {
                            statPopup.open()
                            //send month name to cpp
                            mainwindow.monthInfo(monthBut.text)
                        }
                    }

                    Button {
                        id: toRight
                        text: "▶"
                        flat: true
                        Layout.fillHeight: true
                        Layout.rightMargin: 5
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                        height: rectangle.height * 0.8

                        //y: (rectangle.height - toRight.height) / 2
                        onClicked: {
                            if (monthGrid.month === 11) {
                                monthGrid.month = 0
                                monthGrid.year++
                            } else {
                                monthGrid.month++
                            }
                        }
                    }
                }
            }

            // Day names header
            DayOfWeekRow {
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.15
                locale: monthGrid.locale

                delegate: Text {
                    text: model.shortName
                    font.bold: true
                    style: Text.Raised
                    font.pixelSize: parent.height * 0.5
                    color: "#4b4b4b"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            // Month grid
            MonthGrid {
                id: monthGrid
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                //Layout.rightMargin: 20
                // width: parent.width - 50
                // height: parent.height * 0.8
                // x: parent.width / 2 - monthGrid.width / 2
                // y: window.height*0.25
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumHeight: parent.height * 0.5
                month: new Date().getMonth()
                year: new Date().getFullYear()

                locale: Qt.locale("en_US")
                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 8.0
                    samples: 17
                    color: "#80000000" // Semi-transparent black
                    transparentBorder: true
                }
                delegate: Rectangle {
                    required property var model

                    color: {
                        if (model.month !== monthGrid.month)
                            return "transparent"
                        if (isToday())
                            return "#4CAF50"
                        if (isSelected())
                            return "#2196F3"
                        return "white"
                    }
                    border.color: model.month === monthGrid.month ? "#e0e0e0" : "transparent"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: model.day
                        font.pixelSize: parent.width * 0.1 + parent.height * 0.1 //16
                        opacity: model.month === monthGrid.month ? 1 : 0.3
                        color: {
                            if (parent.isToday() || parent.isSelected())
                                return "white"
                            return model.month === monthGrid.month ? "#333" : "#999"
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        enabled: model.month === monthGrid.month
                        onClicked: {
                            selectedDate = model.date
                        }
                    }

                    function isToday() {
                        let today = new Date()
                        return model.day === today.getDate()
                                && model.month === today.getMonth()
                                && model.year === today.getFullYear()
                    }

                    function isSelected() {
                        if (!selectedDate)
                            return false
                        return model.day === selectedDate.getDate()
                                && model.month === selectedDate.getMonth()
                                && model.year === selectedDate.getFullYear()
                    }
                }
            }

            RoundButton {
                id: getDateData
                width: parent.width
                height: parent.height
                //x: 8
                //y: 5
                //width: 420
                //height: 40
                Layout.fillWidth: true
                radius: 10
                text: ""
                onClicked: {
                    popup.open()
                    mainwindow.depictDateData(dateText.text)
                }
                Text {
                    id: dateText
                    x: 30
                    y: -78
                    anchors.centerIn: parent
                    text: selectedDate ? selectedDate.toLocaleDateString(
                                             Qt.locale("en_US"),
                                             "dddd, d MMMM, yyyy") : ""
                    font.pixelSize: 16
                    anchors.verticalCenterOffset: 1
                    anchors.horizontalCenterOffset: 0
                    color: "#1976D2"
                }
            }

            // Selected date display
        }
    }

    Timer {
        id: countTimer
        interval: 1000
        repeat: true
        property int counter: 0
        onTriggered: {
            counter++
            mainwindow.colectAppData(startButton.text, breakButton.text)
        }
    }

    Timer {
        id: breakTimer
        interval: 1000
        repeat: true
        property int counter: 0
        onTriggered: {
            counter++
            var date = new Date(0, 0, 0, 0, 0, counter)
            breakButton.text = Qt.formatTime(date, "hh:mm:ss")
            breakButton.font.pointSize = parent.width * 0.01 + parent.height * 0.02
        }
    }

    /*----------------- sumary time on the screen ----------------*/
    Connections {
        target: mainwindow
        onSendCounterToBtn: function (cntr) {
            //console.log("cntr: ", cntr)
            startButton.text = cntr
            startButton.font.family = "Square721 BT"
            startButton.font.pointSize = upperRow.width * 0.01 + upperRow.height * 0.02
            startButton.style = Text.Raised
            // auto-start settings:
            // if (cntr) {
            //     startButton.startButIsPressed = true
            //     startButtonBg.color = "#bc15ff00"
            // }
        }
        onSendCounterToPauseBtn: function (pause_cntr) {
            console.log("pause cntr: ", pause_cntr)
            breakButton.text = pause_cntr
            breakButton.font.family = "Square721 BT"
            breakButton.font.pointSize = upperRow.width * 0.01 + upperRow.height * 0.02
            breakButton.style = Text.Raised
        }
        onStartButPressed: function (startedTime) {
            console.log(startedTime)
            startingTime.text = startedTime
        }
        onTotalTimeShow: function (totalTime) {
            summaryTime.text = totalTime
            //console.log("totalTime qml side: ", totalTime)
            summaryTime.font.pixelSize = mainbox.height * 0.06 + mainbox.width * 0.12
            summaryTime.font.family = "Square721 BT"
            summaryTime.font.bold = false
            summaryTime.color = "#ffdb00"
            summaryTime.style = Text.Raised
            //rectangle3.gradientType = 0
            hrsPrDay.text = timeStringToDecimalHours(totalTime)
        }
        function timeStringToDecimalHours(timeStr) {
            var parts = timeStr.split(":")
            var hours = parseInt(parts[0])
            var minutes = parseInt(parts[1])
            var seconds = parseInt(parts[2])

            var decimalHours = hours + (minutes / 60) + (seconds / 3600)
            return decimalHours.toFixed(2) // Returns "0.39"
        }

        function onAppStatusChanged() {
            console.log("App status changed to:", mainwindow.appStatus)
        }
    }

    property var selectedDate: new Date()

    function getMonthName(month) {
        const names = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        return names[month]
    }

    RoundButton {
        id: exitButton
        radius: 100
        text: " "
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.07
        height: parent.width * 0.07
        Image {
            id: exit
            visible: true
            anchors.fill: parent
            source: "rsc/no.png"
            fillMode: Image.PreserveAspectFit
        }
        onClicked: {
            // Save data first
            //saveData()
            mainwindow.exitSaveData()
            // Then exit
            Qt.quit()
        }
    }

    Popup {
        id: popup
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 3)
        width: parent.width - 50
        height: parent.height * 0.85
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        onClosed: {
            rowModel.clear()
            totalAmountHrs.text = "0"
        }
        /*-------------------- title -----------------------*/
        Rectangle {
            id: labelText
            width: parent.width
            height: parent.height * 0.1

            color: "#ffffff"
            radius: 5
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#fa709a"
                }

                GradientStop {
                    position: 1
                    color: "#fee140"
                }
                orientation: Gradient.Vertical
            }
            Text {
                id: datetext
                width: parent.width
                height: parent.height
                font.pixelSize: 24 //parent.width * 0.03 + parent.height * 0.075
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        /*-------------------- content ----------------------*/
        Rectangle {
            id: rectangle2
            width: parent.width
            height: parent.height * 0.825
            x: 0
            y: parent.height * 0.1

            //color: "#11b90f"
            Connections {
                target: mainwindow // Your C++ object
                onSendDateHeader: function (name) {
                    //datetext.text = name
                    var txt = name
                    var formated_str = txt.replace(/_/g, " ")
                    datetext.text = formated_str
                    console.log("Received:",
                                datetext.text) //has to be reseted after pop up demolishing
                }

                onSendDataToPopup: function (param1, cnt, total_time) {
                    var items = param1.split(" ")
                    var tt = parseFloat(total_time / 3600)
                    var tt_rounded = tt.toFixed(2)
                    rowModel.append({
                                        "digit": cnt,
                                        "text1": items[0] || " - ",
                                        "text2": items[1] || " - "
                                    })
                    console.log("items:", cnt, items[0], items[1])
                    //console.log("rowmodel cnt: ", rowModel.count)
                    console.log("[total time]: ", tt_rounded)
                    totalAmountHrs.text = tt_rounded
                }
                onSendHoursToTotalHrsInPopUp: function (hours) {
                    var hrs = hours
                    var th = parseFloat(hours / 3600)
                    var th_rounded = th.toFixed(2)
                    totalAmountHrs.text = th_rounded
                }
            }
            ListModel {
                id: rowModel
            }
            ScrollView {
                id: scrollView
                anchors.fill: parent
                width: parent.width
                height: parent.height * 0.85
                contentWidth: gridPopup.width
                contentHeight: gridPopup.height
                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff // Hide horizontal
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                Column {
                    id: gridPopup
                    width: scrollView.width
                    spacing: 2
                    //height: parent.height
                    Repeater {
                        model: rowModel
                        // Each iteration creates 4 cells (one complete row)
                        delegate: Rectangle {

                            width: parent.width
                            height: 42
                            color: index % 2 === 0 ? "#f5f5f5" : "white"
                            border.color: "#ddd"
                            Row {
                                id: row3
                                Rectangle {
                                    width: gridPopup.width * 0.1
                                    height: 40
                                    color: "lightblue"

                                    Text {
                                        anchors.centerIn: parent
                                        text: model.digit
                                        font.bold: true
                                    }
                                }

                                // Column 1: Text Part 1
                                Rectangle {
                                    width: gridPopup.width * 0.3
                                    height: 40
                                    color: "lightgreen"

                                    Text {
                                        anchors.centerIn: parent
                                        text: model.text1
                                    }
                                }

                                // Column 2: Text Part 2
                                Rectangle {
                                    width: gridPopup.width * 0.4
                                    height: 40
                                    color: "lightyellow"
                                    Image {
                                        id: edit
                                        width: 20 //parent.width * 0.2
                                        height: 20 //parent.width * 0.2
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: 1
                                        // ✅ Centered
                                        source: "rsc/edit.png"
                                        fillMode: Image.PreserveAspectFit
                                    }
                                    TextEdit {
                                        id: textEditField
                                        anchors.centerIn: parent
                                        text: model.text2
                                        property bool isUpdating: false

                                        onActiveFocusChanged: {
                                            if (activeFocus) {
                                                selectAll()
                                            }
                                        }

                                        onTextChanged: {
                                            if (isUpdating)
                                                return
                                            isUpdating = true

                                            var curPos = cursorPosition

                                            // Count digits in the text UP TO cursor position
                                            var textUpToCursor = text.substring(
                                                        0, curPos)
                                            var digitsTyped = textUpToCursor.replace(
                                                        /[^\d]/g, "").length

                                            // Get ALL digits from entire text
                                            var allDigits = text.replace(
                                                        /[^\d]/g, "")

                                            // Limit to 6
                                            if (allDigits.length > 6) {
                                                allDigits = allDigits.substring(
                                                            0, 6)
                                                digitsTyped = Math.min(
                                                            digitsTyped, 6)
                                            }

                                            // Format the time
                                            var formatted = ""
                                            if (allDigits.length > 0) {
                                                formatted = allDigits.substring(
                                                            0, Math.min(
                                                                2,
                                                                allDigits.length))
                                            }
                                            if (allDigits.length > 2) {
                                                formatted += ":" + allDigits.substring(
                                                            2, Math.min(
                                                                4,
                                                                allDigits.length))
                                            }
                                            if (allDigits.length > 4) {
                                                formatted += ":" + allDigits.substring(
                                                            4, 6)
                                            }

                                            // Apply text
                                            text = formatted

                                            // Position cursor AFTER the number of digits we typed
                                            // Formula: digitPosition + number of colons before it
                                            var newCursorPos = digitsTyped
                                            if (digitsTyped > 2)
                                                newCursorPos += 1 // Add 1 for first ":"
                                            if (digitsTyped > 4)
                                                newCursorPos += 1 // Add 1 for second ":"

                                            cursorPosition = newCursorPos

                                            rowModel.setProperty(index,
                                                                 "text2",
                                                                 formatted)

                                            isUpdating = false
                                        }
                                    }
                                }

                                // Column 3: Button
                                Rectangle {
                                    id: rectangle1
                                    width: gridPopup.width * 0.2
                                    height: 40
                                    color: "lightyellow"

                                    //anchors.fill: parent
                                    RoundButton {
                                        width: 35 //window.width * 0.1 //gridPopup.width * 0.1
                                        height: 35 //window.height * 0.05
                                        radius: 15 //gridPopup.height
                                        text: " "
                                        anchors.verticalCenter: parent.verticalCenter

                                        // anchors.left: edit.right
                                        anchors.right: parent.right
                                        // anchors.leftMargin: 5
                                        anchors.rightMargin: 0
                                        contentItem: Item {
                                            id: item3
                                            anchors.fill: parent

                                            Image {
                                                id: submit
                                                anchors.fill: parent
                                                anchors.leftMargin: 1
                                                anchors.rightMargin: 1
                                                anchors.topMargin: 1
                                                anchors.bottomMargin: 1

                                                //anchors.right: parent.right
                                                //anchors.rightMargin: 0
                                                source: "rsc/done.png"

                                                fillMode: Image.PreserveAspectFit
                                            }
                                        }

                                        background: Rectangle {

                                            //color: "#00000000"
                                            color: parent.down ? "#999999" : "#00000000"
                                            //color:
                                            radius: parent.radius
                                        }
                                        onClicked: {
                                            var dataString = ""

                                            for (var i = 0; i < rowModel.count; i++) {
                                                var item = rowModel.get(i)
                                                dataString += item.text1 + "," + item.text2 + "\n"
                                            }

                                            console.log(dataString)
                                            mainwindow.overWrite(dataString,
                                                                 datetext.text)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        /*-------------------- bottom line ------------------*/
        Rectangle {
            id: totalAmountRct
            width: parent.width
            height: parent.height * 0.075
            x: 0
            y: parent.height * 0.925
            color: "#8fff92"
            radius: 2
            border.color: "#ff7070"
            border.width: 1

            // Button {
            //     id: buttonAdd
            //     width: parent.height
            //     height: parent.height

            //     text: "+"
            //     onClicked: {
            //         console.log(dataString)
            //     }
            // }
            // Button {
            //     id: buttonExl
            //     width: parent.height
            //     height: parent.height
            //     anchors.left: buttonAdd.right
            //     anchors.leftMargin: 5
            //     text: "-"
            //     onClicked: {
            //         console.log(dataString)
            //     }
            // }
            Text {
                id: totalAmountHrs
                font.pixelSize: 22 //parent.width * 0.05 + parent.height * 0.1 // has to be adaptive
                // horizontalAlignment: Text.AlignRight - 15
                // verticalAlignment: Text.AlignVCenter
                text: "0"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
            }

            Text {
                id: totalText
                // width: parent.width
                // height: parent.height
                font.pixelSize: 18 //parent.width * 0.03 + parent.height * 0.075 // has to be adaptive
                // horizontalAlignment: Text.AlignLeft + 15
                // verticalAlignment: Text.AlignVCenter
                text: "Total:"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 5
            }
        }
    }

    Popup {
        id: statPopup
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: window.width - 50
        height: window.height * 0.85
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        // onClosed: {
        //     rowModel.clear()
        // }
        /*-------------------- title -----------------------*/
        Rectangle {
            id: statTitle
            width: parent.width
            height: parent.height * 0.05
            x: 0
            y: 0
            //color: "#c85904"
            Text {
                id: statText
                width: parent.width
                height: parent.height
                font.pixelSize: 24 //parent.width * 0.1 + parent.height * 0.2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "data for " + monthBut.text
            }
        }

        /*-------------------- content -----------------------*/
        Rectangle {
            id: statContent
            height: parent.height * 0.9
            width: parent.width
            x: 0
            y: statTitle.height + 5
            color: "#87f10ef5"
            gradient: Gradient {
                GradientStop {
                    position: 0.00
                    color: "#4fff8a"
                }
                GradientStop {
                    position: 1.00
                    color: "#38f9d7"
                }
            }

            Rectangle {
                id: gridBox
                width: statContent.width
                height: statContent.height * 0.05
                anchors.top: parent.top

                anchors.topMargin: 0
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#30fffeff"
                    }

                    GradientStop {
                        position: 1
                        color: "#d7fffe"
                    }
                    orientation: Gradient.Vertical
                }
                Rectangle {
                    id: statRec1
                    width: parent.width * 0.3
                    height: parent.height * 0.5
                    // color: "#c00206"
                    radius: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#96fbc4"
                        }

                        GradientStop {
                            position: 1
                            color: "#f9f586"
                        }
                        orientation: Gradient.Vertical
                    }

                    Text {
                        id: text1
                        text: qsTr("Today")
                        font.pixelSize: 14 //parent.height * 0.1 + parent.width * 0.1
                        anchors.verticalCenterOffset: -10
                        anchors.centerIn: parent
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Normal
                    }

                    Text {
                        id: hrsPrDay
                        text: qsTr("HOURS")
                        anchors.top: text1.bottom
                        anchors.topMargin: 0
                        font.pixelSize: 12
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: statRec2
                    width: parent.width * 0.3
                    height: parent.height * 0.5
                    //y: statRec1.height + 25
                    color: "#d8ffbc"
                    radius: 5
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#fff1eb"
                        }

                        GradientStop {
                            position: 1
                            color: "#ace0f9"
                        }
                        orientation: Gradient.Vertical
                    }
                    anchors.centerIn: parent

                    Text {
                        id: text3
                        text: qsTr("Max pr day")
                        font.pixelSize: 14 //parent.width * 0.1 + parent.height * 0.1
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: -10
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Normal
                    }

                    Text {
                        id: longestTime
                        text: qsTr("DATE")
                        anchors.top: text3.bottom
                        anchors.topMargin: 0
                        font.pixelSize: 12
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: statRec3
                    width: parent.width * 0.3
                    height: parent.height * 0.5
                    //y: statRec2.height + 25
                    color: "#0a28ec"
                    radius: 5

                    // anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#d5dee7"
                        }

                        GradientStop {
                            position: 0
                            color: "#ffafbd"
                        }

                        GradientStop {
                            position: 1
                            color: "#c9ffbf"
                        }
                        orientation: Gradient.Vertical
                    }

                    Text {
                        id: tHrs
                        text: qsTr("HOURS")
                        anchors.top: text6.bottom
                        anchors.topMargin: 0
                        font.pixelSize: 12
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        id: text6
                        text: qsTr("Total/month")
                        font.pixelSize: 13 //parent.width * 0.1 + parent.height * 0.1
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: -10
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Normal
                    }
                    //anchors.verticalCenter: parent.verticalCenter
                }
            }
            ChartView {
                id: chartBar
                //title: "Line Chart"
                antialiasing: true
                legend.visible: false
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: gridBox.bottom
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0

                //statContent.width * 0.67
                BarSeries {

                    axisX: BarCategoryAxis {
                        id: mySeries
                        categories: []
                    }

                    axisY: ValueAxis {
                        min: 0
                        max: 12
                        //titleText: "Hours"
                    }

                    BarSet {
                        id: hoursSet
                        //label: "Hr"
                        values: []
                        color: "#3498db"
                    }
                }
            }
        }
        /* ------------------- bottom line -------------------*/
        Rectangle {
            id: statBottomLine
            property var cats: []
            property var time: []
            height: parent.height * 0.05
            color: "#00ffffff"
            radius: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            width: parent.width

            //Color: "green"
            // x: 0
            // y: statText.height + statContent.height + 5
            RoundButton {
                id: xlsBut

                width: window.isPortrait ? 85 : 100 //100 //statBottomLine.width * 0.25
                height: window.isPortrait ? 35 : 45
                radius: 5

                text: "get txt"
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: window.isPortrait ? 0 : -2
                anchors.bottomMargin: window.isPortrait ? -7 : -10
                onClicked: {

                    fileDialog.open()
                    // mainwindow.writeToCSV(statBottomLine.cats,
                    //                       statBottomLine.time, monthBut.text)
                }
            }
            FileDialog {
                id: fileDialog
                title: "Save CSV File"

                nameFilters: ["TXT files (*.txt)", "CSV files (*.csv)", "All files (*)"]
                defaultSuffix: "txt"
                fileMode: FileDialog.SaveFile
                currentFolder: mainwindow.csvPath //has to be incl into func writeToCSV ars
                onAccepted: {

                    mainwindow.writeToCSV(statBottomLine.cats,
                                          statBottomLine.time,
                                          selectedFile.toString())
                    console.log("file name -> ", selectedFile)
                }
            }
        }
        Connections {
            target: mainwindow

            function onSendArrayToChart(active_time, day) {
                //console.log("Received array from C++")
                //console.log("Array: ", active_time)
                statBottomLine.cats = []
                statBottomLine.time = []
                var summ = 0
                for (var i = 0; i < active_time.length; i++) {
                    var value = (parseFloat(active_time[i]) / 3600)
                    summ += value
                    statBottomLine.cats.push(day[i])
                    statBottomLine.time.push(value.toFixed(2))
                    //console.log("Day", i + 1, ":", active_time[i], "hours")
                }
                // // Update chart directly
                hoursSet.values = statBottomLine.time
                mySeries.categories = statBottomLine.cats
                var average = summ / active_time.length
                console.log(average)
                //hrsPrDay.text = average.toFixed(2)
                tHrs.text = summ.toFixed(2)
                if (statBottomLine.time.length !== 0) {
                    var max = Math.max(...statBottomLine.time)
                } else {
                    longestTime.text = 0
                }

                console.log(max)
                longestTime.text = max.toFixed(2)
                //xlsBut.clicked(mainwindow.writeToCSV(cats, time))
            }
        }
    }
}
