import QtQuick 2.13
import QtQuick.Controls 2.13
import Qt.labs.qmlmodels 1.0

Rectangle {
    width: 1000
    height: 600
    color: "#f5f7fa"

    Rectangle {
        id: header
        width: parent.width
        height: 50
        color: "#3498db"

        Row {
            spacing: 0
            Repeater {
                model: ["医生ID", "患者ID", "科室", "预约时间", "状态", "更新时间"]
                Rectangle {
                    width: getColumnWidth(index)
                    height: header.height
                    color: "#3498db"
                    border.width: 1
                    border.color: "#2980b9"

                    Text {
                        text: modelData
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        font.bold: true
                        color: "white"
                    }
                }
            }
        }
    }

    TableView {
        id: tableView
        width: parent.width
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        clip: true
        boundsBehavior: Flickable.StopAtBounds

        ScrollBar.vertical: ScrollBar {
            anchors.right: parent.right
            anchors.rightMargin: 0
            visible: tableView.contentHeight > tableView.height

            background: Rectangle {
                implicitWidth: 8
                color: "#e0e0e0"
                radius: 4
            }

            contentItem: Rectangle {
                implicitWidth: 8
                radius: 4
                color: parent.pressed ? "#606060" : "#909090"
            }
        }

        model: TableModel {
            id: tableModel
            TableModelColumn { display: "doctor_id" }
            TableModelColumn { display: "patient_id" }
            TableModelColumn { display: "department" }
            TableModelColumn { display: "scheduled_time" }
            TableModelColumn { display: "status" }
            TableModelColumn { display: "updated_at" }
        }

        delegate: Rectangle {
            implicitWidth: getColumnWidth(column)
            implicitHeight: 60
            color: row % 2 === 0 ? "#ffffff" : "#f9f9f9"

            Rectangle {
                anchors.fill: parent
                color: "#e3f2fd"
                opacity: 0
                Behavior on opacity { NumberAnimation { duration: 150 } }
            }

            Text {
                text: display
                anchors.fill: parent
                anchors.margins: 10
                font.pixelSize: 14
                color: column === 4 ? getStatusColor(display) : "#333333"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.children[0].opacity = 1
                onExited: parent.children[0].opacity = 0
            }
        }
    }

    function getColumnWidth(index) {
        var totalWidth = tableView.width;
        var widths = [0.1, 0.1, 0.15, 0.25, 0.15, 0.25];
        return totalWidth * widths[index];
    }

    function getStatusColor(status) {
        switch(status) {
            case "scheduled": return "#2ecc71";
            case "confirmed": return "#3498db";
            case "missed": return "#e74c3c";
            case "cancelled": return "#95a5a6";
            default: return "#333333";
        }
    }

    Component.onCompleted: {
        var data = [
            {"doctor_id":"1", "patient_id":"101", "department":"内科", "scheduled_time":"2024-08-29 09:00:00", "status":"已预约", "updated_at":"2024-08-28 15:30:00"},
            {"doctor_id":"2", "patient_id":"102", "department":"消化科", "scheduled_time":"2024-08-29 10:30:00", "status":"已确认", "updated_at":"2024-08-29 08:00:00"},
            {"doctor_id":"3", "patient_id":"103", "department":"心内科", "scheduled_time":"2024-08-29 11:00:00", "status":"已爽约", "updated_at":"2024-08-29 11:15:00"},
            {"doctor_id":"4", "patient_id":"104", "department":"内分泌科", "scheduled_time":"2024-08-29 14:00:00", "status":"已取消", "updated_at":"2024-08-28 16:45:00"},
            {"doctor_id":"5", "patient_id":"105", "department":"神经科", "scheduled_time":"2024-08-29 15:30:00", "status":"已预约", "updated_at":"2024-08-28 14:30:00"}
        ];

        for (var i = 0; i < data.length; i++) {
            tableModel.appendRow(data[i]);
        }
    }
}
