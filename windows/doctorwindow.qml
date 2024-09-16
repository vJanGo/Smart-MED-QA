import QtQuick
import QtQuick.Window
import QtQuick.Controls
import FluentUI.Controls
import FluentUI

FluWindow {
    id:mainWin
    width: 1200
    height: 800
    visible: true
    title: qsTr("Hello World")

    property string username // 你的name变量

    property string welcome: {
        var hour = new Date().getHours();
        if (hour < 12) {
            return "早上好, " + username;
        } else if (hour < 14) {
            return "中午好, " + username;
        } else if (hour < 19){
            return "下午好, " + username;
        } else {
            return "晚上好, " + username;
        }
    }
    Item {
        id:ite
        width: 300
        height: parent.height
        anchors.top: parent.top


        Rectangle {
            id: head_rect
            width: 300
            height:160
            color: "transparent"
            anchors.top: parent.top



            // 头像部分
            Rectangle{
                id: head_photo
                height: 64
                width: height
                y:10
                anchors.left: parent.left
                anchors.margins: 20
                radius: width /2 // 圆形头像
                color:"blue"
                z:1
                FluImage {
                    id: userAvatar
                    //source: "path_to_avatar_image" // 替换为头像图片路径
                    width: parent.width
                    height: parent.height
                    clip: true
                    fillMode: Image.PreserveAspectCrop

                }

                //姓名部分
                Rectangle {
                    width: 150
                    height: 50
                    anchors.verticalCenter: head_photo.verticalCenter
                    anchors.left: head_photo.right
                    anchors.margins: 10
                    color: "transparent"
                    FluText {
                        id: userName
                        text: welcome //调用函数返回显示内容
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap // 处理长名称
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("跳转到个人信息")
                        // 创建一个新窗口的组件
                        var newWindowComponent = Qt.createComponent("../pages/EditDoctorInfo.qml");

                        // 检查组件是否成功创建
                        if (newWindowComponent.status === Component.Ready) {
                            // 使用 createObject 方法在当前上下文中创建新窗口实例
                            var newWindow = newWindowComponent.createObject(null,{"username":username});

                            // 设置新窗口的位置和大小
                            if (newWindow !== null) {

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
            }

            // 搜索框部分
            FluTextBox{

                anchors.top: head_photo.bottom
                anchors.left: parent.left
                anchors.margins: 20


                placeholderText: "输入你想搜索的内容..."
                iconSource: FluentIcons.Search
            }
        }


        FluNavigationView {
            id: navigationPane
            width: parent.width
            anchors.left: parent.left
            anchors.top: head_rect.bottom
            anchors.bottom: parent.bottom
            displayMode: FluNavigationViewType.Stack
            title: "协和智慧医疗"
            cellHeight:50
            // 添加用户信息显示框
            items: FluObject{
                FluPaneItem {
                    key:"/"
                    title: "首页"
                    icon: FluentIcons.Home
                    onTap: {
                        loader_content.sourceComponent = Qt.createComponent("../pages/HomePage.qml")
                        console.log("跳转到首页")
                    }
                }
                FluPaneItemSeparator {}
                FluPaneItemHeader{
                    title: "应用"
                }
                FluPaneItem {
                    title: "我的预约"
                    icon: FluentIcons.Headset
                    onTap: {
                        //loader_content.sourceComponent = Qt.createComponent("../pages/Bookpage.qml")
                        loader_content.setSource(Qt.resolvedUrl("../pages/Bookpage.qml"), {"username": username})
                        console.log("跳转到我的预约")
                    }
                }
                FluPaneItemSeparator{}
                FluPaneItem {
                    title: "诊断"
                    icon: FluentIcons.Diagnostic
                    onTap: {
                        loader_content.sourceComponent = Qt.createComponent("../pages/Diagnose.qml")
                        console.log("跳转到诊断")
                    }
                }
                FluPaneItemSeparator{}
                FluPaneItem {
                    title: "医疗大数据"
                    icon: FluentIcons.Comment
                    onTap: {
                        loader_content.sourceComponent = Qt.createComponent("../pages/Datagenerate.qml")
                        console.log("跳转到医疗大数据")
                    }
                }
                FluPaneItemSeparator{}
                FluPaneItem {
                    title: "与患者聊聊"
                    icon: FluentIcons.FeedbackApp
                    onTap: {
                        loader_content.sourceComponent = Qt.createComponent("../pages/ChatViewDoctor.qml")
                        console.log("跳转到与患者聊聊")
                    }
                }
                FluPaneItemSeparator{}
            }
            // 脚部菜单项保持不变
            footerItems: FluObject{
                FluPaneItem {
                    title: "返回主页面"
                    icon: FluentIcons.Cancel
                    onTap: {
                    // 返回主页面的逻辑
                    var mainComponent = Qt.createComponent("../Main.qml");
                    if (mainComponent.status === Component.Ready) {
                        var mainWindow = mainComponent.createObject(null);
                        if (mainWindow !== null) {
                            mainWindow.visible = true; // 显示Main.qml窗口
                            mainWin.close(); // 关闭当前窗口
                        } else {
                            console.error("Main.qml窗口创建失败");
                        }
                    } else {
                        console.error("Main.qml组件加载失败:", mainComponent.errorString());
                    }
                }
                }
                FluPaneItemSeparator{}
                FluPaneItem {
                    title: "关于"
                    icon: FluentIcons.Contact
                    onTap: {
                        console.log("点击了")
                    }
                }
            }

        }
    }

    Loader {
        id: loader_content
        anchors {
            left: ite.right
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
        sourceComponent: Qt.createComponent("../pages/HomePage.qml")
    }
    // 定位矩阵
    // Rectangle{
    //     width:100
    //     height:100
    //     anchors.left: head_rect.right
    //     color: "purple"
    // }

}