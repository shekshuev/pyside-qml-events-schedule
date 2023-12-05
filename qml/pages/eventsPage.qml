import QtQuick 2.15
import QtQuick.Controls 2.15

Item {

    signal addButtonClicked

    function goBack() {
        roundButton.visible = true
        stackView.pop()
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Loader {
            source: Qt.resolvedUrl("listPage.qml")
        }

        RoundButton {
            id: roundButton
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            icon.source: "qrc:/icons/add.svg"
            Material.background: Material.accent
            Material.foreground: Material.toolTextColor
            z: 10
            onClicked: {
                addButtonClicked()
                roundButton.visible = false
                stackView.push(Qt.resolvedUrl("addPage.qml"))
            }
        }
    }
}
