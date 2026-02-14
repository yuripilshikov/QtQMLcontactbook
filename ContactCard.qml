import QtQuick 2.12

Item {
    id: root
    implicitWidth: 300
    implicitHeight: 120

    property alias color: content.color
    property alias text: cardText.text
    property alias source: contactPhoto.source

    Rectangle {
        id: content
        anchors.fill: parent
        color: "yellow"
        opacity: 0.5

        /*Rectangle {
            id: contactPhoto
            width: 100
            height: width
            radius: width/2
            x: parent.x + 10
            y: parent.y + 10
            color: "orange"
        }*/
        Image {
            id: contactPhoto
            property var id
            source: "image://myimageprovider/asfas"
            width: 100
            height: width
            x: parent.x + 10
            y: parent.y + 10
        }

        Rectangle {
            id: textRect
            x: parent.x + 100 + 10 + 10
            y: parent.y + 10
            height: 100
            width: 170
            color: "blue"
            opacity: 0.5

            Text {
                id: cardText
                anchors.centerIn: parent
                text: "First Name Second Name"
            }
        }        
    }
}
