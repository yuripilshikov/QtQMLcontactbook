import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0 // stackView
import QtQuick.Layouts 1.12 // GridLayout

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
        initialItem: listView
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

    Component {
        id: listView

        Rectangle {
            id: content
            anchors.fill: parent



            signal createNewCard

            Component.onCompleted: {
                createNewCard.connect(stack.createNewCard);
            }

            ListView {
                id: myListView
                header: Text {text: "Phone book"}
                footer: Text {text: "here be some else text"}

                anchors.fill: parent
                model: _model



                delegate: ContactCard {
                    text: name + "\n" + phone + "\n" + email
                    color: cardColor
                    Component.onCompleted: {
                        trigger.connect(root.componentTriggered);
                        trigger.connect(stack.showDetails);
                    }
                }

            }

            Button {
                id: newCardButton
                anchors.bottom: parent.bottom;
                anchors.left: parent.left;
                text: "create new"
                onClicked: {
                    console.log("clicked!!!");
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


}
