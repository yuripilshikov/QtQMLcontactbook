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
                    anchors.margins: 5
                    model: _model
                    clip: true

                    highlight: Rectangle {
                        color: "orange"
                    }
                    highlightFollowsCurrentItem: true


                    delegate: ContactCard {
                        text: name + "\n" + phone + "\n" + email + "\n" + company
                        //color: ListView.isCurrentItem ? "red" : cardColor
                        color: cardColor
                        width: parent.width

                        signal sendToEditScreen(var name, var phone, var email, var company)

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                // не хочет взаимодействовать с выделенным
                                console.log("Before click: " + ListView.view.currentIndex)
                                ListView.view.currentIndex = _model.index
                                console.log("After click: " + ListView.view.currentIndex)
                            }

                            /*onDoubleClicked: {
                                // attempt to edit existing card
                                console.log("double clicked!");
                                console.log("old company: " + company);
                                company = "edited";
                                email = "edited";
                                console.log("new company: " + company);
                            }*/
                        }
                    }
                    header: Rectangle {
                        width: contactListView.width
                        height: childrenRect.height // чтобы поместилось содержимое
                        Column {
                            GridLayout{
                                columns: 2
                                rows: 5

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

                                Text {
                                    Layout.row: 4
                                    Layout.column: 0
                                    id: orgT
                                    text: "Organization"
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
                                TextField {
                                    Layout.row: 4
                                    Layout.column: 1
                                    id: organization
                                    text: "Organization"
                                }
                            }
                            Button {
                                text: "Create"
                                onClicked: {
                                    _model.addItem(name.text, phone.text, email.text, organization.text)
                                }
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

    // open database
    FileDialog {
        id: fileDialog
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
