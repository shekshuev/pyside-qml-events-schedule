import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3

Item {

    Rectangle {
        id: listPage
        color: "#ffffff"
        anchors.fill: parent

        ListView {
            id: listView
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            delegate: Pane {
                width: view.width
                height: 100
                Material.elevation: 3

                ColumnLayout {
                    Text {
                        Layout.fillWidth: true
                        renderType: Text.NativeRendering
                        text: model.title
                    }
                }


            }
            model: ListModel {
                ListElement {
                    title: "test"
                    description: "description here..."
                }
                ListElement {
                    title: "test"
                    description: "description here..."
                }
                ListElement {
                    title: "test"
                    description: "description here..."
                }
                ListElement {
                    title: "test"
                    description: "description here..."
                }
                ListElement {
                    title: "test"
                    description: "description here..."
                }
                ListElement {
                    title: "test"
                    description: "description here..."
                }
                ListElement {
                    title: "test"
                    description: "description here..."
                }
                ListElement {
                    title: "test"
                    description: "description here..."
                }
                ListElement {
                    title: "test"
                    description: "description here..."
                }
                ListElement {
                    title: "test"
                    description: "description here..."
                }
            }

//            delegate: Item {
//                x: 5
//                width: 80
//                height: 40
//                Row {
//                    id: row1
//                    Rectangle {
//                        width: 40
//                        height: 40
//                        color: colorCode
//                    }

//                    Text {
//                        text: name
//                        anchors.verticalCenter: parent.verticalCenter
//                        font.bold: true
//                    }
//                    spacing: 10
//                }
//            }
//            model: ListModel {
//                ListElement {
//                    name: "Grey"
//                    colorCode: "grey"
//                }

//                ListElement {
//                    name: "Red"
//                    colorCode: "red"
//                }

//                ListElement {
//                    name: "Blue"
//                    colorCode: "blue"
//                }

//                ListElement {
//                    name: "Green"
//                    colorCode: "green"
//                }
//            }
        }
    }

}
