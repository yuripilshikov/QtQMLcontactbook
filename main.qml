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
                    model: _sqlmodel
                    clip: true

                    highlight: Rectangle {
                        color: "orange"
                    }
                    highlightFollowsCurrentItem: true

                    delegate: ContactCard {
                        text: name + "\n" + phone + "\n" + email + "\n" + company
                        source: "image://myimageprovider/" + avaid
                        color: color
                        width: parent.width

                        signal sendToEditScreen(var name, var phone, var email, var company)

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                contactListView.currentIndex = index;
                            }
                            onDoubleClicked: {
                                _sqlmodel.setData(_sqlmodel.index(index, 1), "Some name here")
                                _sqlmodel.setData(_sqlmodel.index(index, 2), "Some phone here")
                                _sqlmodel.setData(_sqlmodel.index(index, 3), "Some email here")
                                _sqlmodel.setData(_sqlmodel.index(index, 4), "GreenThorus")
                                _sqlmodel.setData(_sqlmodel.index(index, 6), "Some organization here")

                                if(_sqlmodel.submitAll()) {
                                    console.log("edit success")
                                }
                                else {
                                    //console.log("failed to update row: " + _sqlmodel.lastError().text)
                                    console.log("fail");
                                }

                            }
                        }
                    }
                    header: Rectangle {
                        id: headerRect
                        width: contactListView.width
                        height: childrenRect.height // чтобы поместилось содержимое
                        Column {
                            GridLayout{
                                id: contactGridLayout
                                columns: 2
                                rows: 6

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

                                Text {
                                    Layout.row: 5
                                    Layout.column: 0
                                    id: imageT
                                    text: "Avatar image"
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
                                TextField {
                                    Layout.row: 5
                                    Layout.column: 1
                                    id: avatar
                                    text: "BlueSphere"
                                }
                            }
                            Button {
                                text: "Create"
                                onClicked: {
                                    console.log("QML: Adding item!")
                                    _sqlmodel.addItem(name.text, phone.text, email.text, organization.text, avatar.text);
                                }
                            }
                            Button {
                                text: "Update"
                                onClicked: {
                                    console.log("CURRENT INDEX IS: " +contactListView.currentIndex);

                                    _sqlmodel.setData(_sqlmodel.index(contactListView.currentIndex, 1), name.text)
                                    _sqlmodel.setData(_sqlmodel.index(contactListView.currentIndex, 2), phone.text)
                                    _sqlmodel.setData(_sqlmodel.index(contactListView.currentIndex, 3), email.text)
                                    _sqlmodel.setData(_sqlmodel.index(contactListView.currentIndex, 4), avatar.text)
                                    _sqlmodel.setData(_sqlmodel.index(contactListView.currentIndex, 6), organization.text)

                                    if(_sqlmodel.submitAll()) {
                                        console.log("edit success")
                                    }
                                    else {
                                        //console.log("failed to update row: " + _sqlmodel.lastError().text)
                                        console.log("fail");
                                    }
                                }
                            }
                            Button {
                                text: "Delete"
                                onClicked: {
                                    _model.addItem(name.text, phone.text, email.text, organization.text, avatar.text)
                                }
                            }
                        }
                    }
                }

                Button {
                    id: createButton
                    text: "Create default"
                    onClicked: {
                        //_sqlmodel.add()
                    }
                }
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
                        source: "image://myimageprovider/" + avatar
                        color: cardColor
                        width: parent.width

                        signal sendToEditScreen(var name, var phone, var email, var company)

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                contactListView.currentIndex = index;
                            }

                            onDoubleClicked: {
                                // editing... not working
                                _model.company = "edited";
                                _model.email = "edited";
                            }
                        }
                    }
                    header: Rectangle {
                        width: contactListView.width
                        height: childrenRect.height // чтобы поместилось содержимое
                        Column {                            
                            GridLayout{
                                columns: 2
                                rows: 6

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

                                Text {
                                    Layout.row: 5
                                    Layout.column: 0
                                    id: imageT
                                    text: "Avatar image"
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
                                TextField {
                                    Layout.row: 5
                                    Layout.column: 1
                                    id: avatar
                                    text: "BlueSphere"
                                }
                            }
                            Row {
                                Button {
                                    text: "Create"
                                    onClicked: {
                                        _model.addItem(name.text, phone.text, email.text, organization.text, avatar.text)
                                    }
                                }
                                Button {
                                    text: "Update"
                                    onClicked: {
                                        _model.addItem(name.text, phone.text, email.text, organization.text, avatar.text)
                                    }
                                }
                                Button {
                                    text: "Delete"
                                    onClicked: {
                                        _model.addItem(name.text, phone.text, email.text, organization.text, avatar.text)
                                    }
                                }
                            }


                        }
                    }
                }

                Button {
                    id: createButton
                    text: "Create default"
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
