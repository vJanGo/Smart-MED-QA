import QtQuick
import QtQuick.Controls
import FluentUI
import "../button/"
import "../ChatTest/"
import "../global/func.js" as Func

FluPage {
    width: 900
    height: 800

    property var departmentList: ["内科", "外科", "儿科", "妇科", "骨科","heart","surgery"]
    property var doctorList:[] //["医生1", "医生2", "医生3", "医生4", "医生5"]
    property var doctorusernameList:[]
    property var doctorInfoMap
        

    property bool isAppointmentMade: false
    property string appointmentResult: ""

    FluContentDialog {
        id: dialog
        title: qsTr("预约时间")
        message: qsTr("请选择预约的时间")
        contentDelegate: Component {
            Item {
                implicitWidth: parent.width
                implicitHeight: 80
                
                FluTimePicker {
                    id: tp
                    amText: qsTr("上午")
                    pmText: qsTr("下午")
                    hourText: qsTr("时")
                    minuteText: qsTr("分")
                    cancelText: qsTr("取消")
                    okText: qsTr("确认")
                    anchors.centerIn: parent
                }
            }
        }
        negativeText: qsTr("取消")
        onNegativeClicked: {
            showError(qsTr("取消预约"))
        }
        positiveText: qsTr("确认")
        onPositiveClicked: {
            var selectedTime = dialog.contentItem.selectedTime
            appointmentResult = qsTr("预约成功")
            isAppointmentMade = true
            var inde = findindex(doctorList,doctorComboBox.currentText)
            var doctorUN = doctorusernameList[inde]
            var appointmentdoctorinfo = {     // TODO  传入doctor_username
                "doctor_name":doctorComboBox.currentText,
                "doctor_username":doctorUN,
                "department":departmentComboBox.currentText,
                "schedule_time":new Date()
            }
            
            var appointmentInfo = patient.PatientRegistration(Func.encodeMapToString(appointmentdoctorinfo))
            console.log(appointmentInfo)
        }
    }

    Rectangle {
        height: parent.height
        width: parent.width
        color: "transparent"

        //选择科室的下拉菜单
        FluComboBox {
            id: departmentComboBox
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            model: departmentList
            onActivated: {
                console.log("选择的科室: " + departmentComboBox.currentText)
                var departmentMap = {
                    "department":departmentComboBox.currentText
                }
                var doctorListVec = patient.PatientCheckDoctorInfoByDepartment(Func.encodeMapToString(departmentMap))
                console.log("doctorListVec: "+ doctorListVec)
                for (var i = 0; i < doctorListVec.length; i++)
                {
                    var doctorMap = Func.parseStringToMap(doctorListVec[i])
                    if(i == 0)
            {
                if(doctorMap["status code"] == 0)
                {
                    showError(qsTr(doctorMap["status"]))
                    return
                }
                else
                {
                    console.log("999:    " + doctorMap["status"])
                    showSuccess(qsTr(doctorMap["status"]))
                }
            }else{
                doctorList.push(doctorMap["doctor_name"])
                doctorusernameList.push(doctorMap["doctor_username"])
            }
                }
                console.log("111   :" + doctorList)
                doctorComboBox.model = doctorList
            }
        }

        FluText {
            anchors.verticalCenter: departmentComboBox.verticalCenter
            anchors.right: departmentComboBox.left
            anchors.rightMargin: 20
            text: "请选择科室"
        }

        FluText {
            anchors.verticalCenter: doctorComboBox.verticalCenter
            anchors.right: departmentComboBox.left
            anchors.rightMargin: 20
            text: "请选择要挂号的医生"
        }

        //选择医生的下拉菜单
        FluComboBox {
            id: doctorComboBox
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: departmentComboBox.top
            anchors.topMargin: 70
            model: doctorList
            onActivated: {
                console.log(doctorList)
                console.log("选择的医生: " + doctorComboBox.currentText)
                var inde = findindex(doctorList,doctorComboBox.currentText)
                var doctorUN = doctorusernameList[inde]
                var doctorUNMap = {
                    "doctor_username":doctorUN
                }
                console.log("挂号选择的医生username： " + doctorUN);
                doctorInfoMap = Func.parseStringToMap(patient.PatientCheckDoctorInfo(Func.encodeMapToString(doctorUNMap)))
                console.log(doctorInfoMap)
            }
        }

        Image {
            anchors.fill: parent
            id: background
            source: "../source/windowback.png"
            z: -1
        }

        Viewbutton {
            id: appointmentButton
            anchors {
                top: doctorComboBox.bottom
                left: parent.left
                leftMargin: 10
            }
            anchors.topMargin: 50
            width: parent.width - 20
            height: 500

            ChatAvatar {
                id: doctor_avatar
                bgColor: "violet"
                size: 200
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 50
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: doctor_avatar.right
                anchors.leftMargin: 50
                width: parent.width - 100 - 20 - doctor_avatar.width
                height: parent.height - 50
                color: "transparent"

                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 15
                    width: parent.width

                    // 姓名
                    Text {
                        text: "医生姓名： " + doctorInfoMap.doctor_name
                        font.pointSize: 16
                    }

                    // 性别
                    Text {
                        text: "性别： " + doctorInfoMap.gender
                        font.pointSize: 16
                    }

                    // 年龄
                    Text {
                        text: "年龄： " + doctorInfoMap.age
                        font.pointSize: 16
                    }

                    // 所属科室
                    Text {
                        text: "所属科室： " + doctorInfoMap.department
                        font.pointSize: 16
                    }

                    // 出诊时间
                    Text {
                        text: "出诊时间： " + doctorInfoMap.clinic_schedule
                        font.pointSize: 16
                    }

                    // 每日接诊数量
                    Text {
                        text: "每日接诊数量： " + doctorInfoMap.daily_appointments
                        font.pointSize: 16
                    }

                    // 今日剩余号数量
                    // Text {
                    //     text: doctorInfoMap.remaining_slots_today
                    //     font.pointSize: 16
                    // }

                    // 擅长治疗的病症
                    Text {
                        text: "擅长治疗的病症： " + doctorInfoMap.diseases_specializes_in
                        font.pointSize: 16
                    }

                    // 操作栏
                    Row {
                        spacing: 10
                        Viewbutton {
                            width: 200
                            height: 70
                            hoveredColor: "#FFDCFF11"
                            text: isAppointmentMade ? "取消预约" : "我要预约"
                            font.pointSize: 16
                            bordercolor: "black"
                            onClicked: {
                                if (isAppointmentMade) {
                                    showSuccess(qsTr("预约取消成功"))
                                    isAppointmentMade = false
                                    appointmentResult = ""
                                } else {
                                    dialog.open()
                                }
                            }
                        }
                    }
                }
            }
        }

        // 显示预约结果
        Text {
            text: appointmentResult
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            visible: isAppointmentMade
            font.pointSize: 16
            color: "green"
        }
    }
    function findindex(list,string)
    {
        console.log("999: "+list,string)
        for(var i = 0; i < list.length ;i++)
        {
            if(list[i] == string)
            {
                return i
            }
        }
    }
}
