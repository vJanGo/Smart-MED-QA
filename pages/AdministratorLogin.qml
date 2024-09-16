import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 400
    height: 600
    title: "管理员登录"
    color: "#f0f0f0"  // 浅灰色背景

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: loginComponent

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
    }

    Component {
        id: loginComponent

        Rectangle {
            id: loginForm
            anchors.fill: parent
            color: "#f0f0f0"

            Rectangle {
                id: loginCard
                anchors.centerIn: parent
                width: 320
                height: 400
                color: "white"
                radius: 10
                border.color: "#e0e0e0"
                border.width: 1

                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 4
                    color: "transparent"
                    border.color: "#f5f5f5"
                    border.width: 2
                    radius: 8
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 30
                    spacing: 20

                    Rectangle {
                        width: 80
                        height: 80
                        color: "#2979FF"
                        radius: 40
                        Layout.alignment: Qt.AlignHCenter

                        Text {
                            anchors.centerIn: parent
                            text: "admin"
                            color: "white"
                            font.pixelSize: 18
                            font.bold: true
                        }
                    }

                    Text {
                        text: "管理员登录"
                        font.pixelSize: 24
                        color: "#333333"
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter
                        font.bold: true
                    }

                    TextField {
                        id: usernameField
                        placeholderText: "用户名"
                        Layout.preferredWidth: 260
                        Layout.preferredHeight: 40
                        font.pixelSize: 14
                        leftPadding: 40
                        background: Rectangle {
                            color: "#f5f5f5"
                            radius: 20
                            Text {
                                text: "👤"  // 使用 Unicode 字符作为用户图标
                                font.pixelSize: 20
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        Layout.alignment: Qt.AlignHCenter
                    }

                    TextField {
                        id: passwordField
                        placeholderText: "密码"
                        echoMode: TextInput.Password
                        Layout.preferredWidth: 260
                        Layout.preferredHeight: 40
                        font.pixelSize: 14
                        leftPadding: 40
                        background: Rectangle {
                            color: "#f5f5f5"
                            radius: 20
                            Text {
                                text: "🔒"  // 使用 Unicode 字符作为锁图标
                                font.pixelSize: 20
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Button {
                        text: "登录"
                        Layout.preferredWidth: 260
                        Layout.preferredHeight: 40
                        font.pixelSize: 16
                        font.bold: true

                        background: Rectangle {
                            color: parent.down ? "#1976D2" : (parent.hovered ? "#2196F3" : "#2979FF")
                            radius: 20
                            Behavior on color {
                                ColorAnimation { duration: 100 }
                            }
                        }

                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            if (usernameField.text === "1" && passwordField.text === "1") {
                                console.log("登录成功");
                                stackView.replace("table.qml", StackView.Immediate);
                            } else {
                                console.log("用户名或密码错误");
                                loginErrorAnimation.start();
                            }
                        }

                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                SequentialAnimation {
                    id: loginErrorAnimation
                    PropertyAnimation {
                        target: loginCard
                        property: "x"
                        from: loginCard.x
                        to: loginCard.x - 10
                        duration: 50
                    }
                    PropertyAnimation {
                        target: loginCard
                        property: "x"
                        from: loginCard.x - 10
                        to: loginCard.x + 10
                        duration: 100
                    }
                    PropertyAnimation {
                        target: loginCard
                        property: "x"
                        from: loginCard.x + 10
                        to: loginCard.x
                        duration: 50
                    }
                }
            }
        }
    }
}
