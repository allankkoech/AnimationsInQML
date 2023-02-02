import QtQuick 2.15

Item {
    id: control
    implicitHeight: bounceHeight + ballSize + 4
    implicitWidth: ballSize * 3 + spacing * 4

    property int duration: 300              // Animation duration in seconds for each ball bounce
    property bool running: true             // Property if animation is running
    property int ballSize: 20               // Bounce bal size
    property int bounceHeight: 50           // Height the ball moves in y direction
    property int spacing: 3                 // Spacing between balls

    property string ball1Color: 'orange'    // Ball 1 color
    property string ball2Color: 'green'     // Ball 2 color
    property string ball3Color: 'red'       // Ball 3 color

    function start() { running = true; }    // Start animation
    function stop() { running = false; }    // Stop animation

    QtObject {
        id: internal

        property bool ballOneRunning: control.running
        property bool ballTwoRunning: false
        property bool ballThreeRunning: control.running
    }

    // Left ball container
    Item {
        id: leftControl
        height: bounceHeight + ballSize
        width: ballSize
        anchors.left: parent.left
        anchors.leftMargin: control.spacing
        anchors.verticalCenter: parent.verticalCenter

        // Left ball
        Rectangle {
            id: leftRect
            implicitHeight: ballSize
            implicitWidth: ballSize
            radius: ballSize / 2
            color: ball1Color

            // Ball animation seequnce
            SequentialAnimation {
                id: leftSeqAnim
                running: internal.ballOneRunning
                loops: SequentialAnimation.Infinite

                onRunningChanged: if(!running) leftRect.y = 0

                NumberAnimation { target: leftRect; property: "y"; from: 0; to: leftControl.height-leftRect.height; duration: control.duration; easing.type: Easing.InOutQuad; }
                NumberAnimation { target: leftRect; property: "y"; to: 0; duration: control.duration;  easing.type: Easing.InOutQuad;}
            }
        }
    }

    // Ball 2
    Item {
        id: midControl
        height: bounceHeight + ballSize
        width: ballSize
        anchors.left: leftControl.right
        anchors.leftMargin: control.spacing
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: midRect
            implicitHeight: ballSize
            implicitWidth: ballSize
            radius: ballSize / 2
            color: ball2Color
            y: midControl.height / 2 - ballSize

            // Intermediate animation to make animation start look better
            PropertyAnimation {
                duration: control.duration / 2
                property: "y"
                from: midControl.height / 2 - ballSize
                to: midControl.height - ballSize
                running: control.running
                easing.type: Easing.InOutQuad;

                onFinished: internal.ballTwoRunning = true
            }

            SequentialAnimation {
                id: midSeqAnim
                running: internal.ballTwoRunning && control.running
                loops: SequentialAnimation.Infinite

                onRunningChanged: if(!running) midRect.y = midControl.height / 2 - ballSize

                NumberAnimation { target: midRect; property: "y"; from: midControl.height - ballSize; to: 0; duration: control.duration; easing.type: Easing.InOutQuad; }
                NumberAnimation { target: midRect; property: "y"; to: midControl.height - ballSize; duration: control.duration;  easing.type: Easing.InOutQuad;}
            }
        }
    }

    // Ball 3
    Item {
        id: rightControl
        height: bounceHeight + ballSize
        width: ballSize
        anchors.left: midControl.right
        anchors.leftMargin: control.spacing
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: rightRect
            implicitHeight: ballSize
            implicitWidth: ballSize
            radius: ballSize / 2
            color: ball3Color

            SequentialAnimation {
                id: rightSeqAnim
                running: control.running
                loops: SequentialAnimation.Infinite

                onRunningChanged: if(!running) rightRect.y = rightControl.height - ballSize

                NumberAnimation { target: rightRect; property: "y"; from: rightControl.height - ballSize; to: 0; duration: control.duration; easing.type: Easing.InOutQuad; }
                NumberAnimation { target: rightRect; property: "y"; to: rightControl.height - ballSize; duration: control.duration;  easing.type: Easing.InOutQuad;}
            }
        }
    }
}
