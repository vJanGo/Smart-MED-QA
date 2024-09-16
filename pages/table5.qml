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
                model: ["病历ID", "患者ID", "预约ID", "诊断", "症状", "既往史", "更新时间"]
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
                color: "#e0e6ed"
                radius: 4
            }

            contentItem: Rectangle {
                implicitWidth: 8
                radius: 4
                color: parent.pressed ? "#7f8c8d" : "#bdc3c7"
            }
        }

        model: TableModel {
            id: tableModel
            TableModelColumn { display: "record_id" }
            TableModelColumn { display: "patient_id" }
            TableModelColumn { display: "appointment_id" }
            TableModelColumn { display: "diagnosis" }
            TableModelColumn { display: "symptoms" }
            TableModelColumn { display: "anamnesis" }
            TableModelColumn { display: "updated_at" }
        }

        delegate: Rectangle {
            implicitWidth: getColumnWidth(column)
            implicitHeight: 80
            color: row % 2 === 0 ? "#ffffff" : "#f5f9fc"

            Rectangle {
                anchors.fill: parent
                color: "#ecf0f1"
                opacity: 0
                Behavior on opacity { NumberAnimation { duration: 150 } }
            }

            Text {
                text: display
                anchors.fill: parent
                anchors.margins: 10
                font.pixelSize: 14
                color: "#34495e"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: column < 3 ? Text.AlignHCenter : Text.AlignLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideRight
                maximumLineCount: 3
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
        var widths = [0.08, 0.08, 0.08, 0.15, 0.20, 0.20, 0.21];
        return totalWidth * widths[index];
    }

    Component.onCompleted: {
        var data = [
            {"record_id":"1", "patient_id":"101", "appointment_id":"201", "diagnosis":"急性胃炎", "symptoms":"腹痛、恶心、呕吐", "anamnesis":"无既往重大病史", "updated_at":"2024-08-29 09:45"},
            {"record_id":"2", "patient_id":"102", "appointment_id":"202", "diagnosis":"高血压", "symptoms":"头晕、胸闷", "anamnesis":"家族遗传史", "updated_at":"2024-08-29 10:15"},
            {"record_id":"3", "patient_id":"103", "appointment_id":"203", "diagnosis":"糖尿病", "symptoms":"口渴、多尿", "anamnesis":"既往有糖尿病史", "updated_at":"2024-08-29 11:00"},
            {"record_id":"4", "patient_id":"104", "appointment_id":"204", "diagnosis":"支气管炎", "symptoms":"咳嗽、咳痰", "anamnesis":"患有哮喘", "updated_at":"2024-08-29 12:30"},
            {"record_id":"5", "patient_id":"105", "appointment_id":"205", "diagnosis":"偏头痛", "symptoms":"头部剧烈疼痛", "anamnesis":"有头痛病史", "updated_at":"2024-08-29 13:45"}
        ];

        for (var i = 0; i < data.length; i++) {
            tableModel.appendRow(data[i]);
        }
    }
}
