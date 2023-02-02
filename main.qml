import QtQuick 2.15
import QtQuick.Window 2.15

import "widgets"

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Animation Widgets")

    Column {
        anchors.centerIn: parent
        spacing: 20

        Rectangle {
            height: 100
            width: 150
            radius: 20
            border.width: 1
            border.color: 'grey'

            BounceAnimation {
                running: true
                anchors.centerIn: parent
            }
        }

        Rectangle {
            height: 100
            width: 150
            radius: 20
            border.width: 1
            border.color: 'green'

            BounceAnimation {
                running: true
                duration: 500
                anchors.centerIn: parent
            }
        }

        Rectangle {
            height: 100
            width: 150
            radius: 20
            border.width: 1
            border.color: 'pink'

            BounceAnimation {
                running: true
                duration: 800
                anchors.centerIn: parent
            }
        }
    }
}
