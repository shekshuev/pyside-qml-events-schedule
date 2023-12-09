import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3

Item {

    signal eventAdded

    property int eventId

    function eventTypeToString(t) {
        switch (t) {
            case 'CLASS':
                return 'Class';
            case 'SPORTS':
                return 'Sports';
            default:
                return 'Other'
        }
    }

    function stringToEventType(t) {
        switch (t) {
            case 'Class':
                return 'CLASS';
            case 'Sports':
                return 'SPORTS';
            default:
                return 'OTHER'
        }
    }

    Component.onCompleted: {
        if (eventId > 0) {
            singleEventModel.load_event(eventId)
        }
    }

    ColumnLayout {
        spacing: 10
        anchors.fill: parent
        anchors.margins: 10

        ColumnLayout {
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            spacing: 10

            TextField {
                id: titleTextField
                placeholderText: "Title"
                Layout.fillWidth: true
                text: singleEventModel.title
                onTextChanged: {
                    singleEventModel.title = text
                }
            }

            TextArea {
                id: descriptionTextArea
                placeholderText: "Description"
                Layout.fillWidth: true
                text: singleEventModel.description
                onTextChanged: {
                    singleEventModel.description = text
                }
            }

            ComboBox {
                id: eventTypeComboBox
                Layout.fillWidth: true
                Component.onCompleted: {
                    currentIndex = find(eventTypeToString(singleEventModel.event_type))
                }
                model: ["Class", "Sports", "Other"]
                onCurrentIndexChanged: {
                    singleEventModel.event_type = stringToEventType(model[currentIndex])
                }
            }

        }

        Button {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom
            text: "Add"
            Material.roundedScale: Material.FullScale
            onClicked: {
                singleEventModel.save()
                eventAdded()
            }
        }
    }
}
