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

    signal componentTriggered(string name)

    onComponentTriggered: {
        console.log(name + ' component was triggered')
    }

    StackView {
        id: stack
        //initialItem: listView
        initialItem: mainMenuScreen
        anchors.fill: parent

        property string selectedName;

        signal showDetails(string name)

        onShowDetails: {
            stack.selectedName = name;
            stack.push(detailedView);
        }

        signal returnToList()
        onReturnToList: {
            stack.pop()
        }

        signal createNewCard()
        onCreateNewCard: {
            stack.push(newCardView);
        }

    }

    // table view (not working)
    Component {
        id: contactsListScreen
        TableView {
            //anchors.fill: parent;
            model: _sqlmodel;

            TableViewColumn {
                role: "name"
                title: "Name"
                width: 200
            }
            TableViewColumn {
                role: "phone"
                title: "Phone"
                width: 200
            }
        }
    }

    Component {
        id: mainMenuScreen
        Rectangle {
            id: content
            color: "orchid"

            Column {
                spacing: 30
                anchors.centerIn: content

                Button {
                    id: btnNewDB
                    //font.pixelSize: 30
                    text: "New database (not working)"
                    onClicked: {
                        fileDialog.open();
                    }
                }
                Button {
                    id: btnOpenDB
                    //font.pixelSize: 30
                    text: "Open database (TODO)" //
                    onClicked: {
                        //fileDialog.open()
                    }
                }

                Button {
                    id: btnTryLocalStorage
                    text: "LocalStorage DB"
                    onClicked: {
                        stack.push(localStorageView)
                    }
                }

                Button {
                    id: btnQuit
                    //font.pixelSize: 30
                    text: "Quit" // пока это чисто для тестов кнопка!
                    onClicked: {
                        stack.push(listView); // похоже, можно без сигнала.

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

    Component {
        id: contactListScreenSimple

        Rectangle {
            color: "skyblue"

            Column {
                anchors.margins: 10
                anchors.fill: parent
                spacing: 10

                ListView {
                    id: contactListView
                    width: parent.width
                    height: parent.height - createButton.height - parent.spacing
                    spacing: 10
                    model: _model
                    clip: true

                    delegate: ContactCard {
                        text: name + "\n" + phone + "\n" + email + "\n" + company
                        color: cardColor
                        width: parent.width

                        signal sendToEditScreen(var name, var phone, var email, var company)


                        MouseArea {
                            anchors.fill: parent
                            onDoubleClicked: {
                                console.log("double clicked!");
                                console.log("old company: " + company);
                                company = "edited";
                                email = "edited";
                                console.log("new company: " + company);
                            }
                        }
                    }
                }

                Button {
                    id: createButton
                    text: "Create new"
                    onClicked: {
                        _model.add()
                    }
                }
            }




        }

    }

    // непонятно, как с ним работать. TODO
    Component {
        id: localStorageView
        Rectangle {
            Component.onCompleted: {
                /*var db = LocalStorage.openDatabaseSync("MyAppData", "1.0", "My Application Database", 1000000);
                db.transaction(function (tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS greetings (message TEXT)');
                    tx.executeSql('INSERT INTO greetings VALUES (?)', ['Hello, QML!']);
                    var results = tx.executeSql('SELECT * FROM greetings');
                    console.log("Database entry:", results.rows.item(0).message);
                });*/
            }
        }
    }

    // старая версия списка контактов
    Component {
        id: listView

        Rectangle {
            id: content            

            signal createNewCard

            Component.onCompleted: {
                createNewCard.connect(stack.createNewCard);
            }

            ListView {
                id: myListView
                header: Text {text: "Phone book"}
                anchors.fill: parent
                model: _model
                delegate: ContactCard {
                    text: name + "\n" + phone + "\n" + email
                    color: cardColor
                    Component.onCompleted: {
                        trigger.connect(root.componentTriggered);
                        trigger.connect(stack.showDetails);
                    }
                    onClicked: {
                        console.log(currentIndex)
                    }
                }
                footer: Text {text: "here be some else text"}
            }

            Button {
                id: newCardButton
                anchors.bottom: parent.bottom;
                anchors.left: parent.left;
                text: "create new"
                onClicked: {
                    content.createNewCard()
                }
            }
        }
    }

    Component {
        id: detailedView
        ViewCard{}
    }
    Component {
        id: newCardView
        EditCard{}
    }

    // Открытие пустой базы
    FileDialog {
        id: fileDialog        
        onAccepted: {
            console.log("File: " + fileUrl);
            var result = _dbhelper.connectEmptyDatabase(fileUrl);
            console.log(result);
            _sqlmodel.init();
            stack.push(contactsListScreen);
        }
        onRejected: console.log("canceled")
    }
}
