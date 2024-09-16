import QtQuick 2.13
import QtQuick.Controls 2.13
import Qt.labs.qmlmodels 1.0

Rectangle {
    width: 1200
    height: 600
    color: "#f5f7fa"

    Rectangle {
        id: header
        width: parent.width
        height: 50
        color: "#34495e"

        Row {
            spacing: 0
            Repeater {
                model: ["诊断ID", "预约ID", "诊断", "医生备注", "处方", "更新时间"]
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
            TableModelColumn { display: "diagnosis_id" }
            TableModelColumn { display: "appointment_id" }
            TableModelColumn { display: "diagnosis" }
            TableModelColumn { display: "doctor_notes" }
            TableModelColumn { display: "prescription" }
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
                color: "#2c3e50"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: column < 2 ? Text.AlignHCenter : Text.AlignLeft
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
        var widths = [0.08, 0.08, 0.14, 0.25, 0.25, 0.20];
        return totalWidth * widths[index];
    }

    Component.onCompleted: {
        var data = [
            {"diagnosis_id":"1", "appointment_id":"201", "diagnosis":"急性胃炎", "doctor_notes":"建议多喝水，避免辛辣食物。", "prescription":"奥美拉唑、氟哌噻吨美利曲辛片", "updated_at":"2024-08-29 09:45"},
            {"diagnosis_id":"2", "appointment_id":"202", "diagnosis":"高血压", "doctor_notes":"定期测量血压，保持低盐饮食。", "prescription":"硝苯地平、氢氯噻嗪", "updated_at":"2024-08-29 10:15"},
            {"diagnosis_id":"3", "appointment_id":"203", "diagnosis":"糖尿病", "doctor_notes":"控制糖分摄入，定期检查血糖水平。", "prescription":"二甲双胍、格列本脲", "updated_at":"2024-08-29 11:00"},
            {"diagnosis_id":"4", "appointment_id":"204", "diagnosis":"支气管炎", "doctor_notes":"避免接触冷空气，多休息。", "prescription":"阿奇霉素、氨溴索口服液", "updated_at":"2024-08-29 12:30"},
            {"diagnosis_id":"5", "appointment_id":"205", "diagnosis":"偏头痛", "doctor_notes":"避免光线刺激，保持充足睡眠。", "prescription":"布洛芬、舒马曲坦", "updated_at":"2024-08-29 13:45"}
        ];

        for (var i = 0; i < data.length; i++) {
            tableModel.appendRow(data[i]);
        }
    }
}
