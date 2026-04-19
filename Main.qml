import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCharts 2.10
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects
import QtQuick.Dialogs
import QtCore

Window {
    id: window

    visible: true
    color: "#ffffff"
    property alias mainbox: mainbox
    flags: Qt.Window
    readonly property bool isMobile: Qt.platform.os === "android"
                                     || Qt.platform.os === "ios"

    // width: isMobile ? Screen.width : 368 //Screen.width : 368
    // height: isMobile ? Screen.height : 768
    // property bool isPortrait: width < window.height
    // property bool isLandscape: width > window.height
    width: isMobile ? Screen.desktopAvailableWidth : 368
    height: isMobile ? Screen.desktopAvailableHeight : 768
    readonly property bool isPortrait: Screen.height >= Screen.width
    readonly property bool isLandscape: Screen.width > Screen.height

    BorderImage {
        id: borderImage
        width: window.width
        height: window.height
        visible: true
        source: "rsc/background.jpg"
        clip: true

        Text {

            id: currentDate
            x: 0
            y: 12
            width: parent.width
            height: parent.height * 0.05
            color: "#8900d6"
            font.pointSize: parent.height * 0.015 + parent.width * 0.03
            horizontalAlignment: Text.AlignHCenter
            text: dateText.text
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
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height * 0.5
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.1
                }
                PropertyChanges {
                    target: calendarbox
                    height: parent.height * 0.40
                    width: parent.width
                    color: "#02ffffff"
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
                    width: statContent.width
                    height: statContent.height * 0.68
                    anchors.fill: undefined
                    anchors.left: statContent.left // replaces x: 0
                    anchors.top: gridBox.bottom // replaces y: 0
                    anchors.bottom: statContent.bottom
                    anchors.right: undefined
                }
                PropertyChanges {
                    target: gridBox
                    width: statContent.width
                    height: statContent.height * 0.1
                    anchors.top: statContent.top // replaces y: 0
                }
                PropertyChanges {
                    target: statTitle
                    width: parent.width
                    height: parent.height * 0.05
                    x: 0
                    y: 0
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
                PropertyChanges {
                    target: currentDate

                    //width: rectangle3.width
                    //height: rectangle3.height * 0.25
                    font.pixelSize: mainbox.height * 0.05 + mainbox.width * 0.05
                }
                AnchorChanges {
                    target: exitButton
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: undefined
                }
                PropertyChanges {
                    target: exitButton
                    radius: 5
                    anchors.rightMargin: 10
                    anchors.bottomMargin: 10
                    width: 50 //parent.width * 0.07
                    height: 30 //parent.width * 0.07
                }
            },
            State {
                name: "hor"
                when: window.isLandscape

                PropertyChanges {
                    target: calendarbox
                    x: parent.width * 0.5
                    y: currentDate.height + 5
                    width: parent.width * 0.45
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
                    width: statContent.width * 0.8
                    height: statContent.height
                    anchors.fill: undefined
                    anchors.left: undefined
                    anchors.right: undefined
                    anchors.top: statContent.top
                    anchors.topMargin: -10
                    anchors.bottom: statContent.bottom
                }
                PropertyChanges {
                    target: gridBox
                    x: chartBar.width + 1
                    y: 0
                    width: statContent.width * 0.2
                    height: statContent.height
                }
                PropertyChanges {
                    target: statTitle
                    y: -5
                    width: parent.width
                    height: parent.height * 0.1
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
                PropertyChanges {
                    target: summaryTime
                    width: rectangle3.width
                    height: rectangle3.heigh
                    font.pixelSize: mainbox.height * 0.05 + mainbox.width * 0.1
                }
                PropertyChanges {
                    target: currentDate
                    x: 0
                    y: -5
                    font.pixelSize: mainbox.height * 0.05 + mainbox.width * 0.05
                }
                AnchorChanges {
                    target: exitButton
                    anchors.right: undefined
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                PropertyChanges {
                    target: exitButton
                    radius: 5

                    // anchors.left: undefined
                    // anchors.top: undefined
                    // anchors.centerIn: undefined
                    // anchors.right: undefined
                    // anchors.horizontalCenter: window.horizontalCenter
                    //anchors.bottom: window.bottom
                    anchors.bottomMargin: 5
                    // x: (window.x - exitButton.width)
                    // y: 0
                    width: 50 //parent.width * 0.07
                    height: 30 //parent.width * 0.07
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
                x: 8
                height: parent.height
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.01
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
                height: parent.height
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.01
                spacing: 5
                Text {
                    id: startTime
                    text: qsTr("Started at:")
                    font.pointSize: (parent.width * 0.05 + parent.height * 0.5) / 2
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
            anchors.bottomMargin: 40

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
                        mainwindow.onEnd()
                        var now = new Date()
                        var formated_str = Qt.formatDate(now, "dd_MMMM_yyyy")
                        console.log("formated date in end btn: ", formated_str)

                        mainwindow.calculatetime(formated_str)
                        startButton.text = "Start"
                        breakButton.text = "Pause"
                        endingTime.text = endtime
                        startButtonBg.color = "#d6d7d7"
                        pauseButtonBg.color = "#d6d7d7"
                        startButton.startButIsPressed = false
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
            anchors.verticalCenterOffset: -10
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
                function startClick() {
                    if (startButton.startButIsPressed === false) {
                        mainwindow.onStart()
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
                    }
                    //startingTime.text = mainwindow.js_started
                }

                onClicked: startClick()
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
                property bool pauseButIsPressed: false
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
                        var pauseFlag = false
                        mainwindow.onPause()
                        startButton.text = "Start"
                        var stopFlag = false
                        mainwindow.stopCounter()
                        console.log("mainwindow.js_pauseBtn ",
                                    mainwindow.js_pauseBtn)

                        mainwindow.timecounterForPause()
                        startButtonBg.color = "#d6d7d7"
                        pauseButtonBg.color = "#c1ffe100"
                        startButton.startButIsPressed = false
                    }
                    breakButton.pauseButIsPressed = true
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

                        flat: true
                        // Layout.leftMargin: 5
                        // Layout.fillHeight: true
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        height: rectangle.height * 0.8
                        //y: (rectangle.height - toLeft.height) / 2
                        background: Rectangle {
                            color: "transparent"
                            border.color: "transparent"
                        }
                        contentItem: Item {
                            id: item4
                            anchors.fill: parent

                            Image {
                                id: options
                                anchors.fill: parent
                                anchors.leftMargin: 1
                                anchors.rightMargin: 1
                                anchors.topMargin: 1
                                anchors.bottomMargin: 1
                                source: "rsc/left.png"

                                fillMode: Image.PreserveAspectFit
                            }
                        }
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
                        // Layout.fillHeight: true
                        // Layout.fillWidth: true
                        // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.bold: true
                        width: parent.width * 0.9
                        height: parent.height
                        onClicked: {
                            statPopup.open()
                            mainwindow.monthInfo(monthBut.text)
                        }
                    }

                    Button {
                        id: toRight
                        flat: true
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        height: rectangle.height * 0.8
                        background: Item {}
                        contentItem: Item {
                            //id: item4
                            anchors.fill: parent

                            Image {
                                //id: options
                                anchors.fill: parent
                                anchors.leftMargin: 1
                                anchors.rightMargin: 1
                                anchors.topMargin: 1
                                anchors.bottomMargin: 1
                                source: "rsc/right.png"

                                fillMode: Image.PreserveAspectFit
                            }
                        }
                        onClicked: {
                            color: "gray"
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
                //height: parent.height * 0.5
                Layout.fillWidth: true
                Layout.preferredHeight: window.isLandscape ? parent.height
                                                             * 0.15 : parent.height * 0.15
                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 8.0
                    samples: 17
                    color: "#80000000" // Semi-transparent black
                    transparentBorder: true
                }
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
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

        onSendCounterToBtn: function (cntr, isPressed) {
            startButton.startClick()
            startButton.text = cntr
            startButton.font.family = "Square721 BT"
            startButton.font.pointSize = upperRow.width * 0.01 + upperRow.height * 0.02
            startButtonBg.color = "#bc15ff00"
        }
        onSendCounterToPauseBtn: function (pause_cntr, isPressed) {
            startButton.startButIsPressed = false
            pauseButtonBg.color = "#c1ffe100"
            breakButton.text = pause_cntr
            breakButton.font.family = "Square721 BT"
            breakButton.font.pointSize = upperRow.width * 0.01 + upperRow.height * 0.02
            if (isPressed) {

            }
        }
        onStartButPressed: function (Time) {
            console.log(Time)
            startingTime.text = Time //mainwindow.js_startTime
        }
        onTotalTimeShow: function (totalTime) {
            summaryTime.text = totalTime
            summaryTime.font.pixelSize = mainbox.height * 0.06 + mainbox.width * 0.12
            summaryTime.font.family = "Square721 BT"
            summaryTime.font.bold = false
            summaryTime.color = "#ffdb00"
            summaryTime.style = Text.Raised
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
        radius: 10

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        //width: parent.width * 0.07
        //height: parent.height * 0.07
        text: "Exit"
        // Image {
        //     id: exit
        //     visible: true
        //     anchors.fill: parent
        //     source: "rsc/no.png"
        //     fillMode: Image.PreserveAspectFit
        // }
        onClicked: {
            mainwindow.exitSaveData()
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
        //visible: true //Qt.application.arguments.indexOf("--design") !== -1
        clip: false
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        onClosed: {
            rowModel.clear()
            totalAmountHrs.text = "0"
            addNewLineInPopup.visible = true
            rectangle2.cnt = 1
            saveDelLines.visible = false
        }
        /*-------------------- title -----------------------*/
        Rectangle {

            id: labelText
            width: parent.width
            height: parent.height * 0.1
            opacity: 0.7
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
                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 2
                    radius: 5.0
                    samples: 17
                    color: "#80000000"
                    transparentBorder: true
                }
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

            //color: "#88baff"
            property int cnt: 1

            function addLine() {
                rowModel.append({
                                    "digit": rectangle2.cnt,
                                    "text1": " edit ",
                                    "text2": " 00:00:00"
                                })
                rectangle2.cnt += 1
                console.log("param1, cnt, total_time")
            }
            function delLine(index) {
                rowModel.remove(index)
                rectangle2.cnt -= 1
                console.log("param1, cnt, total_time")
                for (var i = 0; i < rowModel.count; i++) {
                    rowModel.setProperty(i, "digit", i + 1)
                }
                if (rowModel.count === 0) {
                    saveDelLines.visible = true
                }
                console.log("row count ", rowModel.count)
            }

            Connections {
                target: mainwindow
                onSendDateHeader: function (name) {

                    var txt = name
                    var formated_str = txt.replace(/_/g, " ")
                    datetext.text = formated_str
                    console.log("Received:", datetext.text)
                }

                onSendDataToPopup: function (param1, cnt, total_time) {
                    console.log("data from file: ", param1, cnt, total_time)
                    if (param1 && cnt && total_time) {
                        addNewLineInPopup.visible = false // ✅ show button when all are empty/null
                    }

                    var items = param1.split(" ")
                    var tt = parseFloat(total_time / 3600)
                    var tt_rounded = tt.toFixed(2)
                    rowModel.append({
                                        "digit": cnt,
                                        "text1": items[0] || " - ",
                                        "text2": items[1] || " - "
                                    })
                    console.log("items:", cnt, items[0], items[1])
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
            Button {
                /* add new line in the case od absence of data*/
                id: addNewLineInPopup
                width: 25
                height: 25
                z: 10
                visible: true
                property bool toggle: false
                Text {
                    id: popUpBtnText
                    width: parent.width
                    height: parent.height
                    font.pixelSize: 24 //parent.width * 0.03 + parent.height * 0.075
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "+"
                }
                anchors.top: rectangle2.top
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    //getData("edit line", 1, "00:00:00")
                    rowModel.append({
                                        "digit": rectangle2.cnt,
                                        "text1": " edit ",
                                        "text2": " 00:00:00"
                                    })
                    rectangle2.cnt += 1
                    console.log("param1, cnt, total_time")
                    addNewLineInPopup.visible = false
                }
            }

            Button {
                /* del last line in the case od absence of data*/
                id: saveDelLines
                width: 40
                height: 25
                z: 10
                visible: false
                property bool toggle: false
                Text {

                    width: parent.width
                    height: parent.height
                    font.pixelSize: 14 //parent.width * 0.03 + parent.height * 0.075
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Save"
                }
                anchors.top: rectangle2.top
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    //getData("edit line", 1, "00:00:00")
                    var dataString = ""
                    mainwindow.overWrite(dataString, datetext.text)
                }
            }

            Image {
                anchors.fill: parent
                source: "rsc/bkgr.jpg"
                fillMode: Image.PreserveAspectCrop
            }
            ScrollView {
                id: scrollView
                anchors.fill: parent
                width: parent.width
                height: parent.height * 0.85
                contentWidth: gridPopup.width
                contentHeight: gridPopup.height
                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                Column {
                    id: gridPopup
                    width: scrollView.width
                    spacing: 2
                    Repeater {
                        model: rowModel
                        delegate: Rectangle {

                            width: parent.width
                            height: 42
                            //color: index % 2 === 0 ? "#f5f5f5" : "white"
                            //border.color: "#ddd"
                            Row {
                                id: row3
                                spacing: 2
                                Rectangle {
                                    width: gridPopup.width * 0.1
                                    height: 40
                                    radius: 5
                                    color: "lightblue"
                                    layer.enabled: true
                                    layer.effect: DropShadow {
                                        horizontalOffset: 0
                                        verticalOffset: 4
                                        radius: 8.0
                                        samples: 17
                                        color: "#80000000" // Semi-transparent black
                                        transparentBorder: true
                                    }
                                    Text {
                                        anchors.centerIn: parent
                                        text: model.digit
                                        font.bold: true
                                    }
                                }

                                Rectangle {
                                    width: gridPopup.width * 0.35
                                    height: 40
                                    radius: 5
                                    color: "lightgreen"
                                    layer.enabled: true
                                    layer.effect: DropShadow {
                                        horizontalOffset: 0
                                        verticalOffset: 4
                                        radius: 8.0
                                        samples: 17
                                        color: "#80000000" // Semi-transparent black
                                        transparentBorder: true
                                    }
                                    TextEdit {
                                        id: textEditTypeOfEvent
                                        anchors.centerIn: parent
                                        text: model.text1
                                        property bool isUpdating: false

                                        onActiveFocusChanged: {
                                            if (activeFocus) {
                                                selectAll()
                                            }
                                        }

                                        onTextChanged: {
                                            rowModel.setProperty(
                                                        index, "text1",
                                                        text) // ✅ saves on every keystroke
                                        }
                                    }
                                }
                                Rectangle {
                                    width: gridPopup.width * 0.45
                                    height: 40
                                    color: "lightyellow"
                                    radius: 5
                                    layer.enabled: true
                                    layer.effect: DropShadow {
                                        horizontalOffset: 0
                                        verticalOffset: 4
                                        radius: 8.0
                                        samples: 17
                                        color: "#80000000" // Semi-transparent black
                                        transparentBorder: true
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
                                            var textUpToCursor = text.substring(
                                                        0, curPos)
                                            var digitsTyped = textUpToCursor.replace(
                                                        /[^\d]/g, "").length
                                            var allDigits = text.replace(
                                                        /[^\d]/g, "")
                                            if (allDigits.length > 6) {
                                                allDigits = allDigits.substring(
                                                            0, 6)
                                                digitsTyped = Math.min(
                                                            digitsTyped, 6)
                                            }
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
                                            text = formatted
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
                                Rectangle {
                                    id: rectangle1
                                    width: gridPopup.width * 0.075
                                    height: 40
                                    radius: 5
                                    //color: "lightyellow"
                                    layer.enabled: true
                                    layer.effect: DropShadow {
                                        horizontalOffset: 0
                                        verticalOffset: 4
                                        radius: 8.0
                                        samples: 17
                                        color: "#80000000" // Semi-transparent black
                                        transparentBorder: true
                                    }
                                    Button {
                                        width: 30
                                        height: 30
                                        text: " "
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        //anchors.right: parent.right
                                        //anchors.rightMargin: 25
                                        //background: Item {}
                                        background: Rectangle {
                                            color: "transparent"
                                            border.color: "transparent"
                                        }
                                        contentItem: Item {
                                            //id: item4
                                            anchors.fill: parent

                                            Image {
                                                //id: options
                                                anchors.fill: parent
                                                anchors.leftMargin: 1
                                                anchors.rightMargin: 1
                                                anchors.topMargin: 1
                                                anchors.bottomMargin: 1
                                                source: "rsc/config.png"

                                                fillMode: Image.PreserveAspectFit
                                            }
                                        }
                                        onClicked: {
                                            menu.open()
                                        }
                                    }
                                    Menu {
                                        id: menu
                                        x: -10
                                        y: (item4.height - height) / 2
                                        width: 80

                                        height: 150
                                        MenuItem {
                                            text: "add line"
                                            onClicked: {
                                                rectangle2.addLine()
                                            }
                                        }
                                        MenuItem {
                                            text: "del line"
                                            onClicked: {
                                                rectangle2.delLine(index)
                                            }
                                        }
                                        MenuItem {
                                            text: "Save"
                                            onClicked: {
                                                var dataString = ""
                                                for (var i = 0; i < rowModel.count; i++) {
                                                    var item = rowModel.get(i)
                                                    dataString += item.text1 + ","
                                                            + item.text2 + "\n"
                                                }
                                                console.log(dataString)
                                                mainwindow.overWrite(
                                                            dataString,
                                                            datetext.text)
                                            }
                                        }
                                    }
                                    // RoundButton {
                                    //     width: 35
                                    //     height: 35
                                    //     radius: 15
                                    //     text: " "
                                    //     anchors.verticalCenter: parent.verticalCenter
                                    //     anchors.right: parent.right
                                    //     anchors.rightMargin: 0
                                    //     contentItem: Item {
                                    //         id: item3
                                    //         anchors.fill: parent

                                    //         Image {
                                    //             id: submit
                                    //             anchors.fill: parent
                                    //             anchors.leftMargin: 1
                                    //             anchors.rightMargin: 1
                                    //             anchors.topMargin: 1
                                    //             anchors.bottomMargin: 1
                                    //             source: "rsc/done.png"

                                    //             fillMode: Image.PreserveAspectFit
                                    //         }
                                    //     }

                                    //     background: Rectangle {
                                    //         color: parent.down ? "#999999" : "#00000000"
                                    //         //color:
                                    //         radius: parent.radius
                                    //     }
                                    //     onClicked: {
                                    //         var dataString = ""
                                    //         for (var i = 0; i < rowModel.count; i++) {
                                    //             var item = rowModel.get(i)
                                    //             dataString += item.text1 + "," + item.text2 + "\n"
                                    //         }
                                    //         console.log(dataString)
                                    //         mainwindow.overWrite(dataString,
                                    //                              datetext.text)
                                    //     }
                                    // }
                                }
                            }
                            /*row with edit buttons*/
                            // Row {
                            //     id: editButRow
                            //     spacing: 15
                            //     height: 40

                            //     Rectangle {
                            //         color: red
                            //         height: parent.height
                            //         width: parent.width * 0.5
                            //         anchors.verticalCenter: parent.verticalCenter
                            //         anchors.verticalCenterOffset: 10
                            //         anchors.horizontalCenter: parent.horizontalCenter
                            //         Button {}
                            //         Button {}
                            //     }
                            // }
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
            opacity: 0.7
            Text {
                id: totalAmountHrs
                font.pixelSize: 22
                text: "0"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
            }

            Text {
                id: totalText

                font.pixelSize: 18

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
        x: Math.round(
               (window.width - width) / 2) //from parent.width to screen.width
        y: Math.round((window.height - height) / 2)
        width: window.width
        height: window.height * 0.85
        modal: true
        focus: true
        //visible: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        Image {
            anchors.fill: parent
            source: "rsc/bkgr.jpg"
            fillMode: Image.PreserveAspectCrop
        }
        /*-------------------- title -----------------------*/
        Rectangle {
            id: statTitle
            width: parent.width
            height: parent.height * 0.05
            x: 0
            y: 0
            color: "#ffffff"
            Text {
                id: statText
                width: parent.width
                height: parent.height
                font.pixelSize: 21 //parent.width * 0.1 + parent.height * 0.2
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
            color: "transparent"

            Rectangle {
                id: gridBox
                width: statContent.width
                height: statContent.height * 0.05
                anchors.top: parent.top
                anchors.topMargin: 0
                color: "transparent"

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
                            position: 0.00
                            color: "#96fbc4"
                        }
                        GradientStop {
                            position: 1.00
                            color: "#f9f586"
                        }
                    }

                    Text {
                        id: text1
                        text: qsTr("Today")
                        font.pixelSize: 14
                        anchors.verticalCenterOffset: -10
                        anchors.centerIn: parent
                        fontSizeMode: Text.HorizontalFit
                        font.weight: Font.Normal
                    }

                    Text {
                        id: hrsPrDay
                        text: qsTr("---")
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
                        text: qsTr("Avg pr day")
                        font.pixelSize: 14
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

                    color: "#0a28ec"
                    radius: 5
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
                }
            }
            ChartView {

                id: chartBar
                //add new aproach with Screen.devicePixelRatio and to enhance screnshot quality
                width: parent.width //* Screen.devicePixelRatio
                height: parent.height // * Screen.devicePixelRatio
                //scale: 1.0 / Screen.devicePixelRatio // scale back down visually so it fits on screen
                //transformOrigin: Item.TopLeft
                //end
                antialiasing: true
                legend.visible: false
                anchors.left: statContent.left
                anchors.right: statContent.right
                anchors.top: gridBox.bottom
                anchors.bottom: statContent.bottom
                Rectangle {
                    id: chartLbl
                    width: contentRow.implicitWidth + 16
                    height: 25 //parent.height * 0.15
                    visible: false
                    color: "#0a28ec"
                    radius: 5
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 55
                    anchors.rightMargin: 30
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#5dff0215"
                        }

                        GradientStop {
                            position: 0
                            color: "#460900ff"
                        }

                        GradientStop {
                            position: 1
                            color: "#4a28ff00"
                        }
                        orientation: Gradient.Vertical
                    }
                    Row {
                        id: contentRow
                        anchors.centerIn: parent
                        spacing: 4
                        Text {
                            id: chartLabel
                            text: qsTr("Total:")
                            font.pixelSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                            fontSizeMode: Text.HorizontalFit
                            font.weight: Font.Normal
                        }
                        Text {
                            id: chartLabelHours
                            text: qsTr("  ")
                            font.pixelSize: 10
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            id: hrLabel
                            text: qsTr("hrs")
                            font.pixelSize: 12 //parent.width * 0.1 + parent.height * 0.1
                            anchors.verticalCenter: parent.verticalCenter

                            fontSizeMode: Text.HorizontalFit
                            font.weight: Font.Normal
                        }
                    }
                }
                BarSeries {
                    id: barSeries
                    axisX: BarCategoryAxis {
                        id: mySeries
                        categories: []
                        labelsFont.pixelSize: Math.max(4, chartBar.width * 0.01)
                        labelsColor: "blue"
                        labelsAngle: -45 // rotate labels, useful for long text
                        //gridVisible: true
                        //lineVisible: false
                    }

                    axisY: ValueAxis {
                        min: 0
                        max: 12
                        labelsFont.pixelSize: Math.max(4, chartBar.width * 0.01)
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
            //color: "#00f10a0a"
            color: "transparent"
            radius: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: -10
            width: parent.width
            Row {
                id: rowSaveBtn
                anchors.centerIn: parent
                spacing: 10
                RoundButton {
                    id: xlsBut
                    width: window.isPortrait ? 85 : 100
                    height: window.isPortrait ? 35 : 35
                    radius: 5
                    text: "get txt"
                    // x: 0
                    // y: parent.height - 20
                    onClicked: {
                        fileDialog.open()
                    }
                }
                RoundButton {
                    id: picBut
                    width: window.isPortrait ? 85 : 100
                    height: window.isPortrait ? 35 : 35
                    radius: 5
                    // x: parent.width - 85
                    // y: parent.height - 20
                    text: "get image"
                    onClicked: {
                        //statBottomLine.saveChart(statText.text + ".png")
                        statBottomLine.saveChart(statText.text)
                        popupDelay.start()
                    }
                }
            }
            function saveChart(fileName) {
                var localPath = ""

                var timestamp = new Date().getTime() // unique per save
                var uniqueName = fileName + "_" + timestamp + ".png"
                console.log("file name to be saved ", uniqueName)
                if (window.isMobile) {
                    localPath = "/storage/emulated/0/Download/" + uniqueName
                    localPath = localPath.toString().replace("file://", "")
                } else {
                    localPath = mainwindow.imgPath + uniqueName
                    localPath = localPath.toString()
                }
                console.log("Attempting to save to:", localPath)
                chartBar.title = statText.text
                chartLabelHours.text = tHrs.text
                chartLabelHours.font.pixelSize = 16
                chartLbl.visible = true
                // chartBar.width = window.isMobile ? Screen.width : 1024
                // chartBar.height = window.isMobile ? Screen.height : 768
                Qt.callLater(function () {
                    /*moved to timer chartDrawDelay section */
                    // chartBar.grabToImage(function (result) {
                    //     var success = result.saveToFile(localPath)
                    //     if (success) {
                    //         console.log("Saved to:", localPath)
                    //         console.log("Image size:", result.image.width, "x",
                    //                     result.image.height)
                    //         console.log("screen size:", Screen.width,
                    //                     Screen.height)
                    //         console.log("chartBar size:", chartBar.width,
                    //                     chartBar.height)
                    //         console.log("Qt version:", Qt.version)
                    //     } else {
                    //         console.log("Failed to save to:", localPath)
                    //     }
                    // }, Qt.size(statContent.width * 5, statContent.height * 5))
                    //isPortrait ? Qt.size(2000, 2400) : Qt.size(2400, 1600))
                    /*==========================================================*/
                    var grabW = Math.round(statContent.width * 5)
                    var grabH = Math.round(statContent.height * 5)

                    console.log("Scheduled grab size:", grabW, "x", grabH)

                    chartDrawDelay.pendingPath = localPath
                    chartDrawDelay.pendingSize = Qt.size(grabW, grabH)
                    chartDrawDelay.start()
                })
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
            Timer {
                id: popupDelay
                interval: 1000 // 1 second
                repeat: false
                onTriggered: saveWarningPopup.open()
            }
            Timer {
                id: chartDrawDelay
                interval: 150
                repeat: false
                property string pendingPath: ""
                property size pendingSize: Qt.size(0, 0)

                onTriggered: {
                    console.log("=== GRAB DIAGNOSTIC ===")
                    console.log("Screen:", Screen.width, "x", Screen.height)
                    console.log("statContent:", statContent.width, "x",
                                statContent.height)
                    console.log("chartBar:", chartBar.width, "x",
                                chartBar.height)
                    console.log("isPortrait:", window.isPortrait)
                    console.log("pendingSize:", pendingSize.width, "x",
                                pendingSize.height)

                    chartBar.grabToImage(function (result) {
                        // var success = result.saveToFile(pendingPath)
                        // if (success) {
                        //     console.log("Saved to:", pendingPath)
                        //     console.log("Image size:", result.image.width, "x",
                        //                 result.image.height)
                        //     console.log("chartBar size:", chartBar.width,
                        //                 chartBar.height)
                        //     console.log("statContent size:", statContent.width,
                        //                 statContent.height)
                        // } else {
                        //     console.log("Failed to save:", pendingPath)
                        // }
                        console.log("Grabbed image:", result.image.width, "x",
                                    result.image.height)
                        result.saveToFile(pendingPath)
                    }, pendingSize)
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
                hoursSet.values = statBottomLine.time
                mySeries.categories = statBottomLine.cats
                var average = summ / active_time.length
                console.log("average pr day ", average)
                longestTime.text = average.toFixed(2)
                tHrs.text = summ.toFixed(2)
            }
        }
        onClosed: {
            chartBar.title = ""
            chartLbl.visible = false
        }
    }

    Popup {
        id: saveWarningPopup
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: window.width * 0.75
        height: window.height * 0.10
        // width: Math.min(contentItem.implicitWidth + 15 * 2, window.width * 0.9)
        // height: Math.min(contentItem.implicitHeight + 15 * 2,
        //                  window.height * 0.5)
        modal: true
        focus: true
        //visible: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        background: Rectangle {
            color: "#ffffff"
            opacity: 0.5
            radius: 10
        }

        // Rectangle {
        //     width: parent.width
        //     height: parent.height * 0.05
        //     color: "#00ffffff"
        //     anchors.horizontalCenter: parent.horizontalCenter
        //     anchors.verticalCenter: parent.verticalCenter
        padding: 10 // controls spacing around content
        contentItem: Column {
            spacing: 8
            Text {
                id: savedToDownloads
                width: parent.width
                height: parent.height
                font.pixelSize: 24 //parent.width * 0.1 + parent.height * 0.2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "Saved to Downloads"
            }
        }
    }
}
