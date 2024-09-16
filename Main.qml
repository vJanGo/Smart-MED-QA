import QtQuick
import FluentUI
import "button/"
import QtQuick.Controls
import QtQuick.Layouts

FluWindow {

    id: mainwindow
    width: 1200
    height: 800
    visible: true
    title: qsTr("Hello World")

    property bool isLoginViewVisible: false  // 新增的状态标志
    property string chosen_userType: ""  // 用户类型，默认为空

    // 控制页面的可见性
    property bool isHomePageVisible: true  // 控制首页可见性

    // 背景图片，大小随窗口变化
    Image {
        id: background
        source: "source/background.png"
        anchors.fill: parent // 填充整个窗口
        fillMode: Image.PreserveAspectCrop // 保持纵横比裁剪
    }


    // 首页面
    Item {
        anchors.fill: parent
        visible: isHomePageVisible  // 控制首页的可见性

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
                            isHomePageVisible = false  // 隐藏首页
                            doctorButton.visible = true;
                            patientButton.visible = true;
                            rectangle.visible = true;
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
                    width: parent.width * 0.75
                    height: width * 0.4
                    color: "#FFFFFF"
                    radius: 20  // 圆角
                    clip: true  // 确保图片被剪裁

                    Image {
                        anchors.fill: parent
                        anchors.bottom: parent.bottom  // 锚定到父容器的底端
                        anchors.bottomMargin: 20  // 距离底端20个像素的距离
                        source: "source/consultation.jpeg"
                        fillMode: Image.PreserveAspectCrop  // 保持纵横比并裁剪多余部分
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

    // Main page
    Item {
        anchors.fill: parent
        visible: !isHomePageVisible  // 当首页不可见时显示此页面

        // 左侧按钮（医生入口）
        Roundedbutton {
            id: doctorButton
            buttonText: "医生入口"
            buttonImage: "../source/doctor_login.png"
            textColor: "black"
            anchors.left: parent.left // 左边缘
            anchors.bottom: parent.bottom // 底部对齐
            anchors.bottomMargin: 0 // 取消底部间距
            anchors.verticalCenter: undefined // 取消垂直居中
            width: parent.width / 2 // 占据一半的宽度
            height: parent.height   // 覆盖80%的窗口高度
            visible: true
            onClicked: {
                if (isLoginViewVisible) {
                    
                    doctorButton.visible = true;
                    patientButton.visible = true;
                    doctorLoginPage.visible = false;
                    patientLoginPage.visible = false;
                    //rectangle.visible = true;
                    isLoginViewVisible = false; // 重置状态
                } else {
                    console.log("111" + isLoginViewVisible)
                    doctorButton.visible = true;
                    patientButton.visible = false;
                    doctorLoginPage.visible = true;
                    patientLoginPage.visible = false;
                    //rectangle.visible = false;
                    isLoginViewVisible = true; // 更新状态
                    console.log("222" + isLoginViewVisible)
                    chosen_userType = "doctor"  // 用户类型
                }
            }
        }

        // 右侧按钮（患者入口）
        Roundedbutton {
            id: patientButton
            buttonText: "患者入口"
            buttonImage: "../source/patient_login.png"
            textColor: FluTheme.primaryColor.normal
            anchors.right: parent.right // 右边缘
            anchors.bottom: parent.bottom // 底部对齐
            anchors.bottomMargin: 0 // 取消底部间距
            anchors.verticalCenter: undefined // 取消垂直居中
            width: parent.width / 2 // 占据另一半的宽度
            height: parent.height  // 覆盖80%的窗口高度
            visible: true
            onClicked: {
                if (isLoginViewVisible) {
                    doctorButton.visible = true;
                    patientButton.visible = true;
                    doctorLoginPage.visible = false;
                    patientLoginPage.visible = false;
                    //rectangle.visible = true;
                    isLoginViewVisible = false; // 重置状态
                } else {
                    doctorButton.visible = false;
                    patientButton.visible = true;
                    doctorLoginPage.visible = false;
                    patientLoginPage.visible = true;
                    //ectangle.visible = false;
                    isLoginViewVisible = true; // 更新状态
                    chosen_userType = "patient"  // 用户类型
                }
            }
        }


        // 患者登录页面
        LoginPage {
            id: patientLoginPage
            anchors.left: parent.left // 定位在左侧
            anchors.verticalCenter: parent.verticalCenter
            visible: false // 初始隐藏
            width: parent.width / 2 // 占据左半部分
            height: parent.height // 覆盖整个窗口高度
            userType: chosen_userType
            mainWindow: mainwindow  // 传递 mainWindow 引用
        }

        // 医生登录页面
        LoginPage {
            id: doctorLoginPage
            anchors.right: parent.right // 定位在右侧
            anchors.verticalCenter: parent.verticalCenter
            visible: false // 初始隐藏
            width: parent.width / 2 // 占据右半部分
            height: parent.height // 覆盖整个窗口高度
            userType: chosen_userType
            mainWindow: mainwindow  // 传递 mainWindow 引用
        }

        // 修改 Logo 的位置到右上角并添加点击事件
        Rectangle {
            id: logoContainer
            width: 180
            height: 180
            anchors.top: parent.top
            anchors.right: parent.right
            color: "transparent"  // 透明背景

            Image {
                id: logoImage
                source: "source/logo.jpeg"
                anchors.fill: parent  // 使Logo填满容器
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // 点击Logo触发管理员入口逻辑
                    console.log("管理员入口被点击");
                    // 这里你可以添加跳转到管理员页面的逻辑
                    var component = Qt.createComponent("pages/AdministratorLogin.qml");
                    if (component.status === Component.Ready) {
                        var newWindow = component.createObject(parent);
                        if (newWindow !== null) {
                            newWindow.visible = true;
                        } else {
                            console.log("Error creating object");
                        }
                    } else if (component.status === Component.Error) {
                        console.log("Error loading AdministratorLogin.qml: ", component.errorString());
                   }
                }
            }
        }



    }
}
