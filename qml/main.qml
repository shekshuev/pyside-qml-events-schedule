import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: mainWindow
    width: 1000
    height: 580
    visible: true
    title: qsTr("Events schedule")


    header: ToolBar {
        RowLayout {
            anchors.fill: parent
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
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }


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
                source: Qt.resolvedUrl("pages/eventsPage.qml")
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
