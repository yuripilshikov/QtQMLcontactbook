import QtQuick 2.12

Item {
    id: root
    implicitWidth: 300
    implicitHeight: 120

    property alias color: content.color
    property alias text: cardText.text

    signal clicked(var event)
    signal trigger(string name) // cardText.text to be sent.

    Rectangle {
        id: content
        anchors.fill: parent
        color: "yellow"
        opacity: 0.5

        Rectangle {
            id: contactPhoto
            width: 100
            height: width
            radius: width/2
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

        Rectangle { // delete button
            id: deleteButton
            color: "black"
            //radius: 10
            height: 0
            width: 0
            anchors.right: content.right
            anchors.top: content.top

            TapHandler {
                onTapped: (eventPoint)=>{console.log("DELETING!!!")}
                //onLongPressed: area.longPress = false
            }
        }

        TapHandler {
            id: area
            property bool longPress: false
            property bool selected: false
            onTapped:{
                selected = !selected;
                (eventPoint)=>{root.clicked(eventPoint)}
                root.trigger(cardText.text); // !!!
            }
            onLongPressed: longPress = !longPress
        }
    }

    states: [
        State {
           name: "showDeleteButton"
           when: area.longPress
           PropertyChanges {
               target: deleteButton
               width: 40
           }
           PropertyChanges {
               target: deleteButton
               height: 40
           }
           PropertyChanges {
               target: content
               height: 120
           }
        },
        State {
            name: "normal"
            when: !area.longPress || !area.selected
            PropertyChanges {
                target: deleteButton
                width: 0
            }
            PropertyChanges {
                target: deleteButton
                height: 0
            }

        },
        State {
            name: "selected"
            when: area.selected
            PropertyChanges {
                target: root
                height: 300
            }
        }

    ]

    transitions: [Transition {
        ParallelAnimation {
            NumberAnimation {
                target: deleteButton
                property: "width"
                easing.type: Easing.InQuad
                duration: 3000
            }
            NumberAnimation {
                target: deleteButton
                property: "height"
                easing.type: Easing.InQuad
                duration: 3000
            }
        }
    }, Transition {
            NumberAnimation {
                target: content
                property: "height"
                duration: 3000
                easing.type: Easing.InOutQuad
            }
        }
    ]
}
