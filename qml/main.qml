import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Window {
    id: mainWindow
    width: 1000
    height: 580
    visible: true
    color: "#00000000"
    title: qsTr("Events schedule")

    Rectangle {
        id: bg
        color: Material.background
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        Rectangle {
            id: leftMenu
            width: 70
            color: Material.primary
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Column {
                id: column
                anchors.fill: parent
                anchors.bottomMargin: 0

                ToolButton {
                    id: homeButton
                    width: 70
                    height: 60
                    icon.source: "../icons/home.svg"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.leftMargin: 0
                    onClicked: {
                        stackView.push(Qt.resolvedUrl("pages/homePage.qml"))
                    }
                }

                ToolButton {
                    id: listButton
                    height: 60
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: homeButton.bottom
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    icon.source: "../icons/list.svg"
                    onClicked: {
                        stackView.push(Qt.resolvedUrl("pages/listPage.qml"))
                    }
                }

                ToolButton {
                    id: addButton
                    height: 60
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: listButton.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    icon.source: "../icons/add.svg"
                    onClicked: {
                        stackView.push(Qt.resolvedUrl("pages/addPage.qml"))
                    }
                }

            }
        }

        StackView {
            id: stackView
            anchors.left: leftMenu.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            clip: true
            anchors.leftMargin: 0
            initialItem: Qt.resolvedUrl("pages/homePage.qml")
        }
    }
}
