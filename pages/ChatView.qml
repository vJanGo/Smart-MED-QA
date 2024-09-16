import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import FluentUI
import "../ChatTest/"
import "../global/func.js" as Func


FluPage {
    width: 800
    height:800

    // 创建文件内的全局变量
    property int totMid : 0;   // 目前消息总数


    Rectangle{
        width: parent
        height:parent
        anchors.fill: parent
        color:"transparent"


        Component {
            id: message_text

            Item {
                id: message_text_item
                width: message_view.width - 10 //避开滚动条
                height: {
                    return Math.max(message_text_avatar.height, message_text_rectangle.height + message_text_name.height) + message_text_time.height + 10
                }
                clip: true

                ChatAvatar {
                    id: message_text_avatar
                    bgColor: modelData.color
                    avatar: modelData.avatar
                    online: modelData.online
                    size: 35
                    anchors {
                        top: parent.top
                        left: modelData.isSender ? undefined : parent.left
                        right: modelData.isSender ? parent.right : undefined
                    }
                    Component.onCompleted:{
                        console.log("Avatar: "+bgColor)
                    }
                }

                FluText {
                    id: message_text_name
                    text: modelData.name//model.user.remark ? model.user.remark : model.user.name
                    maximumLineCount: 1
                    horizontalAlignment: modelData.isSender ? Text.AlignRight : Text.AlignLeft
                    elide: Text.ElideRight
                    color: FluTheme.dark ? FluColors.Grey100 : FluColors.Grey100
                    font.pixelSize: 12
                    anchors {
                        top: parent.top
                        left: modelData.isSender ? message_text_item.left : message_text_avatar.right
                        leftMargin: 10
                        right: modelData.isSender ? message_text_avatar.left : message_text_item.right
                        rightMargin: 10
                    }
                }

                Rectangle {
                    id: message_text_rectangle
                    width: {
                        let max_width = message_text_item.width * 0.75
                        let need_width = message_text_metrics.width + 20
                        return need_width > max_width ? max_width : need_width
                    }
                    height: message_text_content.contentHeight + 20
                    anchors {
                        top: message_text_name.bottom
                        topMargin: 5
                        left: modelData.isSender ? undefined : message_text_avatar.right
                        leftMargin: 10
                        right: modelData.isSender ? message_text_avatar.left : undefined
                        rightMargin: 10
                    }
                    radius: 10
                    color: "white" /*{
                        if (isSender)
                            return FluTheme.dark ? FluTheme.primaryColor.lighter : FluTheme.primaryColor.dark
                        return FluTheme.dark ? Window.active ? Qt.rgba(38 / 255, 44 / 255, 54 / 255, 1) : Qt.rgba(39 / 255, 39 / 255, 39 / 255, 1) : Qt.rgba(251 / 255, 251 / 255, 253 / 255, 1)
                    }*/

                    FluCopyableText {
                        id: message_text_content
                        text: modelData.content
                        wrapMode: Text.Wrap
                        color: "black"//FluTheme.dark ^ isSender ? FluColors.White : FluColors.Black
                        font.pixelSize: 14
                        anchors {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                            margins: 10
                        }
                    }

                    FluCopyableText {
                        id: message_text_metrics
                        text: message_text_content.text
                        font: message_text_content.font
                        visible: false
                    }
                }

                FluText {
                    id: message_text_time
                    text: Qt.formatDateTime(new Date(modelData.time * 1000), "yyyy-MM-dd hh:mm:ss") + " · #" + modelData.mid
                    color: FluTheme.dark ? FluColors.Grey120 : FluColors.Grey80
                    font.pixelSize: 10
                    anchors {
                        top: message_text_rectangle.bottom
                        topMargin: 5
                        left: modelData.isSender ? undefined : message_text_rectangle.left
                        right: modelData.isSender ? message_text_rectangle.right : undefined
                    }
                }
            }
        }

        Rectangle {
            id: header
            width: parent.width
            height: 45
            z: 1
            radius: 10
            color: FluTheme.dark ? Window.active ? Qt.rgba(38 / 255, 44 / 255, 54 / 255, 1) : Qt.rgba(39 / 255, 39 / 255, 39 / 255, 1) : Qt.rgba(251 / 255, 251 / 255, 253 / 255, 1)
            anchors {
                top: parent.top
                topMargin: 5
                left: parent.left
                leftMargin: 10
                right: parent.right
                rightMargin: 10
            }

            FluText {
                id: header_title
                text: "啊啊啊啊"
                color: FluTheme.dark ? FluColors.White : FluColors.Black
                font.pixelSize: 20
                elide: Text.ElideRight
                anchors {
                    left: parent.left
                    leftMargin: 20
                    right: header_button_group.left
                    verticalCenter: parent.verticalCenter
                }
            }

            Row {
                id: header_button_group
                spacing: 5
                anchors {
                    right: parent.right
                    rightMargin: 20
                    verticalCenter: parent.verticalCenter
                }

                FluIconButton {
                    id: header_edit_button
                    text: "修改备注"
                    iconSource: FluentIcons.Edit
                    iconColor: FluTheme.dark ? FluTheme.primaryColor.lighter : FluTheme.primaryColor.dark
                    onClicked: {
                        //
                    }
                }

                FluIconButton {
                    id: header_info_button
                    text: "关于聊天"
                    iconSource: FluentIcons.Info
                    iconColor: FluTheme.dark ? FluTheme.primaryColor.lighter : FluTheme.primaryColor.dark
                    onClicked: {
                        info_popup.visible = true
                    }
                }

            }


            Popup {
                id: info_popup
                modal: true
                visible: false
                width: 200
                height: 200
                x: parent.width - width
                y: parent.height + 10
                clip: true

                enter: Transition {
                    NumberAnimation {
                        property: "height"
                        from: 0
                        to: 200
                        duration: 233
                        easing.type: Easing.InOutExpo
                    }

                    NumberAnimation {
                        property:"opacity"
                        from:0
                        to: 1
                        duration: 233
                    }
                }
                exit: Transition {
                    NumberAnimation {
                        property: "height"
                        from: 200
                        to: 0
                        duration: 233
                        easing.type: Easing.InOutExpo
                    }

                    NumberAnimation {
                        property:"opacity"
                        from:1
                        to: 0
                        duration: 233
                    }
                }

                background: FluArea {
                    radius: 10
                    border.width: 0
                }


                ListView {
                    id: info_list
                    width: parent.width
                    height: parent.height
                    spacing: 10
                    orientation: ListView.Vertical
                    ScrollBar.vertical: FluScrollBar {
                    }
                    boundsBehavior: Flickable.DragOverBounds
                    //model: store.currentGroupUsers

                    header: Item {
                        visible: true//store.currentGroup && store.currentGroup.type !== "twin"
                        height: info_text.height + 20//store.currentGroup && store.currentGroup.type !== "twin" ? info_text.height + 20 : 0
                        width: info_list.width
                        FluText {
                            id: info_text
                            text: "群号：#" + 114514 + "\n群主：" + "gogo" + "\n人数：" + 5 + "\n群名：" +  "aaaaa"
                            color: FluTheme.dark ? FluColors.Grey100 : FluColors.Grey100
                            wrapMode: Text.WrapAnywhere
                            anchors {
                                left: parent.left
                                right: parent.right
                                top: parent.top
                                margins: 10
                            }
                        }
                    }

                    delegate: Item {
                        width: info_list.width
                        height: 50
                        Rectangle {
                            id: info_item
                            property bool hoverd: false
                            width: parent.width
                            height: parent.height
                            radius: 10
                            color: hoverd ? (FluTheme.dark ? "#11FFFFFF" : "#11000000") : "transparent"

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    info_item.hoverd = true
                                }
                                onExited: {
                                    info_item.hoverd = false
                                }
                            }

                            FluTooltip {
                                visible: info_item.hoverd
                                text: modelData.username
                                delay: 1000
                            }

                            ChatAvatar {
                                id: info_avatar
                                bgColor: modelData.color
                                avatar: modelData.avatar
                                online: modelData.online
                                size: 30
                                anchors {
                                    left: parent.left
                                    leftMargin: 5
                                    verticalCenter: parent.verticalCenter
                                }
                            }

                            FluText {
                                text: modelData.remark ? modelData.remark : modelData.name
                                color: FluTheme.dark ? FluColors.White : FluColors.Black
                                font.pixelSize: 14
                                elide: Text.ElideRight
                                anchors {
                                    left: info_avatar.right
                                    leftMargin: 5
                                    right: parent.right
                                    rightMargin: 5
                                    top: info_avatar.top
                                }
                            }

                            FluText {
                                text: modelData.username
                                color: FluTheme.dark ? FluColors.Grey100 : FluColors.Grey100
                                ListView {

                                    width: parent.width
                                    height: parent.height
                                    delegate: message_text
                                }        font.pixelSize: 10
                                elide: Text.ElideRight
                                anchors {
                                    left: info_avatar.right
                                    leftMargin: 5
                                    right: parent.right
                                    rightMargin: 5
                                    bottom: info_avatar.bottom
                                }
                            }
                        }
                    }
                }
            }

        }

        Item {
                id: message_view_mask //防止最上面和最下面的空白显示消息
                clip: true
                anchors {
                    top: header.bottom
                    topMargin: -10
                    left: parent.left
                    leftMargin: 20
                    right: parent.right
                    rightMargin: 10 //这里不是20是因为有个滚动条
                    bottom: input_area.top
                    bottomMargin: -10
                }
                ListView {
                    id: message_view
                    spacing: 20
                    orientation: ListView.Vertical
                    ScrollBar.vertical: FluScrollBar {
                    }
                    boundsBehavior: Flickable.DragOverBounds
                    anchors {
                        fill: parent
                        topMargin: 10
                        bottomMargin: 10
                    }

                    model: ListModel {

                        // ListElement {
                        //     name: "User1"
                        //     remark: "Alice"
                        //     avatar: "user1.png"
                        //     color: "#3498db"
                        //     online: true
                        //     content: "Hello, how are you?"
                        //     time: 1692858000  // Unix时间戳
                        //     mid: 1  // 消息ID
                        //     isSender: true
                        //     type:"text"
                        // }
                        // ListElement {
                        //     name: "User2"
                        //     remark: "Bob"
                        //     avatar: "user2.png"
                        //     color: "#e74c3c"
                        //     online: true
                        //     content: "I'm good, thanks!"
                        //     time: 1692858060  // Unix时间戳
                        //     mid: 2  // 消息ID
                        //     isSender: false
                        //     type:"text"
                        // }
                    }

                    header: Rectangle {
                        width: message_view.width
                        height: 60
                        color: "transparent"
                        FluTextButton {
                            text: "加载更多"//store.messageList.hasMore ? "加载更多" : "没有更多了QwQ"
                            anchors.centerIn: parent
                            onClicked: {
                                message_view.loading = true
                                //store.control.loadMessages()
                            }
                            disabled: false//message_view.loading || !store.messageList.hasMore
                        }
                    }

                    footer: Rectangle {
                        width: message_view.width
                        height: 20
                        visible: true
                        color:"transparent"
                    }



                    delegate: Loader {
                        id: message_loader
                        property var modelData: model
                        property var aaa: name
                        Component.onCompleted: {
                                                    console.log(12)
                                                    console.log(aaa)
                                                    console.log(modelData)
                            console.log(modelData.type)
                                                }
                        //property bool isSender: modelData.user === store.currentUser

                        sourceComponent:  {
                            if (modelData.type === "text") {
                                return message_text
                            }
                            if (modelData.type === "image") {
                                return message_image
                            }
                            if (modelData.type === "file") {
                                return message_file
                            }
                            if (modelData.type === "p2p_file") {
                                return message_p2p_file
                            }
}

                    }



                    // property bool loading: true
                    // property var lastGroupWhenBottom: null
                    // property var oldFirst: 0
                    // onModelChanged: {
                    //     if (lastGroupWhenBottom !== store.currentGroup && message_view.contentHeight > message_view.height) {
                    //         lastGroupWhenBottom = store.currentGroup
                    //         message_view.positionViewAtEnd()
                    //         if (message_view.model.length) {
                    //             oldFirst = message_view.model[0].id
                    //         }
                    //         loading = false
                    //     } else {
                    //         if (message_view.model.length && oldFirst !== message_view.model[0].id) {
                    //             loading = false
                    //             var idx = 0
                    //             for (var i = 0; i < message_view.model.length; i++) {
                    //                 if (message_view.model[i].id === oldFirst) {
                    //                     idx = i
                    //                     break
                    //                 }
                    //             }
                    //             message_view.positionViewAtIndex(Math.max(0, idx - 1), ListView.Beginning)
                    //             oldFirst = message_view.model[0].id
                    //         } else {
                    //             message_view.positionViewAtEnd()
                    //         }
                    //     }
                    // }
                }
            }


        FluArea {
                id: input_area
                height: editExpand ? parent.height * 0.5 : 150
                paddings: 15
                radius: 10
                border.width: 0
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    leftMargin: 20
                    rightMargin: 20
                    bottomMargin: 10
                }

                property bool editExpand: false
                Behavior on height {
                    enabled: FluTheme.enableAnimation
                    NumberAnimation {
                        duration: 666
                        easing.type: Easing.InOutExpo
                    }
                }

                RowLayout {
                    id: button_group
                    width: parent.width

                    Row {
                        spacing: 5
                        FluIconButton {
                            text: input_area.editExpand ? "还原输入框" : "扩展输入框"
                            iconSource: input_area.editExpand ? FluentIcons.ChevronDown : FluentIcons.ChevronUp
                            iconColor: FluTheme.dark ? FluTheme.primaryColor.lighter : FluTheme.primaryColor.dark
                            onClicked: {
                                input_area.editExpand = !input_area.editExpand
                            }
                        }

                        // 上传图片
                        FluIconButton {
                            text: "发送图片"
                            iconSource: FluentIcons.Photo
                            iconColor: FluTheme.dark ? FluTheme.primaryColor.lighter : FluTheme.primaryColor.dark
                            onClicked: {
                                //TODO
                            }
                        }

                        FluIconButton {
                            text: "发送文件"
                            iconSource: FluentIcons.Attach
                            iconColor: FluTheme.dark ? FluTheme.primaryColor.lighter : FluTheme.primaryColor.dark
                            onClicked: {
                                //TODO
                            }
                        }

                        // FluIconButton {
                        //     text: "P2P文件同传"
                        //     iconSource: FluentIcons.Network
                        //     iconColor: FluTheme.dark ? FluTheme.primaryColor.lighter : FluTheme.primaryColor.dark
                        //     onClicked: {
                        //         p2p_file_upload_dialog.open()
                        //     }
                        // }

                        FluIconButton {
                            text: "截屏"
                            iconSource: FluentIcons.Cut
                            iconColor: FluTheme.dark ? FluTheme.primaryColor.lighter : FluTheme.primaryColor.dark
                            onClicked: {
                                //screenshot.open()
                            }
                        }
                    }

                    Row {
                        spacing: 5
                        Layout.alignment: Qt.AlignRight
                        FluIconButton {
                            iconSource: FluentIcons.Send
                            iconColor: FluTheme.dark ? FluTheme.primaryColor.lighter : FluTheme.primaryColor.dark
                            onClicked: {
                                // input_area.sendMessage()
                                if (text_box.text === "") return;
                                console.log("发送按钮点击");

                                var send_at = Date.now();
                                var content = text_box.text;

                                // 创建字典对象
                                var m = {
                                    send_at: send_at,
                                    content: content,
                                };
                                // 清空文本框
                                text_box.text = "";
                                // 发送消息
                                console.log("patient开始发送信息");
                                patient.PatientSendMessage(Func.encodeMapToString(m));   // 会添加信息到自己的 dataArray
                            }
                        }
                    }


                }

                Item {
                    id: text_box_container
                    anchors {
                        top: button_group.bottom
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                        topMargin: 10
                    }

                    Flickable {
                        clip: true
                        anchors.fill: parent
                        contentWidth: parent.width
                        contentHeight: text_box.height
                        ScrollBar.vertical: FluScrollBar {
                        }
                        boundsBehavior: Flickable.StopAtBounds

                        FluMultilineTextBox {
                            id: text_box
                            placeholderText: "Tips：使用Ctrl+Enter换行OvO"
                            width: parent.width
                            height: contentHeight + 20 < text_box_container.height ? text_box_container.height : contentHeight + 20
                            padding: 0
                            background: Rectangle {
                                color: "transparent"
                            }
                            onCommit: {  // TODO 发送消息
                                // input_area.sendMessage()
                                if (text_box.text === "") return;
                                console.log("发送提交信息");

                                var send_at = Date.now();
                                var content = text_box.text;

                                // 创建字典对象
                                var m = {
                                    send_at: send_at,
                                    content: content
                                };
                                // 清空文本框
                                text_box.text = "";
                                // 发送消息
                                patient.PatientSendMessage(Func.encodeMapToString(m));
                            }

                        }
                    }
                }

                function sendMessage() {/*
                    if (text_box.text === "") return
                    store.control.sendMessage(store.currentGroup.id, "text", text_box.text)
                    text_box.text = ""
                    message_view.positionViewAtEnd()*/
                    //TODO:这部分涉及到聊天框的向下滑动，源码被我在上面注释掉了，等数据结构确定后统一修改
                }
            }

    }

    // 监听对话消息 dataArray
    Connections {
        target: patient
        onDataArrayChanged: {
            console.log("Array has changed! New data: " + patient.dataArray);

            // 遍历 patient.dataArray
            for (var i = totMid; i < patient.dataArray.length; i++) {
                // 调用 decoder 函数，将字符串转换为字典
                var decodedDict = Func.parseStringToMap(patient.dataArray[i]);

                // 确保字典包含 "content" 字段
                if (decodedDict.hasOwnProperty("content")) {
                    // 仅更新 content 字段，保留其他字段不变
                    message_view.model.append({
                        name: (decodedDict["sender_type"] === "doctor")? decodedDict["doctor_username"]: decodedDict["patient_username"],   //  username
                        remark: "Alice",    // 备注
                        avatar: "user1.png",
                        color: "#3498db" ,
                        online: true ,
                        content: decodedDict["content"] ,
                        time: decodedDict["send_at"]  , // Unix时间戳
                        mid: i+1 , // 消息ID
                        isSender: (decodedDict["sender_type"] === "patient"),
                        type: "text",
                    });
                }
            }
            totMid = patient.dataArray.length;
        }
    }




    // 窗口刚打开时的逻辑   ->  Component代指当前窗体
    Component.onCompleted: {
         totMid = 0;
         message_view.model.clear();   // 清除原有聊天
         for(var i=0; i<patient.dataArray.length; i++){
             // 调用 decoder 函数，将字符串转换为字典
             var decodedDict = Func.parseStringToMap(patient.dataArray[i]);

             // 确保字典包含 "content" 字段
             if (decodedDict.hasOwnProperty("content")) {
                 // 仅更新 content 字段，保留其他字段不变
                 message_view.model.append({
                     name: (decodedDict["sender_type"] === "doctor")? decodedDict["doctor_username"]: decodedDict["patient_username"],   //  username
                     remark: "Alice",    // 备注
                     avatar: "user1.png",
                     color: "#3498db" ,
                     online: true ,
                     content: decodedDict["content"] ,
                     time: decodedDict["send_at"]  , // Unix时间戳
                     mid: i+1 , // 消息ID
                     isSender: (decodedDict["sender_type"] === "patient"),
                     type: "text",
                 });
             }
    }
         totMid = patient.dataArray.length;
    }
}
