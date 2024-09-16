
import QtQuick
import QtQuick.Controls
import FluentUI
import "../button/"
import "../ChatTest/"

FluPage {
    width: 900
    height: 800

    Component {
        id: rbutton
        Item {
            id: rbutton_item
            width: 500
            height: 200
            property alias text_1: rbutton_text.text
            property alias text_2: descriptionText.text
            Viewbutton {
                width: parent.width
                height: parent.height
                rect_radius: 20
                anchors.fill: parent
                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Text {
                        id: rbutton_text
                        text: qsTr("挂号单")
                        font.pointSize: 15
                        color: "black"
                    }

                    // 添加分隔线
                    Rectangle {
                        width: parent.width
                        height: 2
                        color: "gray"
                    }

                    ScrollView {
                        id: view
                        width: parent.width
                        height: parent.height - rbutton_text.height - 12 - 2 // 计算剩余高度
                        clip: true
                        TextArea {
                            id: descriptionText
                            width: parent.width  // 确保文本宽度与ScrollView一致
                            text: "asjkdehgfjsahgfkjasdhdjashgfjksdafdsfgdsfgfdgfdgdrgdfsgfdgfdgdsfgfdgfd外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文\n外文外\n文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文外文"
                            font.pointSize: 12
                            color: "#666666"
                            wrapMode: Text.WordWrap
                            readOnly: true
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        Column {
            anchors.top: parent.top
            anchors.topMargin: 20
            spacing: 20
            width:parent.width
            Loader {
                id: loader1
                sourceComponent: rbutton
                width: parent.width - 50
                height: 100
                onLoaded: {
                    loader1.item.text_1 = "挂号单号"
                }
            }

            Loader {
                id: loader2
                sourceComponent: rbutton
                width: parent.width - 50
                height: 200
                onLoaded: {
                    loader2.item.text_1 = "医嘱"
                }
            }

            Loader {
                id: loader3
                sourceComponent: rbutton
                width: parent.width - 50
                height: 200
                onLoaded: {
                    loader3.item.text_1 = "处方"
                }
            }



        }
    }
}

