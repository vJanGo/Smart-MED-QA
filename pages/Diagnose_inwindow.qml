import QtQuick
import QtQuick.Controls
import FluentUI
import "../button/"
import "../ChatTest/"
import "../global/func.js" as Func

ApplicationWindow {
    width: 900
    height: 800
    visible: true

    // 定义变量来存储表单输入内容
    property string patient_username: ""
    property string appointment_id: ""
    property string diagnosisInfo: ""
    property string medicalAdvice: ""
    property string prescription: ""

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
            width:parent.width
            Loader {
                id: loader1
                sourceComponent: rbutton
                width: parent.width - 50
                height: 100
                onLoaded: {
                    loader1.item.text_1 = "挂号单号"
                    loader1.item.text_2 = appointment_id
                }
            }

            Loader {
                id: loader2
                sourceComponent: rbutton
                width: parent.width - 50
                height: 175
                onLoaded: {
                    loader2.item.text_1 = "诊断信息"
                }
            }

            Loader {
                id: loader3
                sourceComponent: rbutton
                width: parent.width - 50
                height: 200
                onLoaded: {
                    loader3.item.text_1 = "医嘱"
                }
            }

            Loader {
                id: loader4
                sourceComponent: rbutton
                width: parent.width - 50
                height: 175
                onLoaded: {
                    loader4.item.text_1 = "处方"
                }
            }
        }
    }

        FluFilledButton {
            text: qsTr("确认提交")
            width: 200
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                // 从每个 Loader 中获取输入值
                // appointment_id = loader1.item.text_2
                diagnosisInfo = loader2.item.text_2
                medicalAdvice = loader3.item.text_2
                prescription = loader4.item.text_2

                console.log("挂号单号: " + appointment_id)
                console.log("诊断信息: " + diagnosisInfo)
                console.log("医嘱: " + medicalAdvice)
                console.log("处方: " + prescription)

                // 打包数据
                var params = {
                    "patient_username": patient_username,
                    "appointment_id": appointment_id,
                    "diagnosis": diagnosisInfo,
                    "doctor_notes": medicalAdvice,
                    "prescription": prescription
                }

                // 调用 DoctorMakeMedicalRecord 方法
                var result = doctor.DoctorMakeMedicalRecord(Func.encodeMapToString(params))
                var resultMap = Func.parseStringToMap(result)

                // 检查结果
                if (resultMap["status code"] == "1") {
                    showSuccess(qsTr("提交成功"))
                    close() // 关闭窗口
                } else {
                    showError(qsTr("提交失败: " + resultMap["status"]))
                }
            }
        }
    
}
