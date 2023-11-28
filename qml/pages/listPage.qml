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
            spacing: 10

            delegate: Pane {
                width: listView.width
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
            model: eventModel
            ScrollBar.vertical: ScrollBar {}
        }

    }

}
