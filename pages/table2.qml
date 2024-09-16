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
                model: ["姓名", "性别", "年龄", "病症", "对接医师", "科室", "更新时间"]
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
            TableModelColumn { display: "patient_name" }
            TableModelColumn { display: "gender" }
            TableModelColumn { display: "age" }
            TableModelColumn { display: "condition" }
            TableModelColumn { display: "doctor_in_charge" }
            TableModelColumn { display: "department" }
            TableModelColumn { display: "updated_at" }
        }

        delegate: Rectangle {
            implicitWidth: getColumnWidth(column)
            implicitHeight: 40
            color: row % 2 === 0 ? "#ffffff" : "#f9f9f9"

            Rectangle {
                anchors.fill: parent
                color: "#e3f2fd"
                opacity: 0
                Behavior on opacity { NumberAnimation { duration: 150 } }
            }

            Text {
                text: display
                anchors.centerIn: parent
                font.pixelSize: 14
                color: "#333333"
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
        var widths = [0.1, 0.08, 0.08, 0.2, 0.15, 0.14, 0.25];
        return totalWidth * widths[index];
    }

    Component.onCompleted: {
        var data = [
            {"patient_name":"李四", "gender":"男", "age":"35", "condition":"感冒", "doctor_in_charge":"王医生", "department":"内科", "updated_at":"2024-08-29 10:30:00"},
            {"patient_name":"王五", "gender":"女", "age":"28", "condition":"胃病", "doctor_in_charge":"赵医生", "department":"消化科", "updated_at":"2024-08-29 11:15:00"},
            {"patient_name":"赵六", "gender":"男", "age":"42", "condition":"糖尿病", "doctor_in_charge":"钱医生", "department":"内分泌科", "updated_at":"2024-08-28 14:50:00"},
            {"patient_name":"孙七", "gender":"女", "age":"30", "condition":"偏头痛", "doctor_in_charge":"孙医生", "department":"神经科", "updated_at":"2024-08-28 09:20:00"},
            {"patient_name":"周八", "gender":"男", "age":"60", "condition":"高血压", "doctor_in_charge":"吴医生", "department":"心内科", "updated_at":"2024-08-29 13:40:00"}
        ];

        for (var i = 0; i < data.length; i++) {
            tableModel.appendRow(data[i]);
        }
    }
}
