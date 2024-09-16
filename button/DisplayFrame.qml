import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

import FluentUI

Rectangle {
    id: container
    width: 400
    height: 150
    color: "#ffffff"
    radius: 10
    border.color: "#dcdcdc"
    border.width: 1

    property alias name: nameText.text
    property alias description: descriptionText.text
    property alias avatarSource: avatar.source

    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
        spacing: 15

        // 圆形头像
        Rectangle {
            id:circle
            width: 64
            height: 64
            radius: width / 2
            border.color: "blue"
            border.width: 1
            clip: true

            Image {
                anchors.fill: parent
                id: avatar
                fillMode: Image.PreserveAspectFit
                source: "path_to_avatar_image"
            }
        }

        // 手动布局姓名文本和简介文本
        Rectangle {
            width: container.width - circle.width -50
            height: 100
            anchors.verticalCenter: parent.verticalCenter

            // 姓名文本
            Text {
                id: nameText
                text: "小沈阳"
                font.pointSize: 16
                color: "#333333"
                anchors.top: parent.top
            }

            // 外部矩形包裹简介文本
            Rectangle {
                width: parent.width
                height: 60
                color: "#f0f0f0"
                border.color: "#cccccc"
                border.width: 1
                radius: 5
                anchors.top: nameText.bottom
                anchors.topMargin: 5

                // 简介文本，带滚动条
                ScrollView {
                    id: view
                    width: parent.width - 10  // 调整宽度以适应外部矩形的边距
                    height: parent.height - 10
                    anchors.centerIn: parent
                    clip: true
                    TextArea {
                        id: descriptionText
                        width: parent.width  // 确保文本宽度与ScrollView一致
                        text: "asjkdehgfjsahgf\nkjasdhdjashg\nfjksdafdsfgdsfgfdgfdgdrg\ndfsgfdgfdgdsfgfdgfd"
                        font.pointSize: 12
                        color: "#666666"
                        wrapMode: Text.WordWrap
                        readOnly: true
                    }
                }
            }
        }
    }
}


