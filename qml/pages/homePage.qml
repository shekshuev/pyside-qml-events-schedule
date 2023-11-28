import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item {
    Rectangle {
        id: homePage
        color: "#ffffff"
        anchors.fill: parent

        Label {
            id: label
            text: qsTr("Home page")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: Material.primaryTextColor
        }
    }

}

