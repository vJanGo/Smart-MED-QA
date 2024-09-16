import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import "../global/func.js" as Func

ApplicationWindow {
    id: window
    visible: true
    width: 600
    height: 930
    minimumWidth: 500
    minimumHeight: 930
    title: "编辑医生资料"

    property color placeholderColor: "#757575"  // 定义一个较深的浅灰色
    property string username
    property var doctorCheckPersonalInfoMap
    Component.onCompleted: {
        console.log("EditDoctorInfo:" + username)
        var DoctorCheckPersonalInfoResult = doctor.DoctorCheckPersonalInfo()
        doctorCheckPersonalInfoMap = Func.parseStringToMap(DoctorCheckPersonalInfoResult)
        console.log("DoctorCheckPersonalInfo: " + DoctorCheckPersonalInfoResult)

    }



    ScrollView {
        id: mainScrollView
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn



        ColumnLayout {
            id: mainLayout
            width: parent.width
            spacing: 0

            // 顶部固定部分
            Rectangle {
                Layout.fillWidth: true
                height: 220
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#4A90E2" }
                    GradientStop { position: 1.0; color: "#E1E8ED" }
                }

                // Logo Image at the top-left corner
                Image {
                    id: logoImage
                    source: "../source/logo.jpeg"  // 替换为你的logo图片路径
                    width: parent.width*0.35
                    // height: parent.height*0.2
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 0  // 设置左边距
                    anchors.topMargin: -50   // 设置上边距
                    fillMode: Image.PreserveAspectFit
                }

                // 头像部分
                Item {
                    anchors.centerIn: parent
                    width: 160
                    height: 160

                    Rectangle {
                        id: avatarBackground
                        anchors.fill: parent
                        radius: width / 2
                        // color: "white"
                        border.color: "#3A80D2"
                        border.width: 4
                        antialiasing: true

                        Image {
                            id: avatarImage
                            anchors.centerIn: parent
                            width: avatarBackground.width * 0.80
                            height: avatarBackground.height * 0.70
                            source: "../source/doctor_login.png"
                            fillMode: Image.PreserveAspectCrop
                        }

                    }


                }
            }

            // 中间可滚动的内容部分
            Item {
                id: contentContainer
                Layout.fillWidth: true
                Layout.preferredHeight: contentLayout.height + 287

                ColumnLayout {
                    id: contentLayout
                    width: parent.width - 60
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    spacing: 24

                    // 医生姓名
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "医生姓名"
                            font.pointSize: 16
                            font.weight: Font.Medium
                            color: "#333333"
                        }

                        TextField {
                            id: nameField
                            Layout.fillWidth: true
                            Layout.preferredHeight: 56
                            text:doctorCheckPersonalInfoMap.doctor_name
                            //placeholderText: "请输入医生姓名"
                            placeholderTextColor: placeholderColor
                            font.pointSize: 16
                            leftPadding: 16
                            background: Rectangle {
                                color: "white"
                                radius: 8
                                border.color: nameField.activeFocus ? "#4A90E2" : "#E1E8ED"
                                border.width: nameField.activeFocus ? 2 : 1
                            }
                        }
                    }

                    // 性别和年龄
                    RowLayout {
                        spacing: 20
                        Layout.fillWidth: true

                        // 性别
                        ColumnLayout {
                            Layout.preferredWidth: 120
                            spacing: 8

                            Text {
                                text: "性别"
                                font.pointSize: 16
                                font.weight: Font.Medium
                                color: "#333333"
                            }

                            TextField {
                                id: genderField
                                Layout.fillWidth: true
                                Layout.preferredHeight: 56
                                text:doctorCheckPersonalInfoMap.gender
                                placeholderTextColor: placeholderColor
                                font.pointSize: 16
                                leftPadding: 16
                                background: Rectangle {
                                    color: "white"
                                    radius: 8
                                    border.color: nameField.activeFocus ? "#4A90E2" : "#E1E8ED"
                                    border.width: nameField.activeFocus ? 2 : 1
                                }
                            }
                        }
                        // 年龄
                        ColumnLayout {
                            Layout.preferredWidth: 120
                            spacing: 8

                            Text {
                                text: "年龄"
                                font.pointSize: 16
                                font.weight: Font.Medium
                                color: "#333333"
                            }

                            TextField {
                                id: ageField
                                Layout.fillWidth: true
                                Layout.preferredHeight: 56
                                text:doctorCheckPersonalInfoMap.age
                                //placeholderText: "请输入年龄"
                                placeholderTextColor: placeholderColor
                                font.pointSize: 16
                                leftPadding: 16
                                inputMethodHints: Qt.ImhDigitsOnly
                                validator: IntValidator {bottom: 0; top: 150;}
                                background: Rectangle {
                                    color: "white"
                                    radius: 8
                                    border.color: ageField.activeFocus ? "#4A90E2" : "#E1E8ED"
                                    border.width: ageField.activeFocus ? 2 : 1
                                }
                            }
                        }
                    }

                    // 科室
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "科室"
                            font.pointSize: 16
                            font.weight: Font.Medium
                            color: "#333333"
                        }

                        TextField {
                            id: departmentField
                            Layout.fillWidth: true
                            Layout.preferredHeight: 56
                            text:doctorCheckPersonalInfoMap.department
                            //placeholderText: "请输入科室"
                            placeholderTextColor: placeholderColor
                            font.pointSize: 16
                            leftPadding: 16
                            background: Rectangle {
                                color: "white"
                                radius: 8
                                border.color: departmentField.activeFocus ? "#4A90E2" : "#E1E8ED"
                                border.width: departmentField.activeFocus ? 2 : 1
                            }
                        }
                    }

                    // 专长疾病
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "专长疾病"
                            font.pointSize: 16
                            font.weight: Font.Medium
                            color: "#333333"
                        }

                        TextArea {
                            id: specialtiesField
                            Layout.fillWidth: true
                            Layout.preferredHeight: 100
                            text:doctorCheckPersonalInfoMap.diseases_specializes_in
                            //placeholderText: "请输入专长疾病，多个疾病请用逗号分隔"
                            placeholderTextColor: placeholderColor
                            font.pointSize: 16
                            wrapMode: TextEdit.Wrap
                            background: Rectangle {
                                color: "white"
                                radius: 8
                                border.color: specialtiesField.activeFocus ? "#4A90E2" : "#E1E8ED"
                                border.width: specialtiesField.activeFocus ? 2 : 1
                            }
                        }
                    }

                    // 诊所日程
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "诊所日程"
                            font.pointSize: 16
                            font.weight: Font.Medium
                            color: "#333333"
                        }

                        TextArea {
                            id: scheduleField
                            Layout.fillWidth: true
                            Layout.preferredHeight: 100
                            text:doctorCheckPersonalInfoMap.clinic_schedule
                            //placeholderText: "请输入诊所日程，例如：周一上午9:00-12:00，周三下午14:00-17:00"
                            placeholderTextColor: placeholderColor
                            font.pointSize: 16
                            wrapMode: TextEdit.Wrap
                            background: Rectangle {
                                color: "white"
                                radius: 8
                                border.color: scheduleField.activeFocus ? "#4A90E2" : "#E1E8ED"
                                border.width: scheduleField.activeFocus ? 2 : 1
                            }
                        }
                    }

                    // 每日预约数
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "每日预约数"
                            font.pointSize: 16
                            font.weight: Font.Medium
                            color: "#333333"
                        }

                        TextField {
                            id: appointmentsField
                            Layout.fillWidth: true
                            Layout.preferredHeight: 56
                            text:doctorCheckPersonalInfoMap.daily_appointments
                            //placeholderText: "请输入每日最大预约数"
                            placeholderTextColor: placeholderColor
                            font.pointSize: 16
                            leftPadding: 16
                            inputMethodHints: Qt.ImhDigitsOnly
                            validator: IntValidator {bottom: 0; top: 100;}
                            background: Rectangle {
                                color: "white"
                                radius: 8
                                border.color: appointmentsField.activeFocus ? "#4A90E2" : "#E1E8ED"
                                border.width: appointmentsField.activeFocus ? 2 : 1
                            }
                        }
                    }

                    // 底部的按钮
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20
                        Layout.topMargin: 40

                        Button {
                            id: saveButton
                            text: "保存"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 56
                            font.pointSize: 18
                            font.weight: Font.Bold
                            background: Rectangle {
                                color: saveButton.pressed ? "#3A80D2" : "#4A90E2"
                                radius: 8
                            }
                            contentItem: Text {
                                text: saveButton.text
                                font: saveButton.font
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                var userinfo = {
                                    "doctor_name":nameField.text ,
                                    "age": ageField.text,
                                    "gender":  genderField.text,
                                    "department": departmentField.text,
                                    "diseases_specializes_in": specialtiesField.text,
                                    "clinic_schedule": scheduleField.text,
                                    "daily_appointments": appointmentsField.text,
                                    "updated_at": Qt.formatDate(new Date(), "yyyy-MM-dd")
                                }
                                var userinfoString = Func.encodeMapToString(userinfo)
                                var r = doctor.DoctorInfoEdit(userinfoString)
                                console.log(r)

                            }
                        }

                        Button {
                            id: cancelButton
                            text: "取消"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 56
                            font.pointSize: 18
                            font.weight: Font.Bold
                            background: Rectangle {
                                color: cancelButton.pressed ? "#D1D8DD" : "#E1E8ED"
                                radius: 8
                            }
                            contentItem: Text {
                                text: cancelButton.text
                                font: cancelButton.font
                                color: "#4A4A4A"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                }
            }
        }
    }
}
