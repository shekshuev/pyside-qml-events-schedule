import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3

Item {

    function minTwoDigits(n) {
        return (n < 10 ? '0' : '') + n;
    }

    function isValidDate(d) {
        return d instanceof Date && !isNaN(d);
    }

    function formatType(t) {
        switch (t) {
            case 'CLASS': 
                return 'Class';
            case 'SPORTS': 
                return 'Sports';
            case 'OTHER':
                return 'Other';
            default:
                return 'Unknown'
        }
    }

    signal editButtonClicked(id: int);

    ListView {
        id: listView
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10
        model: listEventModel
        ScrollBar.vertical: ScrollBar {}

        delegate: Pane {
            width: listView.width
            Material.elevation: 3

            RowLayout {
                anchors.fill: parent
                ColumnLayout {
                    Layout.alignment: Qt.AlignLeft
                    Label {
                        Layout.fillWidth: true
                        renderType: Text.NativeRendering
                        text: model.title
                        font.pointSize: 20
                    }
                    Label {
                        Layout.fillWidth: true
                        renderType: Text.NativeRendering
                        text: {
                            return formatType(model.event_type)
                        }
                    }
                    Label {
                        Layout.fillWidth: true
                        renderType: Text.NativeRendering
                        text: model.description
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Label {
                            Layout.fillWidth: true
                            renderType: Text.NativeRendering
                            text: {
                                const date = new Date(model.begin_date * 1000);
                                if (isValidDate(date)) {
                                    return `Begin at ${minTwoDigits(date.getDate())}.${date.getMonth()}.${date.getFullYear()} ${date.toTimeString()}.`;
                                } else {
                                    return 'Begin date is not set.'
                                }
                            }
                        }
                        Label {
                            Layout.fillWidth: true
                            renderType: Text.NativeRendering
                            text: {
                                const date = new Date(model.end_date * 1000);
                                if (isValidDate(date)) {
                                    return `End at ${minTwoDigits(date.getDate())}.${date.getMonth()}.${date.getFullYear()} ${date.toTimeString()}.`;
                                } else {
                                    return 'End date is not set.'
                                }
                            }
                        }
                    }
                }
                ToolButton {
                    icon.source: "qrc:/icons/edit.svg"
                    Layout.alignment: Qt.AlignRight
                    onClicked: {
                        editButtonClicked(model.id)
                    }
                }
            }

        }
    }

}
