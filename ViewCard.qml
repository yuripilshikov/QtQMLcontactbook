import QtQuick 2.12
import QtQuick.Window 2.12

Item {
    Rectangle {
        id: content
        anchors.fill: parent
        color: "yellow"
        opacity: 0.4
        signal returnToList
        Component.onCompleted: {
            returnToList.connect(stack.returnToList);
        }

        Text {
            id: contentText
            text: stack.selectedName
        }

        TapHandler {
            onTapped:{
                //console.log(inputField.text);
                returnToList()
            }
        }
    }
}
