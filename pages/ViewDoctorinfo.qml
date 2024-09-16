//这个页面放大有问题，Grid锚定没有解决

import QtQuick
import QtQuick.Controls
import FluentUI
import "../button/"

FluPage {
    width: 800
    height: 800

    Rectangle {
        height: parent.height
        width: parent.width
        color: "transparent"

        FluComboBox {
            id: departmentComboBox
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            model: departmentList
            onActivated: {
                // TODO：当选择科室改变时，刷新医生表
                console.log("选择的科室: " + departmentComboBox.currentText)
            }
        }
        FluText{
            anchors.verticalCenter: departmentComboBox.verticalCenter
            anchors.right: departmentComboBox.left
            anchors.rightMargin: 20
            text: "科室"
        }
            // 创建一个Grid布局
            Grid {
                id: grid
                anchors.centerIn: parent
                columns: 2
                rowSpacing: 20
                columnSpacing: 20

                // 添加6个DisplayFrame组件
                DisplayFrame {
                    // 第一个组件内容
                    color: "white"
                    name: "Component 1"
                }
                DisplayFrame {
                    // 第二个组件内容
                    color: "white"
                    name: "Component 2"
                }
                DisplayFrame {
                    // 第三个组件内容
                    color: "white"
                    name: "Component 3"
                }
                DisplayFrame {
                    // 第四个组件内容
                    color: "white"
                    name: "Component 4"
                }
                DisplayFrame {
                    // 第五个组件内容
                    color: "white"
                    name: "Component 5"
                }
                DisplayFrame {
                    // 第六个组件内容
                    color: "white"
                    name: "Component 6"
                }
            }

            FluPagination{
                previousText: qsTr("<上一页")
                nextText: qsTr("下一页>")
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        pageCurrent: 1
                        pageButtonCount: 5
                        itemCount: 5000
                    }
            //选择页码的逻辑
            // Connections {

            //     onRequestPage: function(page, count) {
            //         console.log("当前请求页码:", page);  // 打印页码


            //     }
            // }
        }
    }

