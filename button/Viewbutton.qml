// Roundedbutton.qml
import QtQuick
import FluentUI
import "../ChatTest"
FluButton {
    id: customButton
    property color buttonBackgroundColor: "#FFEAEBEA"
    property color hoveredColor: "#FF6A9BBA"
    property alias rect_radius: buttonBackground.radius
    property alias bordercolor: buttonBackground.border.color
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


}
