import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.0 // stackView // 1.0 for tableview
import QtQuick.Layouts 1.12 // GridLayout
import QtQuick.Dialogs 1.2 // openFileDialog
import QtQuick.LocalStorage 2.12 // Local storage

Window {
    id: root
    visible: true
    width: 480
    height: 640
    title: qsTr("Phone book")

    StackView {
        id: stack
        initialItem: mainMenuScreen
        anchors.fill: parent
    }

    Component {
        id: contactsListScreen

        ContactListScreen{}
    }

    Component {
        id: mainMenuScreen
        Rectangle {
            id: content
            color: "#f1e9d2"

            BorderImage {
                id: myBorderImage
                anchors {fill: parent; margins: 20}
                border.left: 16; border.top: 16
                border.right: 16; border.bottom: 16
                horizontalTileMode: BorderImage.Repeat
                verticalTileMode: BorderImage.Repeat
                source: "image://myimageprovider/testBorderImage"
            }

            BorderImage {
                id: myBorderImage1
                anchors {fill: parent; margins: 80}
                border.left: 16; border.top: 16
                border.right: 16; border.bottom: 16
                horizontalTileMode: BorderImage.Repeat
                verticalTileMode: BorderImage.Repeat
                source: "image://myimageprovider/testBorderImage_2"
            }


            Column {
                spacing: 30
                anchors.centerIn: content

                Button {
                    id: btnNewDB
                    //font.pixelSize: 30
                    text: "New database"
                    onClicked: {
                        folderDialog.open();
                    }
                }
                Button {
                    id: btnOpenDB
                    //font.pixelSize: 30
                    text: "Open database"
                    onClicked: {
                        fileDialog.open()
                    }
                }

                Button {
                    id: btnListView
                    text: "Simple List View"
                    onClicked: {
                        stack.push(contactListScreenSimple);
                    }
                }
            }
        }
    }

    // С "моделью" в памяти
    Component {
        id: contactListScreenSimple
        ContactListSimple {}
    }

    // Открытие пустой базы
    FileDialog {
        id: folderDialog
        title: "Select folder to store contacts database";
        selectFolder: true;
        onAccepted: {
            console.log("File: " + fileUrl);
            var result = _dbhelper.connectEmptyDatabase(fileUrl);
            console.log(result);
            // print data base
            _dbhelper.printDatabase();
            _sqlmodel.init();
            stack.push(contactsListScreen);
        }
    }

    // открытие существующей базы данных
    FileDialog {
        id: fileDialog
        title: "Select database file";
        onAccepted: {
            console.log("File: " + fileUrl);
            var result = _dbhelper.connectExistingDatabase(fileUrl);
            console.log(result);
            // print data base
            _dbhelper.printDatabase();
            _sqlmodel.init();
            stack.push(contactsListScreen);
        }
        onRejected: console.log("canceled")
    }
}
