import QtQuick 2.13
import QtQuick.Controls 2.13
import Qt.labs.qmlmodels 1.0

Rectangle {
    width: 800
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
                model: ["用户名", "密码哈希", "用户类型", "创建时间"]
                Rectangle {
                    width: header.width/4
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
            TableModelColumn { display: "username" }
            TableModelColumn { display: "password_hash" }
            TableModelColumn { display: "user_type" }
            TableModelColumn { display: "created_at" }
        }

        delegate: Rectangle {
            implicitWidth: tableView.width/4
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

    Component.onCompleted: {
        var data = [
            {"username":"zhangsan","password_hash":"5f4dcc3b5aa765d61d8327deb882cf99","user_type":"医生","created_at":"2024-08-28 14:23:00"},
            {"username":"lisi","password_hash":"e99a18c428cb38d5f260853678922e03","user_type":"患者","created_at":"2024-08-29 09:10:00"},
            {"username":"wangwu","password_hash":"5f4dcc3b5aa765d61d8327deb882cf99","user_type":"管理员","created_at":"2024-08-27 08:45:00"},
            {"username":"zhaoliu","password_hash":"e99a18c428cb38d5f260853678922e03","user_type":"患者","created_at":"2024-08-28 12:00:00"},
            {"username":"sunqi","password_hash":"5f4dcc3b5aa765d61d8327deb882cf99","user_type":"医生","created_at":"2024-08-29 15:30:00"},
            {"username":"zhouba","password_hash":"e99a18c428cb38d5f260853678922e03","user_type":"患者","created_at":"2024-08-26 16:05:00"}
        ];

        for (var i = 0; i < data.length; i++) {
            tableModel.appendRow(data[i]);
        }
    }
}
