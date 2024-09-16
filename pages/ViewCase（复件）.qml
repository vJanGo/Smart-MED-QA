import QtQuick
import QtQuick.Controls
import FluentUI

FluPage {
    width: 900
    height: 800

    //变量
    property int caseNum: 5

    Rectangle {
        height: parent.height
        width: parent.width
        color: "green"



        Column {
            anchors.fill: parent
            spacing: 10
            padding: 20

            FluText {
                text: "我的病历"
                font.pixelSize: 24
                color: "black"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                // anchors.top: parent.top
                // anchors.topMargin: 20
            }

            Grid {
                id: medicalRecordGrid
                columns: 1
                spacing: 20
                width: parent.width - 40
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 50
                anchors.topMargin: 100
                Repeater {
                    model: caseNum

                    Row {
                        spacing: 20
                        width: medicalRecordGrid.width
                        Rectangle {
                            width: medicalRecordGrid.width * 0.7
                            height: 50
                            color: "white"
                            border.color: "black"

                            Text {
                                anchors.centerIn: parent
                                text: "病例摘要信息 " + (index + 1)
                                color: "black"
                                font.pixelSize: 16
                            }
                        }

                        Button {
                            text: "查看详细"
                            width: 100
                            onClicked: {
                                // TODO: 显示详细病例信息的逻辑
                                console.log("查看病例 " + (index + 1))
                            }
                        }
                    }
                }
            }
        }
    }
}
