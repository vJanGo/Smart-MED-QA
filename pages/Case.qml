import QtQuick
import QtQuick.Controls
import FluentUI
import "../button/"
import "../ChatTest/"
import "../global/func.js" as Func

ApplicationWindow {
    width: 900
    height: 800

    property string patient: ""
    property string appointment_id: ""
    property string patient_username: ""

    property var doctorCheckPatientMedicalRecordMap: {} // 初始化为空对象

    Component.onCompleted: {
        console.log("Initializing with patient username: " + patient_username)
        sendPatientUsernameToServer(patient_username)
    }

    function sendPatientUsernameToServer(username) {
        // 构造键值对
        var params = {"patient_username": username}

        // 通过服务端接口发送数据
        var doctorCheckPatientMedicalRecordResult = doctor.DoctorCheckPatientMedicalRecord(Func.encodeMapToString(params))

        // 解析返回结果
        doctorCheckPatientMedicalRecordMap = Func.parseStringToMap(doctorCheckPatientMedicalRecordResult)
        console.log("DoctorCheckPatientMedicalRecord: " + doctorCheckPatientMedicalRecordResult)

        // 更新 Loaders 的内容
        updateLoaders()
    }

    function updateLoaders() {
        if (!loader3.item) {
            console.error("Loader3 item is not loaded yet")
            return
        }

        console.log("Updating Loaders with data:", doctorCheckPatientMedicalRecordMap)

        if (loader1.item) {
            loader1.item.text_1 = "挂号单号"
            loader1.item.text_2 = doctorCheckPatientMedicalRecordMap["appointment_id"] || "未获取到挂号单号"
        }
        if (loader2.item) {
            loader2.item.text_1 = "诊断信息"
            console.log("Diagnosis:", doctorCheckPatientMedicalRecordMap["diagnosis"])  // 输出症状信息的值
            loader2.item.text_2 = doctorCheckPatientMedicalRecordMap["diagnosis"] || "无诊断信息"
        }
        if (loader3.item) {
            loader3.item.text_1 = "具体症状"
            console.log("Symptoms:", doctorCheckPatientMedicalRecordMap["symptoms"])  // 输出症状信息的值
            loader3.item.text_2 = doctorCheckPatientMedicalRecordMap["symptoms"] || "无症状信息"
        }
        if (loader4.item) {
            loader4.item.text_1 = "既往病史"
            loader4.item.text_2 = doctorCheckPatientMedicalRecordMap["anamnesis"] || "无病史信息"
        }
    }



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
                            text: ""
                            font.pointSize: 12
                            color: "#666666"
                            wrapMode: Text.WordWrap
                            readOnly: true
                            implicitWidth: undefined
                            implicitHeight: undefined
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
            anchors.centerIn: parent
            spacing: 20 // 按钮之间的间距
            width: parent.width

            Loader {
                id: loader1
                sourceComponent: rbutton
                width: parent.width - 50
                height: 100
            }

            Loader {
                id: loader2
                sourceComponent: rbutton
                width: parent.width - 50
                height: 200
            }

            Loader {
                id: loader3
                sourceComponent: rbutton
                width: parent.width - 50
                height: 200
            }

            Loader {
                id: loader4
                sourceComponent: rbutton
                width: parent.width - 50
                height: 200
            }
        }
    }
}
