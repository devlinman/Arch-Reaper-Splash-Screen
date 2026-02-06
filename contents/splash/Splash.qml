import QtQuick 2.5

Rectangle {
    id: root

    property int stage

    color: "black"
    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content

        anchors.fill: parent
        opacity: 0

        TextMetrics {
            id: units

            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit / 4)

            text: "M"
        }

        Image {
            id: logo

            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 8

            anchors.centerIn: parent
            source: "images/arch-logo-red.png"
            sourceSize.width: size
            sourceSize.height: size
        }

        Image {
            id: busyIndicator

            //in the middle of the remaining space
            y: parent.height - (parent.height - logo.y) / 2 - height / 2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busy01.svg"
            sourceSize.height: units.gridUnit * 3
            sourceSize.width: units.gridUnit * 3

            RotationAnimator on rotation {
                id: rotationAnimator

                from: 0
                to: 360
                duration: 800
                loops: Animation.Infinite
            }

        }

    }

    OpacityAnimator {
        id: introAnimation

        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }

}
