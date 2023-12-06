import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: mainWindow
    width: 480
    height: 640
    visible: true
    title: qsTr("Events schedule")

    function openAddPage() {
        backButton.visible = true
        roundButton.visible = false
        stackView.push(Qt.resolvedUrl("pages/addPage.qml"))
    }

    function goBack() {
        backButton.visible = false
        roundButton.visible = true
        stackView.pop()
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                id: backButton
                icon.source: "qrc:/icons/back.svg"
                visible: false
                onClicked: goBack()
            }
            Label {
                text: {
                    switch (swipeView.currentIndex) {
                    case 0:
                        return "Home";
                    case 1:
                        return "Events list";
                    default:
                        return null;
                    }
                }
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                anchors.fill: parent
            }
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
                        id: eventPageLoader
                        source: Qt.resolvedUrl("pages/listPage.qml")
                        anchors.fill: parent

                        Connections {
                            target: eventPageLoader.item
                            onAddButtonClicked: {
                                backButton.visible = true
                            }
                        }
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
            onClicked: openAddPage()
        }
    }

}
