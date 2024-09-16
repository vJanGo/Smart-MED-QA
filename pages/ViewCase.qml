import QtQuick
import QtQuick.Controls
import FluentUI
import "../button/"
import "../ChatTest/"
import "../global/func.js" as Func
FluPage {
    width: 900
    height: 800
    
    property var patientMedicalRecordMap: null  // 初始化为null，表示数据尚未准备好
    
    Component.onCompleted: {
        var patientMedicalRecordResult = patient.PatientMedicalRecord()
        patientMedicalRecordMap = Func.parseStringToMap(patientMedicalRecordResult)
        console.log("PatientMedicalRecorddiagnosis: " + patientMedicalRecordMap["diagnosis"])
        loadComponents()  // 确保数据准备好后再加载Loader
    }

    function loadComponents() {
        // 加载所有的Loader
        loader1.active = true
        loader2.active = true
        loader3.active = true
        loader4.active = true
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

                    Rectangle {
                        width: parent.width
                        height: 2
                        color: "gray"
                    }

                    ScrollView {
                        id: view
                        width: parent.width
                        height: parent.height - rbutton_text.height - 12 - 2
                        clip: true
                        TextArea {
                            id: descriptionText
                            width: parent.width
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
            anchors.centerIn: parent
            spacing: 20
            width: parent.width

            Loader {
                id: loader1
                active: false  // 默认不激活
                sourceComponent: rbutton
                width: parent.width - 50
                height: 100
                onLoaded: {
                    if (patientMedicalRecordMap) {
                        loader1.item.text_1 = "挂号单号"
                        loader1.item.text_2 = patientMedicalRecordMap.appointment_id
                    }
                }
            }

            Loader {
                id: loader2
                active: false
                sourceComponent: rbutton
                width: parent.width - 50
                height: 200
                onLoaded: {
                    if (patientMedicalRecordMap) {
                        loader2.item.text_1 = "诊断信息"
                        loader2.item.text_2 = patientMedicalRecordMap.diagnosis
                    }
                }
            }

            Loader {
                id: loader3
                active: false
                sourceComponent: rbutton
                width: parent.width - 50
                height: 200
                onLoaded: {
                    if (patientMedicalRecordMap) {
                        loader3.item.text_1 = "具体症状"
                        loader3.item.text_2 = patientMedicalRecordMap.symptoms
                    }
                }
            }

            Loader {
                id: loader4
                active: false
                sourceComponent: rbutton
                width: parent.width - 50
                height: 200
                onLoaded: {
                    if (patientMedicalRecordMap) {
                        loader4.item.text_1 = "既往病史"
                        loader4.item.text_2 = patientMedicalRecordMap.anamnesis
                    }
                }
            }
        }
    }
}
