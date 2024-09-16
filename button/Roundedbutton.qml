// Roundedbutton.qml
import QtQuick
import FluentUI

FluButton {
    id: customButton
    property alias buttonText: buttonLabel.text
    property alias buttonImage: buttonImage.source
    property alias textColor: buttonLabel.color
    property color buttonBackgroundColor: "#FFEAEBEA"
    property color hoveredColor: "#FF6A9BBA"

    font.pointSize: 32
    width: 200
    height: 200
    // x: (parent.width-2*width)/3
    // y: 50


    background: Rectangle {
        id: buttonBackground
        color: customButton.hovered ? hoveredColor : buttonBackgroundColor // 根据 hovered 状态切换颜色
        opacity: 0.5
        border.color: "white" // 白色边框
        border.width: 2
        radius: 30 // 圆角
    }

    Image {
           id: buttonImage
           anchors.centerIn: parent
           width: parent.width * 0.55 // 设置图像宽度为按钮宽度的一半
           height: width // 使图像保持宽高比一致
       }

    FluText {
        id: buttonLabel
        font.pointSize: 30
        font.family: "Segoe UI"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120 // 将文字向上移动
    }
}
