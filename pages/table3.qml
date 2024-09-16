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
        color: "#3498db"

        Row {
            spacing: 0
            Repeater {
                model: ["姓名", "性别", "年龄", "所属科室", "出诊时间", "每日接诊数量", "今日剩余号数量", "擅长治疗的病症"]
                Rectangle {
                    width: getColumnWidth(index)
                    height: header.height
                    color: "#3498db"
                    border.width: 1
                    border.color: "#2980b9"

                    Text {
                        text: modelData
                        anchors.centerIn: parent
                        font.pixelSize: 14
                        font.bold: true
                        color: "white"
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width - 10
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
            TableModelColumn { display: "doctor_name" }
            TableModelColumn { display: "gender" }
            TableModelColumn { display: "age" }
            TableModelColumn { display: "department" }
            TableModelColumn { display: "clinic_schedule" }
            TableModelColumn { display: "daily_appointments" }
            TableModelColumn { display: "remaining_slots_today" }
            TableModelColumn { display: "diseases_specializes_in" }
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
                anchors.centerIn: parent
                font.pixelSize: 13
                color: "#333333"
                wrapMode: Text.WordWrap
                width: parent.width - 10
                horizontalAlignment: Text.AlignHCenter
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
        var widths = [0.10, 0.06, 0.06, 0.12, 0.15, 0.15, 0.15, 0.21];
        return totalWidth * widths[index];
    }

    Component.onCompleted: {
        var data = [
            {"doctor_name":"张三", "gender":"男", "age":"45", "department":"内科", "clinic_schedule":"上午 8:00 - 12:00", "daily_appointments":"50", "remaining_slots_today":"10", "diseases_specializes_in":"心脏病、高血压"},
            {"doctor_name":"李四", "gender":"女", "age":"38", "department":"儿科", "clinic_schedule":"下午 14:00 - 18:00", "daily_appointments":"40", "remaining_slots_today":"5", "diseases_specializes_in":"儿童哮喘、过敏"},
            {"doctor_name":"王五", "gender":"男", "age":"50", "department":"骨科", "clinic_schedule":"全天 8:00 - 18:00", "daily_appointments":"30", "remaining_slots_today":"0", "diseases_specializes_in":"关节炎、骨折"},
            {"doctor_name":"赵六", "gender":"女", "age":"42", "department":"皮肤科", "clinic_schedule":"上午 9:00 - 12:00", "daily_appointments":"25", "remaining_slots_today":"15", "diseases_specializes_in":"湿疹、皮炎"},
            {"doctor_name":"孙七", "gender":"男", "age":"55", "department":"眼科", "clinic_schedule":"下午 13:00 - 17:00", "daily_appointments":"35", "remaining_slots_today":"20", "diseases_specializes_in":"白内障、青光眼"}
        ];

        for (var i = 0; i < data.length; i++) {
            tableModel.appendRow(data[i]);
        }
    }
}
