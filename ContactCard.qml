import QtQuick 2.0

Item {
    id: root
    implicitWidth: 300
    implicitHeight: 120

    property alias color: avaColor.color
    property alias text: cardText.text

    Rectangle {
        anchors.fill: parent
        color: "yellow"
        opacity: 0.5

        Rectangle {
            id: avaColor
            width: 100
            height: 100
            x: parent.x + 10
            y: parent.y + 10
            color: "orange"
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
