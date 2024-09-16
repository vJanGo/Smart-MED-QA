import QtQuick
import QtQuick.Controls
import FluentUI
FluPage {

    width: 800
    height:800

    Rectangle{
        height: parent.height
        width:parent.width
        color: "transparent"
        FluCarousel{
        id:carousel
        width: parent.width
        height: parent.height
        delegate: Component{
            Image {
                anchors.fill: parent
                source: model.url
                asynchronous: true
                fillMode:Image.PreserveAspectFit
            }   
        }
        Component.onCompleted: {
            carousel.model = [{url:"../source/cover4.jpeg"},{url:"../source/cover1.jpg"},{url:"../source/cover2.jpg"}]
        }
        }
    }

    
}
