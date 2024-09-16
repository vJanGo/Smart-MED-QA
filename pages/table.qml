import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 1400
    height: 1000
    title: "Enhanced Medical Dashboard"
    color: "#f8f9fa"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Header with buttons
        Rectangle {
            Layout.fillWidth: true
            height: 80
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#ffffff" }
                GradientStop { position: 1.0; color: "#f8f9fa" }
            }
            border.color: "#e0e0e0"
            border.width: 1

            // Simple shadow effect
            Rectangle {
                anchors.top: parent.bottom
                width: parent.width
                height: 4
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#20000000" }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }

            RowLayout {
                anchors.fill: parent
                spacing: 20
                anchors.leftMargin: 30
                anchors.rightMargin: 30

                Text {
                    text: "医疗管理系统"
                    font.pixelSize: 24
                    font.weight: Font.Bold
                    font.family: "Arial"
                    color: "#2c3e50"
                }

                Item { Layout.fillWidth: true }

                Repeater {
                    model: ["用户", "患者", "医生", "挂号", "病历", "医嘱"]
                    delegate: Button {
                        text: modelData
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        font.family: "Arial"

                        background: Rectangle {
                            color: parent.down ? "#e3f2fd" : (parent.hovered ? "#f5f5f5" : "transparent")
                            border.color: parent.down ? "#1976d2" : "transparent"
                            border.width: parent.down ? 2 : 0
                            radius: 8
                            implicitWidth: 110
                            implicitHeight: 50

                            Behavior on color {
                                ColorAnimation { duration: 150 }
                            }
                        }

                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: parent.down ? "#1976d2" : "#37474f"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            var fileMappings = {
                                "用户": "table1.qml",
                                "患者": "table2.qml",
                                "医生": "table3.qml",
                                "挂号": "table4.qml",
                                "病历": "table5.qml",
                                "医嘱": "table6.qml"
                            };
                            loader.source = fileMappings[modelData];
                        }
                    }
                }
            }
        }

        // Content area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 20
            radius: 10
            color: "#ffffff"
            border.color: "#e0e0e0"
            border.width: 1

            // Simple shadow effect
            Rectangle {
                anchors.fill: parent
                anchors.margins: -2
                radius: 12
                color: "#20000000"
                z: -1
            }

            Loader {
                id: loader
                anchors.fill: parent
                anchors.margins: 20
                source: "table1Page.qml" // Default page
                asynchronous: true

                onSourceChanged: contentChangeAnim.start()
            }

            OpacityAnimator {
                id: contentChangeAnim
                target: loader
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
    }

    // Footer
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 50
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#37474f" }
            GradientStop { position: 1.0; color: "#263238" }
        }

        Text {
            anchors.centerIn: parent
            text: "© 2024 BITMED. All rights reserved."
            color: "#eceff1"
            font.pixelSize: 13
            font.family: "Arial"
        }
    }

    Component.onCompleted: {
        // Set global styles
        Qt.application.font.family = "Arial"
        Qt.application.font.pixelSize = 14
    }
}
