import QtQuick
import QtQuick.Controls
import FluentUI
FluPage {

    width: 800
    height:800

    Rectangle{
        height: parent.height
        width:parent.width
        color: "green"


        Column {
                anchors.fill: parent
                spacing: 10

                // Message Display Area
                ScrollView {
                    id: messageScroll
                    width: parent.width
                    height: parent.height - 100
                    clip: true

                    Column {
                        id: messageArea
                        width: parent.width
                        spacing: 5

                        Repeater {
                            model: 10 // Replace with dynamic message count
                            delegate: Rectangle {
                                width: parent.width
                                height: 50
                                color: model.index % 2 == 0 ? "#f0f0f0" : "#e0e0e0"
                                Text {
                                    anchors.centerIn: parent
                                    text: "Message " + model.index
                                }
                            }
                        }
                    }
                }

                // Input Area
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "#dddddd"
                    Row {
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        TextField {
                            id: messageInput
                            width: parent.width - 100
                            placeholderText: "Type a message..."
                        }

                        Button {
                            text: "Send"
                            onClicked: {
                                // Add message sending logic here
                                console.log("Message sent:", messageInput.text)
                                messageInput.text = ""
                            }
                        }
                    }
                }
            }
    }


}
