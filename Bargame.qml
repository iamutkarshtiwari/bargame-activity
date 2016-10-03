/* GCompris - Bargame.qml
 *
 * Copyright (C) 2016 UTKARSH TIWARI <iamutkarshtiwari@kde.org >
 *
 * Authors:
 *   Bruno Coudoin <bruno.coudoin@gcompris.net> (GTK+ version)
 *   UTKARSH TIWARI <iamutkarshtiwari@kde.org > (Qt Quick port)
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.1
//import GCompris 1.0
import QtGraphicalEffects 1.0
//import "../../core"
//import "qrc:/gcompris/src/core/core.js" as Core
import "./bargame.js" as Activity

import QtQuick 2.6
import QtQuick.Window 2.2

Item {
    visible: true
    id: rootWindow
    width: Screen.width
    height: Screen.height
    focus: true

    property int board_paused: 0
    property var numberBalls: [[1, 4], [2, 6], [3, 6]]
    property var boardSize: [15, 19, 29]

    Image {
        id: backgroundImage
        source: "resources/bargame/school_bg1.jpg"
        sourceSize.height: rootWindow.height
        sourceSize.width: rootWindow.width
        //fillMode: Image.Stretch
        anchors.fill: rootWindow
    }

    // Add here the QML items you need to access in javascript
    QtObject {
            id: items
            property alias blueAnswerBallsPlacement: blueAnswerBallsPlacement
//            property string name
//            property int size
//            property varianattributes
        }
//        property var dataset : {
//            "helicopter": qsTr("\n   Click on \n the helicopter \n and let \n tux jump"),
//            "Minitux": qsTr("\n  Click on \n tux open \n the parachute"),
//            "parachute": qsTr("\n use up \n and down \n arrow key \n to regulate")



    //            IntroMessage {
    //                id:message
    //                onIntroDone: {
    //                    Activity.start(items)
    //                }
    //            }


    Component.onCompleted: {
            Activity.start(items)

            Activity.calculateWinPlaces();
        }





    // Tux image
    Image {
        id: tux
        source: "resources/bargame/tux.png"
        height: rootWindow.height / 3.8
        width: rootWindow.width / 8
        y: rootWindow.height - rootWindow.height / 1.8
        x: rootWindow.width - rootWindow.width / 1.05
    }

    // Upper blue balls collection
    Grid {
        id: blueBalls
        columns: 4
        rows: 1
        x: rootWindow.width / 5
        y: rootWindow.height / 1.7
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

    // Number grid
    Grid {
        id: numberGrid
        columns: 2
        rows: 1
        columnSpacing: rootWindow.width / 3.1


        x: rootWindow.width / 2.4
        y: rootWindow.height / 1.5
        Repeater {
            model: 2
            Text {
                id: number
                text: (index + 1) * 5
                font.pixelSize: rootWindow.height / 25
                font.bold: true

            }
        }

    }

    // The empty boxes grid
    Grid {
        id: boxes
        rows: 1
        columns: Activity.boardSize[0]
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

    // Lower green balls collection
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



    // OK BUTTON
    Rectangle {
        id: playLabel
        radius: rootWindow.width / 9
        x: rootWindow.width / 1.2
        y: rootWindow.height / 2
        width: rootWindow.width / 20
        height: rootWindow.width / 20

        color: "red"
        border.color: "black"
        border.width: 5
        Text {
            id: play
            text: "OK"
            font.bold: true
            color: "white"
            //            x: rootWindow.width / 1.1
            //            y: rootWindow.height / 1.8
            font.pixelSize: rootWindow.height / 30
            anchors.centerIn: playLabel
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {

                for(var i = Activity.moveCount; i < Activity.moveCount + Activity.noOfBalls; i++) {
                    if (Activity.bool == false) {
                        greenAnswerBallsPlacement.children[i].opacity = 1.0;
                    }
                }
                Activity.moveCount += Activity.noOfBalls;
                //Activity.bool = !Activity.bool;
                Activity.noOfBalls = 1;
                numberOfBalls.text = 1;
                Activity.machinePlay();




            }
        }
    }

    // Hidden Answer Balls
    Item {
        // All green balls placement
        Row {

            id: greenAnswerBallsPlacement
            x: rootWindow.width / 2000
            y: rootWindow.height / 1.4

            Repeater {
                model: 15
                Image {
                    id: greenBall
                    source: "resources/bargame/green_ball.png"
                    height: rootWindow.height / 9
                    width: rootWindow.width / 15
                    opacity: 0.0
                }

            }
        }
        // All blue balls placement
        Row {
            id: blueAnswerBallsPlacement
            x: rootWindow.width / 2000
            y: rootWindow.height / 1.4
            Repeater {
                model: 15
                Image {
                    source: "resources/bargame/blue_ball.png"
                    height: rootWindow.height / 9
                    width: rootWindow.width / 15
                    opacity: 0.0
                }

            }
        }
    }


    // Cover up cases
    // All balls placement
    Grid {
        id: answerBallsCoverup
        x: rootWindow.width / 2000
        y: rootWindow.height / 1.4
        rows: 1
        columns: 15
        Repeater {
            model: 14
            Image {
                source: "resources/bargame/mask.png"
                height: rootWindow.height / 9
                width: rootWindow.width / 15
            }
        }
        Repeater {
            model: 1
            Image {
                source: "resources/bargame/mask_last.png"
                height: rootWindow.height / 9
                width: rootWindow.width / 15
            }
        }
    }



    // Number of balls to be placed
    Image {
        id: ballNumberPlate
        x: rootWindow.width / 1.3
        y: rootWindow.height / 1.2
        source: "resources/bargame/enumerate_answer.png"
        width: rootWindow.width / 6
        height: rootWindow.height / 7

        MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.source = "resources/bargame/enumerate_answer_focus.png";
                //Activity.noOfBalls + = 1;
                Activity.noOfBalls ++;
                if (Activity.noOfBalls > 4) {
                    Activity.noOfBalls = 1;
                }
                numberOfBalls.text = Activity.noOfBalls;
            }
        }

        // Ball Icon
        Image{
            id: ballIcon
            source: "resources/bargame/green_ball.png"
            width: rootWindow.width / 16
            height: rootWindow.height / 10
            anchors {
                verticalCenter: ballNumberPlate.verticalCenter
                left: ballNumberPlate.left
            }
        }
        // Number label
        Text {
            id: numberOfBalls
            text: "1"
            color: 'Red'
            font.bold: true
            font.pixelSize: rootWindow.height / 17
            anchors {
                centerIn: ballNumberPlate
            }
        }
    }


}











