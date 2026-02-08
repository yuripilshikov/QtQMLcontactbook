import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Phone book")

    ListView {
        anchors.fill: parent
        model: _model

        delegate: ContactCard {
            text: name + "\n" + phone + "\n" + email
            color: cardColor
        }
    }
}
