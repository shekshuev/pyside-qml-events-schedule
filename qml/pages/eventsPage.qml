import QtQuick 2.15
import QtQuick.Controls 2.15

Item {

    Connections {
        target: root
        function onBackButtonClicked() {
            console.log(123)
        }
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
            z: 10
            onClicked: {
                stackView.push(Qt.resolvedUrl("addPage.qml"))
            }
        }
    }
}
