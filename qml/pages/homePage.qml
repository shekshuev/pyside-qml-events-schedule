import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    Label {
        id: label
        text: qsTr("Home page")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

