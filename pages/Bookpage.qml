import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import FluentUI 1.0
import "../global/func.js" as Func

FluContentPage{

    id:root
    title: qsTr("我的预约")
    signal checkBoxChanged

    property int sortType: 0
    property bool selectedAll: true
    property string nameKeyword: ""
    property string username
    property var status : []
    property var appointment_id: []
    property var scheduled_time: []
    property var patient_username: []
    property var patient_name: []
    property var patient_gender: []
    property var patient_age: []
    property var patients
    property int onepagenum
    onNameKeywordChanged: {
        table_view.filter(function(item){
            if(item.name.includes(nameKeyword)){
                return true
            }
            return false
        })
    }
    Component.onCompleted: {
        patients = doctor.CheckRegistation()
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
            }
            else
            {
                scheduled_time.push(patientMap["scheduled_time"]),
                patient_username.push(patientMap["username"]),
                patient_name.push(patientMap["patient_name"]),
                patient_gender.push(patientMap["gender"]),
                patient_age.push(patientMap["age"])
            }   
                }
        console.log(patient_age)
        console.log(patient_username)
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
                    property string patient_username: options.patient_username // 绑定患者用户名

                    onClicked: {
                        console.log("Clicked patient_username: " + patient_username)

                        // 创建一个新窗口的组件
                        var newWindowComponent = Qt.createComponent("Case.qml");

                        // 检查组件是否成功创建
                        if (newWindowComponent.status === Component.Ready) {
                            // 使用 createObject 方法在当前上下文中创建新窗口实例
                            var newWindow = newWindowComponent.createObject(null, {
                                "patient_username": patient_username
                            });

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

        Row{
            spacing: 5
            anchors{
                right: parent.right
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }

            FluButton{
                text: qsTr("清除记录")
                onClicked: {
                    table_view.dataSource = []
                }
            }

            FluButton{
                text: qsTr("刷新")
                onClicked: {
                    //TODO：更新数据
                    //table_view.dataSource = data
            }
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
                width:parent.width/5,
                readOnly:true
            },
            {
                title: table_view.customItem(com_column_sort_age,{sort:0}),
                dataIndex: 'age',
                width:parent.width/5,
                readOnly:true
            },
            {
                title: qsTr("性别"),
                dataIndex: 'sex',
                width:parent.width/5,
                readOnly:true
            },
            {
                title: qsTr("预约时间"),
                dataIndex: 'btime',
                width:parent.width/5,
                readOnly:true
            },
            {
                title: qsTr("查看病历详情"),
                dataIndex: 'action',
                width:parent.width/5,
                frozen:true
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
        itemCount: patients.length - 1 //TODO确定数量
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

    function genTestObject(i) {
        return {
            name: patient_name[i],
            age: patient_age[i],
            sex: patient_gender[i],
            btime: scheduled_time[i],
            action: table_view.customItem(com_action, { "patient_username": patient_username[i] }),
            _minimumHeight: 50,
            _key: FluTools.uuid()
        }
    }

    function loadData(page,count){
        const dataSource = []
        for(var i=0;i<count;i++){
            dataSource.push(genTestObject(i))
            var aaa = table_view.getRow(i)
            console.log("aaa:  " + aaa)
        }
        table_view.dataSource = dataSource
    }
}

