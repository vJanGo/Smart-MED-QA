import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import "../global/func.js" as Func
ApplicationWindow {
    id: window
    visible: true
    width: 600
    height: 830
    minimumWidth: 500
    minimumHeight: 830
    title: "编辑患者资料"

    property int departmentCount: 1
    property color placeholderColor: "#757575"
    property color primaryColor: "#FFE082"  // 更淡的主黄色
    property color primaryLightColor: "#FFF8E1"  // 非常淡的黄色
    property color primaryDarkColor: "#FFD54F"  // 稍深的黄色
    property color textColor: "#5D4037"  // 深棕色文本，与黄色搭配

    property string username
    property var patientCheckPersonalInfoMap
    Component.onCompleted: {
        console.log("EditPatientInfo:" + username)
        var PatientCheckPersonalInfoResult = patient.PatientCheckPersonalInfo()
        patientCheckPersonalInfoMap = Func.parseStringToMap(PatientCheckPersonalInfoResult)
        console.log("PatientCheckPersonalInfo: " + PatientCheckPersonalInfoResult)

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
                    GradientStop { position: 0.0; color: primaryColor }
                    GradientStop { position: 1.0; color: primaryLightColor }
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
                        color: "white"
                        border.color: primaryColor
                        border.width: 4
                        antialiasing: true

                        Image {
                            id: avatarImage
                            // anchors.fill: parent
                            source: "../source/patient_login.png"
                            width: 146
                            height: 150
                            fillMode: Image.PreserveAspectCrop
                            visible: true
                        }
                    }
                }



            }

            // 中间可滚动的内容部分
            Item {
                id: gun
                Layout.fillWidth: true
                Layout.preferredHeight: contentLayout.height + 287

                ColumnLayout {
                    id: contentLayout
                    width: parent.width - 60
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    spacing: 24

                    // 患者信息行
                    ColumnLayout {
                        spacing: 20
                        Layout.alignment: Qt.AlignLeft

                        // 患者姓名
                        ColumnLayout {
                            Layout.preferredWidth: 160
                            spacing: 8

                            Text {
                                text: "患者姓名"
                                font.pointSize: 16
                                font.weight: Font.Medium
                                color: textColor
                            }

                            TextField {
                                id: nameField
                                Layout.fillWidth: true
                                Layout.preferredHeight: 56
                                text:patientCheckPersonalInfoMap.patient_name
                                //placeholderText: "请输入姓名"
                                placeholderTextColor: placeholderColor
                                font.pointSize: 16
                                leftPadding: 16
                                color: textColor
                                background: Rectangle {
                                    color: "white"
                                    radius: 8
                                    border.color: nameField.activeFocus ? primaryDarkColor : "#E1E8ED"
                                    border.width: nameField.activeFocus ? 2 : 1
                                }
                            }
                        }


                        // 性别和年龄
                        RowLayout {
                            spacing: 20
                            Layout.fillWidth: true

                                // // 性别选择
                                // ColumnLayout {
                                //     Layout.preferredWidth: 120
                                //     spacing: 8

                                //     Text {
                                //         text: "性别"
                                //         font.pointSize: 16
                                //         font.weight: Font.Medium
                                //         color: textColor
                                //     }

                                //     ComboBox {
                                //         id: genderSelector
                                //         Layout.fillWidth: true
                                //         Layout.preferredHeight: 56
                                //         model: ["男", "女"]
                                //         currentIndex: -1
                                //         font.pointSize: 16

                                //         background: Rectangle {
                                //             color: "white"
                                //             radius: 8
                                //             border.color: genderSelector.pressed ? primaryDarkColor : "#E1E8ED"
                                //             border.width: genderSelector.pressed ? 2 : 1
                                //         }

                                //         contentItem: Text {
                                //             leftPadding: 16
                                //             text: genderSelector.currentIndex === -1 ? "请选择" : genderSelector.displayText
                                //             font: genderSelector.font
                                //             color: genderSelector.currentIndex === -1 ? placeholderColor : textColor
                                //             verticalAlignment: Text.AlignVCenter
                                //         }

                                //         delegate: ItemDelegate {
                                //             width: genderSelector.width
                                //             contentItem: Text {
                                //                 text: modelData
                                //                 color: textColor
                                //                 font: genderSelector.font
                                //                 elide: Text.ElideRight
                                //                 verticalAlignment: Text.AlignVCenter
                                //             }
                                //             highlighted: genderSelector.highlightedIndex === index
                                //         }

                                //         popup: Popup {
                                //             y: genderSelector.height - 1
                                //             width: genderSelector.width
                                //             implicitHeight: contentItem.implicitHeight
                                //             padding: 1

                                //             contentItem: ListView {
                                //                 clip: true
                                //                 implicitHeight: contentHeight
                                //                 model: genderSelector.popup.visible ? genderSelector.delegateModel : null
                                //                 currentIndex: genderSelector.highlightedIndex
                                //             }

                                //             background: Rectangle {
                                //                 border.color: "#E1E8ED"
                                //                 radius: 8
                                //             }
                                //         }
                                //     }
                                // }
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
                                    text:patientCheckPersonalInfoMap.gender
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
                                        text: "患者年龄"
                                        font.pointSize: 16
                                        font.weight: Font.Medium
                                        color: textColor
                                    }

                                    TextField {
                                        id: ageField
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 56
                                        text:patientCheckPersonalInfoMap.age
                                        //placeholderText: "请输入年龄"
                                        placeholderTextColor: placeholderColor
                                        font.pointSize: 16
                                        leftPadding: 16
                                        color: textColor
                                        background: Rectangle {
                                            color: "white"
                                            radius: 8
                                            border.color: ageField.activeFocus ? primaryDarkColor : "#E1E8ED"
                                            border.width: ageField.activeFocus ? 2 : 1
                                        }
                                    }
                                }
                            }
                    }

                    // 联系电话
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        Text {
                            text: "联系电话"
                            font.pointSize: 16
                            font.weight: Font.Medium
                            color: textColor
                        }

                        TextField {
                            id: phoneField
                            Layout.fillWidth: true
                            Layout.preferredHeight: 56
                            text:patientCheckPersonalInfoMap.contact_number
                            //placeholderText: "请输入联系电话"
                            placeholderTextColor: placeholderColor
                            font.pointSize: 16
                            leftPadding: 16
                            color: textColor
                            background: Rectangle {
                                color: "white"
                                radius: 8
                                border.color: phoneField.activeFocus ? primaryDarkColor : "#E1E8ED"
                                border.width: phoneField.activeFocus ? 2 : 1
                            }
                        }
                    }

                    // 动态增加的科室部分
                    // Repeater {
                    //     model: departmentCount
                    //     delegate: ColumnLayout {
                    //         Layout.fillWidth: true
                    //         spacing: 8

                    //         Text {
                    //             text: "科室" + (index + 1)
                    //             font.pointSize: 16
                    //             font.weight: Font.Medium
                    //             color: textColor
                    //         }

                    //         TextField {
                    //             id: departmentField
                    //             Layout.fillWidth: true
                    //             Layout.preferredHeight: 56
                    //             placeholderText: "请输入科室"
                    //             placeholderTextColor: placeholderColor
                    //             font.pointSize: 16
                    //             leftPadding: 16
                    //             color: textColor
                    //             background: Rectangle {
                    //                 color: "white"
                    //                 radius: 8
                    //                 border.color: departmentField.activeFocus ? primaryDarkColor : "#E1E8ED"
                    //                 border.width: departmentField.activeFocus ? 2 : 1
                    //             }
                    //         }
                    //     }
                    // }

                    // // 添加/删除科室按钮
                    // RowLayout {
                    //     spacing: 16
                    //     Layout.fillWidth: true
                    //     Layout.topMargin: 24

                    //     Button {
                    //         text: "添加科室"
                    //         font.pointSize: 16
                    //         Layout.preferredHeight: 48
                    //         Layout.preferredWidth: 120
                    //         visible: departmentCount < 3
                    //         onClicked: {
                    //            departmentCount++
                    //            gun.Layout.preferredHeight += 56
                    //            contentLayout.forceLayout()
                    //        }
                    //         background: Rectangle {
                    //             color: parent.pressed ? primaryDarkColor : primaryColor
                    //             radius: 8
                    //         }
                    //         contentItem: Text {
                    //             text: parent.text
                    //             font: parent.font
                    //             color: textColor
                    //             horizontalAlignment: Text.AlignHCenter
                    //             verticalAlignment: Text.AlignVCenter
                    //         }
                    //     }

                    //     Button {
                    //         text: "删除科室"
                    //         font.pointSize: 16
                    //         Layout.preferredHeight: 48
                    //         Layout.preferredWidth: 120
                    //         visible: departmentCount > 1
                    //         onClicked: {
                    //             if (departmentCount > 1) {
                    //                 departmentCount--
                    //                 gun.Layout.preferredHeight -= 56
                    //                 contentLayout.forceLayout()
                    //             }
                    //         }
                    //         background: Rectangle {
                    //             color: parent.pressed ? "#D1D8DD" : "#E1E8ED"
                    //             radius: 8
                    //         }
                    //         contentItem: Text {
                    //             text: parent.text
                    //             font: parent.font
                    //             color: textColor
                    //             horizontalAlignment: Text.AlignHCenter
                    //             verticalAlignment: Text.AlignVCenter
                    //         }
                    //     }
                    // }
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
                            text:patientCheckPersonalInfoMap.department
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
                                color: saveButton.pressed ? primaryDarkColor : primaryColor
                                radius: 8
                            }
                            contentItem: Text {
                                text: saveButton.text
                                font: saveButton.font
                                color: textColor
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                var userinfo = {
                                    "patient_name":nameField.text ,
                                    "age": ageField.text,
                                    "gender":  genderField.text,
                                    "contact_number": phoneField .text,
                                    "department": departmentField.text,
                                    "updated_at": Qt.formatDate(new Date(), "yyyy-MM-dd")
                                }
                                var userinfoString = Func.encodeMapToString(userinfo)
                                var r = patient.PatientInfoEdit(userinfoString)
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
                                color: textColor
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
