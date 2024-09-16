import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    visible: true
    width: 900
    height: 900
    maximumWidth: 900
    maximumHeight: 900
    minimumWidth: 900
    minimumHeight: 900
    title: qsTr("Book a Free Consultation")


    Loader {
            id: pageLoader
            anchors.fill: parent
            visible: false  // Initially hidden
        }

    Item {
        anchors.fill: parent

        // Background Image
        Image {
            id: bgImage
            source: "source/bg1.jpeg"
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            z: -1  // 确保背景在其他元素后面
        }



        ScrollView {
            anchors.fill: parent
            contentWidth: availableWidth
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 20

                // 上方的间距
                Item {
                    Layout.preferredHeight: 20
                }

                // 应用程序标题
                Text {
                    text: "  BIT Health System"
                    font.pixelSize: 55
                    font.bold: true
                    color: "#1C1C1E"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "Helvetica Neue"
                }

                Item {
                    Layout.preferredHeight: 5
                }

                // 包含图片的矩形容器
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 160
                    height: 40
                    color: "#FFFFFF"  // 背景颜色
                    radius: 10  // 圆角

                    // 图片
                    Image {
                        source: "source/logo.jpeg"
                        anchors.centerIn: parent
                        width: 280
                        height: 280
                        fillMode: Image.PreserveAspectFit
                    }
                }



                // FOR NEW CLIENTS button
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 230
                    height: 64
                    radius: 22
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#34C759" }  // iOS green
                        GradientStop { position: 1.0; color: "#30D158" }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "开始使用"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#FFFFFF"
                        font.family: "Helvetica Neue"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            pageLoader.source = "Main.qml";  // Load Main.qml
                            pageLoader.visible = true;  // Show the loaded QML
                            window.visible = false;
                        }
                    }


                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -3
                        color: "#20000000"
                        radius: 25
                        z: -1
                    }
                }

                // Title card
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.9
                    height: titleText.height
                    color: "transparent"  // Changed to transparent
                    radius: 10

                    Text {
                        id: titleText
                        anchors.centerIn: parent
                        text: "制定免费咨询"
                        font.pixelSize: 35
                        font.bold: true
                        color: "#1C1C1E"  // iOS label color
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica Neue"
                    }

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -3
                        color: "#10000000"
                        radius: 13
                        z: -1
                        visible: false  // Hide the shadow for transparency
                    }
                }

                // Description card
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.9
                    height: descriptionText.height
                    color: "transparent"  // Changed to transparent
                    radius: 10

                    Text {
                        id: descriptionText
                        anchors.centerIn: parent
                        width: parent.width - 40
                        text: "我们提供全面的智慧医疗服务，包括健康评估、预约挂号、在线诊断等功能，全方位保障您的健康。"
                        font.pixelSize: 16
                        color: "#3C3C43"  // iOS secondary label color
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica Neue"
                    }

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -3
                        color: "#10000000"
                        radius: 13
                        z: -1
                        visible: false  // Hide the shadow for transparency
                    }
                }



                // Image card
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.8
                    height: width * 0.6
                    color: "#FFFFFF"
                    radius: 20  // Increased radius for rounded corners
                    clip: true  // Ensure the image is clipped to the rounded corners

                    Image {
                        anchors.fill: parent
                        source: "source/consultation.jpeg"
                        fillMode: Image.PreserveAspectCrop
                    }

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 5
                        color: "#10000000"
                        radius: 23
                        z: -1
                    }
                }

            }
        }
    }
}
