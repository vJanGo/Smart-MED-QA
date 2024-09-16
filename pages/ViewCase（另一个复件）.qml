import QtQuick
import QtQuick.Controls
import FluentUI

FluPage {
    width: 900
    height: 800



    FluPivot{
        anchors
        {
            left:parent.left
            top:parent.top
        }
        anchors.topMargin: 50
        anchors.leftMargin: 100
        FluPivotItem{
            title: qsTr("挂号单")
            contentItem: Rectangle{
                anchors
                {
                    left:parent.left
                    top:parent.top
                }
                anchors.topMargin: 50
                width:400
                height:200
                color:"green"
            }
        }
        FluPivotItem{
            title: qsTr("诊断信息")
            contentItem: Rectangle{
                anchors
                {
                    left:parent.left
                    top:parent.top
                }
                anchors.topMargin: 50
                width:400
                height:200
                color:"green"
            }
        }
        FluPivotItem{
            title: qsTr("具体症状")
            contentItem: Rectangle{
                anchors
                {
                    left:parent.left
                    top:parent.top
                }
                anchors.topMargin: 50
                width:400
                height:200
                color:"green"
            }
        }
        FluPivotItem{
            title: qsTr("既往病史")
            contentItem:
                Rectangle{
                anchors
                {
                    left:parent.left
                    top:parent.top
                }
                anchors.topMargin: 50
                width:400
                height:200
                color:"green"
            }
        }
    }

}
