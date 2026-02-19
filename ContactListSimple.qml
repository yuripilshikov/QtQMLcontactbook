import QtQuick 2.0
import QtQuick.Controls 1.0 // stackView // 1.0 for tableview
import QtQuick.Layouts 1.12 // GridLayout

Item {
    id: root
    Rectangle {
        anchors.fill: parent
        color: "#f1e9d2"

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

                /*highlight: Rectangle {
                    color: "orange"
                }
                highlightFollowsCurrentItem: true*/


                delegate: ContactCard {
                    text: name + "\n" + phone + "\n" + email + "\n" + company
                    color: ListView.isCurrentItem ? "#d1efa9" : "#dcd7cb"
                    secondaryColor: ListView.isCurrentItem ? "#97da3e" : "#a99c7e"
                    source: "image://myimageprovider/" + avatar
                    //color: cardColor
                    width: parent.width

                    signal sendToEditScreen(var name, var phone, var email, var company)

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            contactListView.currentIndex = index;
                        }
                    }
                }

                header: Rectangle {
                    id: headerRect
                    width: contactListView.width
                    height: childrenRect.height // чтобы поместилось содержимое
                    color: "#f1e9d2"
                    border.color: "#4b3a0a"
                    border.width: 2
                    Column {
                        anchors.horizontalCenter: parent.horizontalCenter
                        GridLayout{                            
                            columns: 2
                            rows: 6
                            columnSpacing: 20
                            rowSpacing: 20


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
                                placeholderText: "Input name"
                            }

                            TextField {
                                Layout.row: 2
                                Layout.column: 1
                                id: phone
                                placeholderText: "Input phone number"
                                inputMask: "+9(999)-999-9999"
                            }

                            TextField {
                                Layout.row: 3
                                Layout.column: 1
                                id: email
                                placeholderText: "Input email"
                            }
                            TextField {
                                Layout.row: 4
                                Layout.column: 1
                                id: organization
                                placeholderText: "Input organization"
                            }
                            TextField {
                                Layout.row: 5
                                Layout.column: 1
                                id: avatar
                                text: "BlueSphere"
                            }
                        }
                        Row {                            
                            anchors.margins: 20
                            Button {
                                text: "Create"
                                onClicked: {
                                    _model.addItem(name.text, phone.text, email.text, organization.text, avatar.text)
                                }
                            }
                            Button {
                                text: "Delete"
                                onClicked: {
                                    _model.removeRow(contactListView.currentIndex);
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
