import QtQuick

import QtQuick.Controls
import QtQuick.Layouts
import QtCharts 2.10

Window {
    id: statPopup
    //parent: Overlay.overlay
    //x: Math.round((parent.width - width) / 2)
    //y: Math.round((parent.height - height) / 2)
    width: 480 //window.width - 50
    height: 1187 //window.height * 0.85
    //modal: true
    //focus: true
    //closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

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
        color: "#c85904"
        Text {
            id: statText
            width: parent.width
            height: parent.height
            font.pixelSize: parent.width * 0.03 + parent.height * 0.075
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "data for " + monthBut.text
        }
    }

    /*-------------------- content -----------------------*/
    Rectangle {
        id: statContent
        height: parent.height * 0.8
        color: "#1dde2f"
        width: parent.width
        x: 0
        y: statTitle.height + 5
        Rectangle {
            id: statRec1
            width: statContent.width * 0.3
            height: statContent.height * 0.2
            //statRec1.width + 25
            //y: statRec1.height + 25
            color: "#fb1f1f"
            radius: 10
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 5
            anchors.topMargin: 4
        }
        Rectangle {
            id: statRec2
            width: statContent.width * 0.3
            height: statContent.height * 0.2
            //y: statRec1.height + 25
            color: "#d8ffbc"
            radius: 10
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Rectangle {
            id: statRec3
            width: statContent.width * 0.3
            height: statContent.height * 0.2
            //y: statRec2.height + 25
            color: "#0a28ec"
            radius: 10
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 5
            anchors.topMargin: 5
        }
    }

    /* ------------------- bottom line -------------------*/
    Rectangle {
        id: statBottomLine
        height: parent.height * 0.05
        color: "#323e93"
        radius: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: parent.width
        Color: "green"
        x: 0
        RoundButton {
            id: xlsBut

            width: statBottomLine.width * 0.25
            height: statBottomLine.height * 0.5

            text: "save data into xls"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: statBottomLine.right
            anchors.rightMargin: 5
        }
    }
    Connections {
        target: mainwindow

        function onSendArrayToChart(active_time) {
            //console.log("Received array from C++")
            //console.log("Array: ", active_time)
            var cats = []
            var time = []
            // Access individual elements
            for (var i = 0; i < active_time.length; i++) {
                var value = (parseFloat(active_time[i]) / 3600)
                cats.push((i + 1).toString())
                time.push(value.toFixed(2))
                //console.log("Day", i + 1, ":", active_time[i], "hours")
            }
            // // Update chart directly
            hoursSet.values = time
            mySeries.categories = cats
            //console.log("Array: ", time)
        }
    }
}
