import QtQuick 2.6
import QtQuick.Window 2.2

Item {
    visible: true
    id: rootWindow
    width: Screen.width

    height: Screen.height
    focus: true

    Image {
        id: backgroundImage
        source: "resources/bargame/school_bg1.jpg"
        sourceSize.height: rootWindow.height
        sourceSize.width: rootWindow.width
        //fillMode: Image.Stretch
        anchors.fill: rootWindow

    }

    Image {
        id: tux
        source: "resources/bargame/tux.png"
        height: rootWindow.height / 3.8
        width: rootWindow.width / 8
        y: rootWindow.height - rootWindow.height / 1.8
        x: rootWindow.width - rootWindow.width / 1.05
    }

    Grid {
        id: blueBalls
        columns: 4
        rows: 1
        x: rootWindow.width / 5
        y: rootWindow.height / 1.6
        Repeater {
            model: 4
            Image {
                id: blueBall
                source: "resources/bargame/blue_ball.png"
                height: rootWindow.height / 9
                width: rootWindow.width / 15
            }

        }
    }

    Grid {
        id: boxes
        rows: 1
        columns: 15
        x: 0
        y: rootWindow.height / 1.4
        Repeater {
            model: 14
            Image {
                id: greenCases
                source:"resources/bargame/case.png"
                height: rootWindow.height / 9
                width: rootWindow.width / 15
            }

        }
        Repeater {
            model: 1
            Image {
                id: lastCase
                source:"resources/bargame/case_last.png"
                height: rootWindow.height / 9
                width: rootWindow.width / 15
            }
        }
    }

    Grid {
        id: greenBalls
        x: rootWindow.width / 5
        y: rootWindow.height / 1.2
        rows: 1
        columns: 4
        Repeater {
            model: 4
            Image {
                id: greenBall
                source: "resources/bargame/green_ball.png"
                height: rootWindow.height / 9
                width: rootWindow.width / 15
            }

        }
    }



    }







