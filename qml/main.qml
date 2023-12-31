import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: root
    width: 480
    height: 640
    visible: true
    title: qsTr("Events schedule")

    property var size: listEventModel.rowCount()
    property string currentStackViewPage: "default"

    function openSinglePage(id: int) {
        backButton.visible = true
        roundButton.visible = false
        stackView.push(Qt.resolvedUrl("pages/singlePage.qml"), { eventId: id || 0 })
        currentStackViewPage = id > 0 ? "editPage" : "addPage"
    }

    function goBack() {
        backButton.visible = false
        roundButton.visible = true
        stackView.pop()
        currentStackViewPage = "default"
    }


    Connections {
        target: singleEventModel
        function onEdited() {
            listEventModel.refresh()
            size = listEventModel.rowCount()
            goBack()
        }
    }

    header: ToolBar {
        ToolButton {
            id: backButton
            icon.source: "qrc:/icons/back.svg"
            visible: false
            onClicked: goBack()
            anchors.left: parent.left
        }
        Label {
            text: {
                if (currentStackViewPage === "addPage") {
                    return "Add new event"
                } else if (currentStackViewPage === "editPage") {
                    return "Edit event"
                } else {
                    switch (swipeView.currentIndex) {
                        case 0:
                            return "Home";
                        case 1:
                            return "Events list";
                        default:
                            return null;
                    }
                }
            }
            anchors.centerIn: parent
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Page {
            SwipeView {
                id: swipeView
                anchors.fill: parent
                currentIndex: tabBar.currentIndex
                onCurrentIndexChanged: {
                    tabBar.currentIndex = currentIndex
                }

                Page {
                    Loader {
                        source: Qt.resolvedUrl("pages/homePage.qml")
                        anchors.fill: parent
                    }
                }

                Page {
                    Loader {
                        id: pageLoader
                        Connections {
                            target: pageLoader.item
                            function onEditButtonClicked(id: int) {
                                openSinglePage(id)
                            }
                        }
                        source: size > 0 ? Qt.resolvedUrl("pages/listPage.qml") : Qt.resolvedUrl("pages/emptyListPage.qml")
                        anchors.fill: parent
                    }
                }

            }

            footer: TabBar {
                id: tabBar
                width: parent.width
                currentIndex: swipeView.currentIndex
                onCurrentIndexChanged: {
                    swipeView.currentIndex = currentIndex
                }

                TabButton {
                    id: homeButton
                    icon.source: "qrc:/icons/home.svg"
                }

                TabButton {
                    id: listButton
                    icon.source: "qrc:/icons/list.svg"
                }
            }

        }

        RoundButton {
            id: roundButton
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.rightMargin: 10
            icon.source: "qrc:/icons/add.svg"
            Material.background: Material.accent
            Material.foreground: Material.toolTextColor
            z: 10
            onClicked: openSinglePage()
        }
    }

}
