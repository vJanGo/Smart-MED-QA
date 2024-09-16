import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id:termswindow
    visible: true
    width: 400
    height: 500
    color: "white"  // 设置窗口背景颜色
    signal agreementAccepted  // 定义一个信号
    signal agreementRefused

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20

        // 标题部分
        Label {
            text: "欢迎使用医疗管理系统"
            font.pointSize: 20
            font.bold: true
            color: "#00796B"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        // 间隔
        Item {
            Layout.preferredHeight: 10
        }

        // 滚动区域
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            Flickable {
                id: flickable
                contentWidth: parent.width
                contentHeight: textContent.height  // 设定内容高度
                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.StopAtBounds

                // 文本内容
                Text {
                    id: textContent
                    text: "为了帮助您更好地使用本系统，请仔细阅读并理解以下内容：\n\n"
                          + "1. 我们重视您的隐私和数据安全，所有信息将严格按照隐私政策进行保护。"
                          + "在使用本系统过程中，您提供的个人信息将仅用于医疗相关服务的提供，"
                          + "并将在法律允许的范围内进行使用。我们承诺不会将您的信息用于其他商业目的，"
                          + "也不会在未经您同意的情况下将其分享给第三方。\n\n"
                          + "2. 为了提供更好的服务，本系统可能会请求获取您的部分数据，"
                          + "包括但不限于医疗记录、预约信息和健康状况等。这些数据将帮助我们优化服务，"
                          + "为您提供更准确和个性化的医疗建议。您可以在系统设置中管理这些权限，"
                          + "并随时取消授权。\n\n"
                          + "3. 本系统中的所有医疗建议和诊断均基于您提供的信息和数据，"
                          + "请确保这些信息的准确性。如果您对系统提供的建议有任何疑问，"
                          + "请及时联系您的主治医生或医疗服务提供者。\n\n"
                          + "4. 本系统的使用需遵守当地法律法规，"
                          + "任何通过本系统进行的非法活动将由用户本人承担法律责任。我们保留"
                          + "在发现不当使用行为时终止用户访问权限的权利。\n\n"
                          + "5. 如有任何疑问或需要帮助，您可以通过系统内提供的帮助中心联系我们的客服团队，"
                          + "我们将竭诚为您服务。"
                    font.pointSize: 12
                    color: "#666666"
                    wrapMode: Text.WordWrap  // 启用文本自动换行
                    width: parent.width - 20  // 确保文本宽度与父元素一致，减去一些内边距
                }

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AlwaysOn
                }
            }
        }

        // 间隔
        Item {
            Layout.preferredHeight: 20
        }

        // 按钮部分
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 50

            Button {
                text: "取消"
                background: Rectangle {
                    color: "#F0F0F0"
                    radius: 10
                }
                font.pointSize: 16
                width: 100
                height: 40
                onClicked: {
                    agreementRefused();
                    termswindow.visible = false;  // 隐藏登录页面
                }
            }

            Button {
                text: "同意"
                background: Rectangle {
                    color: "#FFD700"
                    radius: 10
                }
                font.pointSize: 16
                width: 100
                height: 40
                onClicked: {
                    agreementAccepted();  // 发射信号
                    termswindow.visible = false;  // 隐藏登录页面
                }
            }
        }
    }
}
