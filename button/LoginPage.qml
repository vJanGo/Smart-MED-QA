import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import FluentUI
import "../global/func.js" as Func


Rectangle {
    id: loginPage
    width: 400
    height: 800
    color: "#f0f0f0"
    radius: 10

    
    property var userType : "?"
    
    property var mainWindow  // 直接引用 Main.qml 的 FluWindow


    Loader {
            id: pageLoader
            anchors.fill: parent

        }

    ColumnLayout {
        anchors.verticalCenterOffset: -50  // 将整个布局往上移动
        anchors.centerIn: parent


        // 登录标题
        Label {
            text: "LOGIN"
            font.pointSize: 60  // 增大字体大小
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            color: "#00796B"
        }

        Item {
            Layout.preferredHeight: 20  // 自定义间距高度
        }

        Label {
            text: "Nice to meet you"
            font.pointSize: 15
            font.bold: true
            color: "#b9bfc7"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            Layout.preferredHeight: 40  // 自定义间距高度
        }

        // 用户名框
        RowLayout {
            Layout.fillWidth: true  // 确保RowLayout填充可用空间
            height: 60

            Rectangle {
                Layout.fillWidth: true  // 使Rectangle填充RowLayout的可用宽度
                height: 50  // 增加文本框的高度
                radius: 8  // 增加圆角半径
                border.color: "#00796B"
                border.width: 2  // 增加边框宽度
                color: "white"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10  // 给整个RowLayout增加10像素的内边距
                    anchors.verticalCenter: parent.verticalCenter  // 垂直居中

                    FluIcon {
                        Layout.preferredWidth: 30  // 设置FluIcon的宽度
                        anchors.verticalCenter: parent.verticalCenter  // 垂直居中对齐
                        iconSource: FluentIcons.Contact
                    }

                    TextField {
                        id:usernameField
                        Layout.fillWidth: true  // 使TextField填充RowLayout的剩余空间
                        placeholderText: "请输入用户名"
                        font.pointSize: 18  // 增加字体大小
                        anchors.verticalCenter: parent.verticalCenter  // 确保TextField在垂直方向上居中
                        background: Rectangle {
                            color: "transparent"
                        }
                    }
                }
            }
        }

        Item {
            Layout.preferredHeight: 3  // 自定义间距高度
        }

        // 密码框
        RowLayout {
            Layout.fillWidth: true  // 确保RowLayout填充可用空间
            height: 60

            Rectangle {
                Layout.fillWidth: true  // 使Rectangle填充RowLayout的可用宽度
                height: 50  // 增加文本框的高度
                radius: 8  // 增加圆角半径
                border.color: "#00796B"
                border.width: 2  // 增加边框宽度
                color: "white"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10  // 给整个RowLayout增加10像素的内边距
                    anchors.verticalCenter: parent.verticalCenter  // 垂直居中

                    FluIcon {
                        Layout.preferredWidth: 30  // 设置FluIcon的宽度
                        anchors.verticalCenter: parent.verticalCenter  // 垂直居中对齐
                        iconSource: FluentIcons.Lock
                    }

                    TextField {
                        id: passwordField
                        Layout.fillWidth: true  // 使TextField填充RowLayout的剩余空间
                        placeholderText: "请输入密码"
                        font.pointSize: 18  // 增加字体大小
                        echoMode: TextInput.Password  // 初始状态为密码隐藏
                        anchors.verticalCenter: parent.verticalCenter  // 确保TextField在垂直方向上居中
                        background: Rectangle {
                            color: "transparent"
                        }
                    }

                    Button {
                        id: toggleButton
                        Layout.preferredWidth: 30  // 固定按钮宽度
                        Layout.alignment: Qt.AlignVCenter  // 确保按钮在垂直方向上居中
                        background: Rectangle {
                            color: "transparent"  // 按钮背景透明
                        }
                        anchors.verticalCenter: parent.verticalCenter
                        contentItem: FluIcon {
                            id: toggleIcon
                            iconSource: FluentIcons.Hide  // 初始图标为 "Hide"

                        }
                        onClicked: {
                            // 切换密码显示模式
                            passwordField.echoMode = passwordField.echoMode === TextInput.Password ? TextInput.Normal : TextInput.Password
                            // 切换图标
                            toggleIcon.iconSource = passwordField.echoMode === TextInput.Password ? FluentIcons.Hide : FluentIcons.RedEye
                        }
                    }
                }
            }
        }


        // 复选框：同意条款
        Row {
            anchors.left: parent.left
            spacing: 5

            CheckBox {
                id: agreementCheckBox
                // 保持复选框默认样式
            }

            Label {
                textFormat: Text.RichText  // 启用RichText支持
                text: "我同意<a href='terms'>服务协议和隐私政策</a>"
                font.pointSize: 12

                // 用于存储已经创建的 TermsWindow 实例
                property var termsWindowInstance: null

                onLinkActivated: function(link) {
                    if (link === "terms") {
                        // 打开服务协议和隐私政策窗口
                        console.log("服务协议和隐私政策被点击");

                        if (termsWindowInstance !== null && termsWindowInstance.visible) {
                            // 如果窗口已经存在且可见，将其置于顶层
                            termsWindowInstance.raise();
                            termsWindowInstance.requestActivate();
                        } else {
                            // 如果窗口不存在或已关闭，创建一个新的窗口
                            var component = Qt.createComponent("TermsWindow.qml");
                            if (component.status === Component.Ready) {
                                termsWindowInstance = component.createObject(parent);
                                if (termsWindowInstance !== null) {
                                    termsWindowInstance.visible = true;
                                    termsWindowInstance.raise();
                                    termsWindowInstance.requestActivate();

                                    // 直接连接信号到复选框的checked属性
                                    termsWindowInstance.agreementAccepted.connect(function() {
                                        agreementCheckBox.checked = true;
                                    });
                                    // 连接拒绝信号到取消复选框的checked属性
                                    termsWindowInstance.agreementRefused.connect(function() {
                                        agreementCheckBox.checked = false;
                                    });
                                }
                            } else {
                                console.log("Error loading TermsWindow.qml: ", component.errorString());
                            }
                        }
                    }
                }
            }
        }


        Item {
            Layout.preferredHeight: 30  // 自定义间距高度
        }

        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter  // 水平居中对齐父元素
            spacing: 40  // 按钮之间的间距

            // 登录按钮
            Button {

                property string intype: "?"
                text: "登录"
                Layout.preferredWidth: 150  // 设置按钮的首选宽度为150像素
                Layout.preferredHeight: 60  // 设置按钮的首选高度为60像素
                font.pointSize: 16
                background: Rectangle {
                    color: "#00796B"
                    radius: 5
                }
                contentItem: Text {
                    text: "登录"
                    color: "white"
                    font.pointSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Layout.alignment: Qt.AlignVCenter  // 垂直居中
                hoverEnabled: true





                onClicked: {
                    // 检查用户是否同意服务协议和隐私政策
                    if (!agreementCheckBox.checked) {
                        showError(qsTr("请先同意服务协议和隐私政策"));
                        return;
                    }

                    // 调用 C++ 中的 login 方法
                    var credentials = {
                        "username": usernameField.text,
                        "password": passwordField.text
                    }
                    var loginResult
                    credentials = Func.encodeMapToString(credentials)
                    console.log("usertpye:  " + userType)
                    if (userType == "doctor")
                    {
                        loginResult = Func.parseStringToMap(doctor.DoctorSignIn(credentials))
                    }
                    else
                    {
                        loginResult = Func.parseStringToMap(patient.PatientSignIn(credentials))
                    }

                    console.log(loginResult)
                    console.log(loginResult["status code"], loginResult["status"]);
                    console.log("点击" + userType);

                    if (loginResult["status code"] !== "1") {
                        showError(qsTr(loginResult["status"]));
                        return;
                    }
                    //showSuccess(qsTr("登录成功"))
                    // 根据用户类型加载不同的窗口
                    var windowFile = (userType === "doctor") ? "../windows/doctorwindow.qml" : "../windows/patientwindow.qml";
                    var newWindowComponent = Qt.createComponent(windowFile);

                    // 检查组件是否成功创建
                    if (newWindowComponent.status === Component.Ready) {
                        var newWindow = newWindowComponent.createObject(null,{"username": usernameField.text});

                        if (newWindow !== null) {
                            newWindow.width = 1200;
                            newWindow.height = 800;
                            newWindow.visible = true; // 显示窗口

                            mainWindow.close();  // 关闭 Main.qml 窗口
                        } else {
                            console.error("新窗口创建失败");
                        }
                    } else {
                        console.error("新窗口组件加载失败:", newWindowComponent.errorString());
                    }
                }

            }



            Button {
                text: "注册"
                Layout.preferredWidth: 150  // 设置按钮的首选宽度为150像素
                Layout.preferredHeight: 60  // 设置按钮的首选高度为60像素
                font.pointSize: 16
                background: Rectangle {
                    color: "#00796B"
                    radius: 5
                }
                contentItem: Text {
                    text: "注册"
                    color: "white"
                    font.pointSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Layout.alignment: Qt.AlignVCenter  // 垂直居中
                hoverEnabled: true

                // 用于存储已经创建的 RegisterPage 实例
                property var registerWindowInstance: null
                property var termsWindowInstance: null

                onClicked: {
                    if (agreementCheckBox.checked) {
                        // 复选框已勾选，跳转到注册页面
                        if (registerWindowInstance !== null && registerWindowInstance.visible) {
                            registerWindowInstance.raise();
                            registerWindowInstance.requestActivate();
                        } else {
                            var component = Qt.createComponent("RegisterPage.qml");
                            if (component.status === Component.Ready) {
                                registerWindowInstance = component.createObject(parent);
                                if (registerWindowInstance !== null) {
                                    registerWindowInstance.visible = true;
                                    registerWindowInstance.raise();
                                    registerWindowInstance.requestActivate();
                                }
                            } else {
                                console.log("Error loading RegisterPage.qml: ", component.errorString());
                            }
                        }
                    } else {
                        // 复选框未勾选，跳转到服务协议页面
                        if (termsWindowInstance !== null && termsWindowInstance.visible) {
                            termsWindowInstance.raise();
                            termsWindowInstance.requestActivate();
                        } else {
                            var component = Qt.createComponent("TermsWindow.qml");
                            if (component.status === Component.Ready) {
                                termsWindowInstance = component.createObject(parent);
                                if (termsWindowInstance !== null) {
                                    // 连接信号
                                    termsWindowInstance.agreementAccepted.connect(function() {
                                        agreementCheckBox.checked = true;
                                    });
                                    termsWindowInstance.agreementRefused.connect(function() {
                                        agreementCheckBox.checked = false;
                                    });

                                    termsWindowInstance.visible = true;
                                    termsWindowInstance.raise();
                                    termsWindowInstance.requestActivate();
                                }
                            } else {
                                console.log("Error loading TermsWindow.qml: ", component.errorString());
                            }
                        }
                    }
                }
            }




            }
        }
}
