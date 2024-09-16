import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import FluentUI
import "../ChatTest/"
import "../button/"
import "../global/func.js" as Func




FluPage {
    width: 800
    height:800

    property var patients
    property var username :[]   // 此文件中的 username 实际含义为 patient_username
    property var patient_name :[]

    Rectangle{
        width: 800
        height:parent
        anchors{
            top:parent.top
            right:parent.right
            bottom: parent.bottom
        }

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

                    }

                    header: Rectangle {
                        width: message_view.width
                        height: 60
                        color: "transparent"//"transparent"
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
                            onClicked: {  // TODO 发送按钮点击逻辑
                                // input_area.sendMessage()
                                if (text_box.text === "") return;
                                console.log("doctor发送按钮点击");
                                var send_at = Date.now();
                                var content = text_box.text;

                                // 创建字典对象
                                var m = {
                                    patient_username: doctor.curPatientUsername,
                                    send_at: send_at,
                                    content: content,
                                };
                                // 清空文本框
                                text_box.text = "";
                                // 发送消息
                                console.log("doctor开始发送消息");
                                doctor.DoctorSendMessage(Func.encodeMapToString(m));  // 会添加消息到 dataArray上
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
                            onCommit: {   // TODO 聊天框提交逻辑
                                // input_area.sendMessage()
                                if (text_box.text === "") return;
                                console.log("doctor提交逻辑发生");

                                var send_at = Date.now();
                                var context = text_box.text;

                                // 创建字典对象
                                var m = {
                                    patient_username: doctor.curPatientUsername,
                                    send_at: send_at,
                                    context: context,
                                };

                                // 发送消息
                                doctor.DoctorSendMessage(Func.encodeMapToString(m));

                                // 清空文本框
                                text_box.text = "";
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
    Rectangle {
        width: 100
        height: parent.height
        color: "transparent"
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
        }

        ListModel {
        
        id: patientnameModel
        
        }


        ListView {
            width: parent.width
            height: parent.height
            clip: true // 防止超出边界显示

            model: patientnameModel

            delegate: Item {
                width: parent.width
                height: 150

                Roundedbutton {
                    width: parent.width
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    //margin: 5



                        Rectangle{
                            id:avart
                            width: 60
                            height: 60
                            radius: 30
                            color: "white"
                            anchors {
                                top: parent.top
                                topMargin: 10
                                left:parent.left
                                leftMargin: 20

                            }
                            Image {
                                width: parent
                                height: parent
                                //source: avatar // 绑定到ListModel中的avatar
                                fillMode: Image.PreserveAspectFit

                            }
                        }



                        Text {

                            text: username // 绑定到ListModel中的name
                            anchors {
                                top: avart.bottom
                                topMargin: 20
                                left:parent.left
                                leftMargin: 20
                                verticalCenter: parent.verticalCenter
                            }

                            font.pixelSize: 16
                        }

                        onClicked:{    //  TODO 患者列表的按钮点击  ->  跳转到对应患者的聊天 并且执行相应操作
                            header_title.text = username;    //  此处的username即为 patient_username
                            doctor.curPatientUsername = username;    // 将医生客户端当前聊天的病人设置为当前病人
                            message_view.model.clear();    // 清空聊天窗体
                            doctor.totMidMap[doctor.curPatientUsername] = 0;
                            for(var i = 0; i<doctor.dataArray.length; i++){
                                var decodedDict = Func.parseStringToMap(doctor.dataArray[i]);
                                if(doctor.curPatientUsername == decodedDict["patient_username"] && decodedDict.hasOwnProperty("sender_type") &&
                                decodedDict.hasOwnProperty("content")){   // 使用 Username进行匹配
                                    message_view.model.append({
                                        name: (decodedDict["sender_type"] === "doctor")? decodedDict["doctor_username"]: decodedDict["patient_username"],   //  username
                                        remark: "Alice",    // 备注
                                        avatar: "user1.png",
                                        color: "#3498db" ,
                                        online: true ,
                                        content: decodedDict["content"] ,
                                        time: parseInt(decodedDict["send_at"])  , // Unix时间戳
                                        mid: ++doctor.totMidMap[doctor.curPatientUsername] , // 消息ID
                                        isSender: (decodedDict["sender_type"] === "patient"),
                                        type: "text",
                                    })
                                }
                            }

                        }
                }
            }

            ScrollBar.vertical: ScrollBar { } // 显示垂直滚动条
        }
    }

    

    Component.onCompleted: {
        // TODO 实现左侧的好友框
        patients = doctor.CheckRegistation()
        
        for (var i = 0; i < patients.length; i++) {
            var patientMap = Func.parseStringToMap(patients[i])
            if(i == 0)
            {
                if(patientMap["status code"] == 0)
                {
                    showError(qsTr(patientMap["status"]))
                    return
                }
                else
                {
                    showSuccess(qsTr(patientMap["status"]))
                }
            }else{
                        // username.push(patientMap["username"]),
                        // patient_name.push(patientMap["patient_name"]),
                        patientnameModel.append({
                        "username": patientMap["username"],
                        "patient_name": patientMap["patient_name"]
                })
            }   
        }
        
    }

    // TODO 监听对话消息 dataArray ， 有改变就打印上去
    Connections {
        target: doctor
        onDataArrayChanged: {
            console.log("Array has changed! Now data: " + doctor.dataArray);
                // 调用 decoder 函数，将字符串转换为字典
                if(doctor.dataArray.length === 0) {
                    console.log("dataArray 为空");
                    return;
                }
                var decodedDict = Func.parseStringToMap(doctor.dataArray[doctor.dataArray.length - 1]);

                // 确保字典包含 "content" 字段
                if (doctor.curPatientUsername === decodedDict["patient_username"] && decodedDict.hasOwnProperty("content")) {
                    console.log("聊天框开始添加信息");

                    // 检查并初始化
                    if (!doctor.totMidMap.hasOwnProperty(doctor.curPatientUsername)) {
                        var TempMap = doctor.totMidMap;
                        TempMap[doctor.curPatientUsername] = 0;
                        doctor.totMidMap = TempMap; // 触发更新
                    }

                    // 聊天框插入消息
                    message_view.model.append({
                        name: (decodedDict["sender_type"] === "doctor")? decodedDict["doctor_username"]: decodedDict["patient_username"],   //  username
                        remark: "Alice",    // 备注
                        avatar: "user1.png",
                        color: "#3498db" ,
                        online: true ,
                        content: decodedDict["content"] ,
                        time: parseInt(decodedDict["send_at"])  , // Unix时间戳
                        mid: ++doctor.totMidMap[decodedDict["patient_username"]] , // 消息ID
                        isSender: (decodedDict["sender_type"] === "patient"),
                        type: "text",
                    });

                    console.log("聊天框添加信息完毕");
                }
        }
    }
}
