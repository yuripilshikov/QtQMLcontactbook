import QtQuick 2.12

Item {
    id: root
    implicitWidth: 300
    implicitHeight: 132

    property alias color: content.color
    property alias secondaryColor: textRect.color
    property alias text: cardText.text
    property alias source: contactPhoto.source

    Rectangle {
        id: content
        anchors.fill: parent
        color: "yellow"

        BorderImage {
            id: myBorderImage1
            anchors { fill: content }
            border.left: 16; border.top: 16
            border.right: 16; border.bottom: 16
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "image://myimageprovider/testBorderImage_2"
        }

        Image {
            id: contactPhoto
            property var id
            source: "image://myimageprovider/asfas"
            width: 100
            height: width
            x: parent.x + 16
            y: parent.y + 16
        }

        Rectangle {
            id: textRect
            x: parent.x + 100 + 10 + 10
            y: parent.y + 16
            height: 100
            width: (parent.width - x - 16)
            color: "blue"
            border.color: "#4b3a0a"
            border.width: 2

            Text {
                id: cardText
                anchors.centerIn: parent
                text: "First Name Second Name"
            }
        }

        SequentialAnimation {
            id: someAnim
            PropertyAnimation {
                target: content
                property: "width"
                to: 0
                duration: 1000
            }
            PropertyAnimation {
                target: content
                property: "width"
                to: 300
                duration: 1000
            }
        }
    }
}
