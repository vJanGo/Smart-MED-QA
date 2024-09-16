import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import FluentUI
import "../global/func.js" as Func

Window {
    id: registerpage
    width: 550
    height: 800
    minimumWidth: 400  // 设置窗口的最小宽度
    minimumHeight: 600  // 设置窗口的最小高度c
    visible: true
    title: "Register"
    color: "#f0f0f0"

    ColumnLayout {
        anchors.centerIn: parent

        Label {
            text: "REGISTER"
            font.pointSize: 40
            font.bold: true
            color: "#00796B"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item {
            Layout.preferredHeight: 20
        }

        Label {
            text: "Let's start with the basics"
            font.pointSize: 15
            font.bold: true
            color: "#b9bfc7"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            Layout.preferredHeight: 20
        }

        // 姓名框
        RowLayout {
            Layout.fillWidth: true
            height: 60
            spacing: 10

            Rectangle {
                Layout.preferredWidth: 200
                height: 50
                radius: 8
                border.color: "#00796B"
                border.width: 2
                color: "white"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    anchors.verticalCenter: parent.verticalCenter

                    FluIcon {
                        Layout.preferredWidth: 30
                        anchors.verticalCenter: parent.verticalCenter
                        iconSource: FluentIcons.Contact
                    }
                    TextField {
                        id: nameField
                        Layout.fillWidth: true
                        placeholderText: "请输入姓名"
                        font.pointSize: 14
                        font.family: "Arial"  // 设置字体
                        color: "#5f5f5f"  // 统一文本颜色
                        placeholderTextColor: "#5f5f5f"  // 统一 placeholder 颜色
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle {
                            color: "transparent"
                        }

                        onTextChanged: {
                            color = text.length > 0 ? "black" : "#000000"; // 当有文本输入时，颜色变为黑色；否则为灰色
                        }
                    }
                }
            }

            ComboBox {
                id: identitySelector
                Layout.preferredWidth: 100
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                model: ["医生", "患者"]
                font.pointSize: 14
                font.family: "Arial"  // 设置字体
                currentIndex: -1
                displayText: currentIndex === -1 ? "身份" : identitySelector.currentText

                background: Rectangle {
                    color: "white"
                    radius: 8
                    border.color: "#00796B"
                    border.width: 2
                }

                contentItem: Text {
                    text: identitySelector.displayText
                    // 动态设置颜色: 未选择时为灰色，选择后为黑色
                    color: identitySelector.currentIndex === -1 ? "#5f5f5f" : "black"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    font.family: "Arial"  // 设置字体
                }
            }

        }

        Item {
            Layout.preferredHeight: 2
        }

        // 账号框
        RowLayout {
            Layout.fillWidth: true
            height: 60

            Rectangle {
                Layout.fillWidth: true
                height: 50
                radius: 8
                border.color: "#00796B"
                border.width: 2
                color: "white"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    anchors.verticalCenter: parent.verticalCenter

                    FluIcon {
                        Layout.preferredWidth: 30
                        anchors.verticalCenter: parent.verticalCenter
                        iconSource: FluentIcons.Contact
                    }
                    TextField {
                        id: usernameField
                        Layout.fillWidth: true
                        placeholderText: "请输入账号"
                        font.pointSize: 14
                        font.family: "Arial"  // 设置字体
                        color: "#5f5f5f"  // 统一文本颜色
                        placeholderTextColor: "#5f5f5f"  // 统一 placeholder 颜色
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle {
                            color: "transparent"
                        }

                        onTextChanged: {
                            color = text.length > 0 ? "black" : "#000000"; // 当有文本输入时，颜色变为黑色；否则为灰色
                        }
                    }
                }
            }
        }

        Item {
            Layout.preferredHeight: 2
        }

        // 密码框
        RowLayout {
            Layout.fillWidth: true
            height: 60

            Rectangle {
                Layout.fillWidth: true
                height: 50
                radius: 8
                border.color: "#00796B"
                border.width: 2
                color: "white"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    anchors.verticalCenter: parent.verticalCenter

                    FluIcon {
                        Layout.preferredWidth: 30
                        anchors.verticalCenter: parent.verticalCenter
                        iconSource: FluentIcons.Lock
                    }

                    TextField {
                        id: passwordField
                        Layout.fillWidth: true
                        placeholderText: "请输入密码"
                        font.pointSize: 14
                        font.family: "Arial"  // 设置字体
                        color: "#5f5f5f"  // 统一文本颜色
                        placeholderTextColor: "#5f5f5f"  // 统一 placeholder 颜色
                        echoMode: TextInput.Password
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle {
                            color: "transparent"
                        }

                        onTextChanged: {
                            color = text.length > 0 ? "black" : "#000000"; // 当有文本输入时，颜色变为黑色；否则为灰色
                        }
                    }

                    Button {
                        id: toggleButton
                        Layout.preferredWidth: 30
                        Layout.alignment: Qt.AlignVCenter
                        background: Rectangle {
                            color: "transparent"
                        }
                        anchors.verticalCenter: parent.verticalCenter
                        contentItem: FluIcon {
                            id: toggleIcon
                            iconSource: FluentIcons.Hide
                        }
                        onClicked: {
                            passwordField.echoMode = passwordField.echoMode === TextInput.Password ? TextInput.Normal : TextInput.Password
                            toggleIcon.iconSource = passwordField.echoMode === TextInput.Password ? FluentIcons.Hide : FluentIcons.RedEye
                        }
                    }
                }
            }
        }

        Item {
            Layout.preferredHeight: 2
        }

        // 确认密码框
        RowLayout {
            Layout.fillWidth: true
            height: 60

            Rectangle {
                Layout.fillWidth: true
                height: 50
                radius: 8
                border.color: "#00796B"
                border.width: 2
                color: "white"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    anchors.verticalCenter: parent.verticalCenter

                    FluIcon {
                        Layout.preferredWidth: 30
                        anchors.verticalCenter: parent.verticalCenter
                        iconSource: FluentIcons.Lock
                    }

                    TextField {
                        id: confirmPasswordField
                        Layout.fillWidth: true
                        placeholderText: "请确认密码"
                        font.pointSize: 14
                        font.family: "Arial"  // 设置字体
                        color: "#5f5f5f"  // 统一文本颜色
                        placeholderTextColor: "#5f5f5f"  // 统一 placeholder 颜色
                        echoMode: TextInput.Password
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle {
                            color: "transparent"
                        }

                        onTextChanged: {
                            color = text.length > 0 ? "black" : "#000000"; // 当有文本输入时，颜色变为黑色；否则为灰色
                        }
                    }

                    Button {
                        id: toggleButton2
                        Layout.preferredWidth: 30
                        Layout.alignment: Qt.AlignVCenter
                        background: Rectangle {
                            color: "transparent"
                        }
                        anchors.verticalCenter: parent.verticalCenter
                        contentItem: FluIcon {
                            id: toggleIcon2
                            iconSource: FluentIcons.Hide
                        }
                        onClicked: {
                            confirmPasswordField.echoMode = confirmPasswordField.echoMode === TextInput.Password ? TextInput.Normal : TextInput.Password
                            toggleIcon2.iconSource = confirmPasswordField.echoMode === TextInput.Password ? FluentIcons.Hide : FluentIcons.RedEye
                        }
                    }
                }
            }
        }

        Item {
            Layout.preferredHeight: 20
        }

        Drawer {
            id: drawer_top
            width: parent.width
            height: parent.height * 0.3
            edge: Qt.TopEdge
            contentItem: Column {
                spacing: 10
                Label {
                    id: topLabel
                    text: "默认文本"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    wrapMode: Text.Wrap
                }
            }
        }

        Item {
            Layout.preferredHeight: 5
        }

        RowLayout {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30
            RowLayout {
                spacing: 40

                Button {
                    implicitWidth: 100
                    implicitHeight: 50
                    background: Rectangle {
                        color: "#00796B"
                        radius: 5
                    }
                    contentItem: Text {
                        text: "提交"
                        color: "white"
                        font.pointSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        if (usernameField.text === "" || passwordField.text === "" || confirmPasswordField.text === "" || nameField.text === "" || identitySelector.currentIndex === -1) {
                            topLabel.text = "输入错误：所有字段均为必填项，请填写完整信息。";
                            drawer_top.open();
                        } else if (passwordField.text !== confirmPasswordField.text) {
                            topLabel.text = "密码错误：两次输入的密码不一致，请重新输入。";
                            drawer_top.open();
                        } else {
                            var credentials = {
                                "username": usernameField.text,
                                "password": passwordField.text,
                                //"identity":identitySelector.currentText == "医生"? "doctor" : "patient"
                            }
                            console.log("333: " + identitySelector.currentText)
                            credentials = Func.encodeMapToString(credentials);
                            var identification = (identitySelector.currentText == "医生")? 1:0;
                            console.log("identificatio: " + identification)
                            var singupResult;
                            if(1 == identification){
                                singupResult = Func.parseStringToMap(doctor.DoctorSignUp(credentials));
                            }else if(0 == identification){
                                singupResult = Func.parseStringToMap(patient.PatientSignUp(credentials));
                            }
                            if (singupResult["status code"] === "0") {
                                showError(qsTr(singupResult["status"]))
                            }
                            else
                            {
                                showSuccess(qsTr(singupResult["status"]))
                                return;
                            }
                        }
                    }
                }

                // 在 QML 中监听 C++ 信号
                Connections {
                    target: registerHandler

                    onRegistrationSuccess: {
                        topLabel.text = "注册成功！";
                        drawer_top.open();
                    }

                    onRegistrationFailed: (errorMessage) => {
                        topLabel.text = errorMessage;
                        drawer_top.open();
                    }
                }
            }

            RowLayout {
                spacing: 10
                Button {
                    implicitWidth: 100
                    implicitHeight: 50
                    contentItem: Text {
                        text: "返回登录"
                        color: "white"
                        font.pointSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    background: Rectangle {
                        color: "#00796B"
                        radius: 5
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        registerpage.visible = false
                        pageLoader.source = "LoginPage.qml"
                    }
                }
            }

        }
    }

    // function getDynamicText(username, password, confirmPassword) {
    //     if (username === "" || password === "") {
    //         return "输入错误：用户名或密码不能为空，请输入完整信息。";
    //     }

    //     if (password !== confirmPassword) {
    //         return "密码错误：两次输入的密码不一致，请重新输入。";
    //     }

    //     return "注册成功！用户名：" + username;
    // }
    }

