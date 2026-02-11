import QtQuick 2.0
import QtQuick.Controls 2.0 // stackView
import QtQuick.Layouts 1.12 // GridLayout

Item {
    Rectangle {
        id: contentNewCard //rename later
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.topMargin: 10

    GridLayout{
        columns: 2  // два столбца
        rows: 4     // две строки

        Text {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            text: "Contact Properties"
        }

        Text {
            Layout.row: 1
            Layout.column: 0
            id: nameT
            text: "Name"
        }

        Text {
            Layout.row: 2
            Layout.column: 0
            id: phoneT
            text: "Phone"
        }

        Text {
            Layout.row: 3
            Layout.column: 0
            id: emailT
            text: "Email"
        }

        TextField {
            Layout.row: 1
            Layout.column: 1
            id: name
            text: "Name"
        }

        TextField {
            Layout.row: 2
            Layout.column: 1
            id: phone
            text: "Phone"
        }

        TextField {
            Layout.row: 3
            Layout.column: 1
            id: email
            text: "Email"
        }
    }
}


}
