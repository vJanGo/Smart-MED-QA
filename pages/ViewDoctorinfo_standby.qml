import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import FluentUI 1.0
import "../global/func.js" as Func

FluContentPage{

    id:root
    title: qsTr("医生信息")
    signal checkBoxChanged

    property int sortType: 0
    property bool selectedAll: true
    property string nameKeyword: ""
    property string username
    property var departmentList: ["heart", "surgery"]
    property var doctorList: []
    property var doctorusernameList: []

    onNameKeywordChanged: {
        table_view.filter(function(item){
            if(item.name.includes(nameKeyword)){
                return true
            }
            return false
        })
    }
    Component.onCompleted: {
        patients = patient.CheckRegistation()
        console.log("1111             :" + patients.length)
        console.log("2222             :" + patients)
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
                        scheduled_time.push(patientMap["scheduled_time"]),
                        patient_username.push(patientMap["patient_username"]),
                        patient_name.push(patientMap["patient_name"]),
                        patient_gender.push(patientMap["gender"]),
                        patient_age.push(patientMap["age"])
            }   
                }
        console.log(patient_age)
        onepagenum = (patients.length - 1 <10)?patients.length - 1:10
        loadData(1,onepagenum)
    }

    onCheckBoxChanged: {
        for(var i =0;i< table_view.rows ;i++){
            if(false === table_view.getRow(i).checkbox.options.checked){
                root.selectedAll = false
                return
            }
        }
        root.selectedAll = true
    }

    onSortTypeChanged: {
        table_view.closeEditor()
        if(sortType === 0){
            table_view.sort()
        }else if(sortType === 1){
            table_view.sort(
                        (l, r) =>{
                            var lage = Number(l.age)
                            var rage = Number(r.age)
                            if(lage === rage){
                                return l._key>r._key
                            }
                            return lage>rage
                        });
        }else if(sortType === 2){
            table_view.sort(
                        (l, r) => {
                            var lage = Number(l.age)
                            var rage = Number(r.age)
                            if(lage === rage){
                                return l._key>r._key
                            }
                            return lage<rage
                        });
        }
    }

    FluMenu{
        id:pop_filter
        width: 200
        height: 89

        contentItem: Item{

            onVisibleChanged: {
                if(visible){
                    name_filter_text.text = root.nameKeyword
                    name_filter_text.cursorPosition = name_filter_text.text.length
                    name_filter_text.forceActiveFocus()
                }
            }

            FluTextBox{
                id:name_filter_text
                anchors{
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    leftMargin: 10
                    rightMargin: 10
                    topMargin: 10
                }
                iconSource: FluentIcons.Search
            }

            FluButton{
                text: qsTr("搜索")
                anchors{
                    bottom: parent.bottom
                    right: parent.right
                    bottomMargin: 10
                    rightMargin: 10
                }
                onClicked: {
                    root.nameKeyword = name_filter_text.text
                    pop_filter.close()
                }
            }

        }

        function showPopup(){
            table_view.closeEditor()
            pop_filter.popup()
        }

    }

    Component{
        id:com_checbox
        Item{
            FluCheckBox{
                anchors.centerIn: parent
                checked: true === options.checked
                animationEnabled: false
                clickListener: function(){
                    var obj = table_view.getRow(row)
                    obj.checkbox = table_view.customItem(com_checbox,{checked:!options.checked})
                    table_view.setRow(row,obj)
                    checkBoxChanged()
                }
            }
        }
    }

    Component{
        id:com_column_filter_name
        Item{
            FluText{
                text: qsTr("姓名")
                anchors.centerIn: parent
            }
            FluIconButton{
                width: 20
                height: 20
                iconSize: 12
                verticalPadding:0
                horizontalPadding:0
                iconSource: FluentIcons.Filter
                iconColor: {
                    if("" !== root.nameKeyword){
                        return FluTheme.primaryColor
                    }
                    return FluTheme.dark ?  Qt.rgba(1,1,1,1) : Qt.rgba(0,0,0,1)
                }
                anchors{
                    right: parent.right
                    rightMargin: 3
                    verticalCenter: parent.verticalCenter
                }
                onClicked: {
                    pop_filter.showPopup()
                }
            }
        }
    }




    Component{
        id:com_column_checbox
        Item{
            RowLayout{
                anchors.centerIn: parent
                FluText{
                    text: qsTr("Select All")
                    Layout.alignment: Qt.AlignVCenter
                }
                FluCheckBox{
                    checked: true === root.selectedAll
                    animationEnabled: false
                    Layout.alignment: Qt.AlignVCenter
                    clickListener: function(){
                        root.selectedAll = !root.selectedAll
                        var checked = root.selectedAll
                        var columnModel = model.display
                        columnModel.title = table_view.customItem(com_column_checbox,{"checked":checked})
                        model.display = columnModel
                        for(var i =0;i< table_view.rows ;i++){
                            var rowData = table_view.getRow(i)
                            rowData.checkbox = table_view.customItem(com_checbox,{"checked":checked})
                            table_view.setRow(i,rowData)
                        }
                    }
                }
            }
        }
    }


    Component{
        id:com_column_update_title
        Item{
            FluText{
                id:text_title
                text: {
                    if(options.title){
                        return options.title
                    }
                    return ""
                }
                anchors.fill: parent
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                elide: Text.ElideRight
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    custom_update_dialog.showDialog(options.title,function(text){
                        var columnModel = model.display
                        columnModel.title = table_view.customItem(com_column_update_title,{"title":text})
                        model.display = columnModel
                    })
                }
            }
        }
    }

    Component{
        id:com_column_sort_age
        Item{
            FluText{
                text: qsTr("年龄")
                anchors.centerIn: parent
            }
            ColumnLayout{
                spacing: 0
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 4
                }
                FluIconButton{
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 15
                    iconSize: 12
                    verticalPadding:0
                    horizontalPadding:0
                    iconSource: FluentIcons.ChevronUp
                    iconColor: {
                        if(1 === root.sortType){
                            return FluTheme.primaryColor
                        }
                        return FluTheme.dark ?  Qt.rgba(1,1,1,1) : Qt.rgba(0,0,0,1)
                    }
                    onClicked: {
                        if(root.sortType === 1){
                            root.sortType = 0
                            return
                        }
                        root.sortType = 1
                    }
                }
                FluIconButton{
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 15
                    iconSize: 12
                    verticalPadding:0
                    horizontalPadding:0
                    iconSource: FluentIcons.ChevronDown
                    iconColor: {
                        if(2 === root.sortType){
                            return FluTheme.primaryColor
                        }
                        return FluTheme.dark ?  Qt.rgba(1,1,1,1) : Qt.rgba(0,0,0,1)
                    }
                    onClicked: {
                        if(root.sortType === 2){
                            root.sortType = 0
                            return
                        }
                        root.sortType = 2
                    }
                }
            }
        }
    }

    Component {
        id: com_action
        Item {
            RowLayout {
                anchors.centerIn: parent

                FluFilledButton {
                    text: qsTr("查看")
                    // 通过 property 绑定患者姓名
                    property string patientname: "？？？"
                    property string diseases_specializes_in: "!!!"
                    onClicked: {
                        // 创建一个新窗口的组件
                        var newWindowComponent = Qt.createComponent("Case.qml");

                        // 检查组件是否成功创建
                        if (newWindowComponent.status === Component.Ready) {
                            // 使用 createObject 方法在当前上下文中创建新窗口实例
                            var newWindow = newWindowComponent.createObject(null,{"patient":patientname},{"diseases_specializes_in":diseases_specializes_in});

                            // 设置新窗口的位置和大小
                            if (newWindow !== null) {
                                newWindow.width = 900;
                                newWindow.height = 800;
                                newWindow.visible = true; // 显示窗口
                            } else {
                                console.error("新窗口创建失败");
                            }
                        } else {
                            console.error("新窗口组件加载失败:", newWindowComponent.errorString());
                        }
                    }
                }
            }
        }
    }


    FluFrame{
        id:layout_controls
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            topMargin: 20
        }
        height: 60

    FluComboBox {
        id: departmentComboBox
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20
        model: departmentList
        onActivated: {
            console.log("选择的科室: " + departmentComboBox.currentText)
            // 清空列表，防止数据叠加
            doctorList = []
            doctorusernameList = []

            var departmentMap = {
                "department": departmentComboBox.currentText
            }
            var doctorListVec = patient.PatientCheckDoctorInfoByDepartment(Func.encodeMapToString(departmentMap))
            console.log("doctorListVec: " + doctorListVec)

            for (var i = 0; i < doctorListVec.length; i++) {
                var doctorMap = Func.parseStringToMap(doctorListVec[i])
                if (i == 0) {
                    if (doctorMap["status code"] == 0) {
                        showError(qsTr(doctorMap["status"]))
                        return
                    } else {
                        console.log("999: " + doctorMap["status"])
                        showSuccess(qsTr(doctorMap["status"]))
                    }
                } else {
                    // 过滤 undefined 数据
                    if (doctorMap["doctor_name"] !== undefined && doctorMap["doctor_username"] !== undefined) {
                        doctorList.push(doctorMap["doctor_name"])
                        doctorusernameList.push(doctorMap["doctor_username"])
                    }
                }
            }
            console.log("111   :" + doctorList)
            loadData(1, 10) // 初始化加载第一页，10 条数据
        }


        FluText {
            anchors.verticalCenter: departmentComboBox.verticalCenter
            anchors.right: departmentComboBox.left
            anchors.rightMargin: 20
            text: "请选择科室"
        }
    }
}

    FluTableView{
        id:table_view
        anchors{
            left: parent.left
            right: parent.right
            top: layout_controls.bottom
            bottom: gagination.top
        }
        anchors.topMargin: 5
        columnSource:[
            {
                title: table_view.customItem(com_column_filter_name,{title:qsTr("姓名")}),
                dataIndex: 'name',
                width:parent.width/2,
                readOnly:true
            },
            {
                title: qsTr("专长"),
                dataIndex: 'diseases_specializes_in',
                width:parent.width/2,
                readOnly:true
            }
        ]
    }

    FluPagination{
        id:gagination
        anchors{
            bottom: parent.bottom
            //verticalCenter: parent.verticalCenter
            left: parent.left
        }
        pageCurrent: 1
        itemCount:  doctorList.length//TODO确定数量
        pageButtonCount: 7
        __itemPerPage: onepagenum
        previousText: qsTr("<上一页")
        nextText: qsTr("下一页>")
        onRequestPage:
            (page,count)=> {
                table_view.closeEditor()
                loadData(page,count)
                table_view.resetPosition()
            }
    }

    function genTestObject(i){
        //TODO :

        return {
            name: doctorModel.get(i).doctor_name,
            diseases_specializes_in:doctorModel.get(i).diseases_specializes_in,
            _key:FluTools.uuid()
        }
    }

    function loadData(page, count) {
        const dataSource = []
        const startIndex = (page - 1) * count
        const endIndex = Math.min(startIndex + count, doctorList.length) // 防止越界

        for (var i = startIndex; i < endIndex; i++) {
            // 确保从 doctorList 和 doctorusernameList 中获取数据
            if (doctorList[i] !== undefined && doctorusernameList[i] !== undefined) {
                dataSource.push({
                    name: doctorList[i],
                    diseases_specializes_in: doctorusernameList[i],
                    _key: FluTools.uuid()
                })
            }
        }
        table_view.dataSource = dataSource
    }

}
