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

    Image {
        id: backgroundImage
        source: "resources/bargame/school_bg" + Activity.level + ".jpg"
        sourceSize.height: rootWindow.height
        sourceSize.width: rootWindow.width
        //fillMode: Image.Stretch
        anchors.fill: rootWindow
    }

    // Add here the QML items you need to access in javascript
    QtObject {
        id: items
        property Item boxModel: boxModel
        property Item rootWindow: rootWindow
        property alias boxes: boxes
        property alias blueAnswerBallsPlacement: blueAnswerBallsPlacement
        property alias answerBalls: answerBalls
        property alias startCase: startCase
        property alias lastCase: lastCase
        property alias startMask: startMask
        property alias lastMask: lastMask
        //        property var dataset : {
        //            "helicopter": qsTr("\n   Click on \n the helicopter \n and let \n tux jump"),
        //            "Minitux": qsTr("\n  Click on \n tux open \n the parachute"),
        //            "parachute": qsTr("\n use up \n and down \n arrow key \n to regulate")

    }


    Component.onCompleted: {
        Activity.start(items)

        Activity.calculateWinPlaces();
    }


    // Tux image
    Image {
        id: tux
        source: "resources/bargame/tux" + Activity.level + ".png"
        height: rootWindow.height / 3.8
        width: rootWindow.width / 8
        y: rootWindow.height - rootWindow.height / 1.8
        x: rootWindow.width - rootWindow.width / Activity.tuxPositionFactor[Activity.sublevel - 1]
    }

    // Upper blue balls sample
    Grid {
        id: blueBalls
        columns: Activity.sampleBallsNo[Activity.sublevel - 1]
        rows: 1
        x: rootWindow.width / 5
        y: rootWindow.height / 1.7
        Repeater {
            model: blueBalls.columns
            Image {
                id: blueBall
                source: "resources/bargame/blue_ball.png"
                height: rootWindow.height / (8 + Activity.ballSizeFactor[Activity.sublevel - 1])
                width: rootWindow.width / (15 + Activity.ballSizeFactor[Activity.sublevel - 1])
            }

        }
    }
    // Lower green balls sample
    Grid {
        id: greenBalls
        x: rootWindow.width / 5
        y: rootWindow.height / 1.2
        rows: 1
        columns: Activity.sampleBallsNo[Activity.sublevel - 1]
        Repeater {
            model: greenBalls.columns
            Image {
                id: greenBall
                source: "resources/bargame/green_ball.png"
                height: rootWindow.height / (8 + Activity.ballSizeFactor[Activity.sublevel - 1])
                width: rootWindow.width / (15 + Activity.ballSizeFactor[Activity.sublevel - 1])
            }

        }
    }

    // Box row
    Item {
        id: boxModel

        // Number grid
        Grid {
            id: numberGrid
            columns: 2
            rows: 1
            columnSpacing: rootWindow.width / 3.1
            x: rootWindow.width / 2.4
            y: rootWindow.height / 1.5
            Repeater {
                id: numberList
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
            columns: Activity.boardSize[Activity.sublevel-1]
            x: 0
            y: rootWindow.height / 1.4
            Repeater {
                id: startCase
                model: Activity.boardSize[Activity.sublevel-1] - 1
                Image {
                    id: greenCase
                    source:"resources/bargame/case.png"
                    height: rootWindow.height / (9 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                    width: rootWindow.width / (15 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                    visible: true
                }
            }
            Repeater {
                id: lastCase
                model: 1
                Image {
                    id: redCase
                    source:"resources/bargame/case_last.png"
                    height: rootWindow.height / (9 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                    width: rootWindow.width / (15 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                    visible: true
                }
            }
        }

        // Masks
        Grid {
            id: masks
            x: rootWindow.width / 2000
            y: rootWindow.height / 1.4
            rows: 1
            columns: Activity.boardSize[Activity.sublevel-1]
            Repeater {
                id: startMask
                model: Activity.boardSize[Activity.sublevel-1] - 1
                Image {
                    id: greenMask
                    source: "resources/bargame/mask.png"
                    height: rootWindow.height / (9 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                    width: rootWindow.width / (15 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                }
            }
            Repeater {
                id: lastMask
                model: 1
                Image {
                    id: redMask
                    source: "resources/bargame/mask_last.png"
                    height: rootWindow.height / (9 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                    width: rootWindow.width / (15 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                }
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
            font.pixelSize: rootWindow.height / 30
            anchors.centerIn: playLabel
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {

                Activity.reSetup();
                //                for(var i = 0; i <  Activity.noOfBalls; i++) {
                //                    Activity.moveCount++;

                //                    if (Activity.moveCount <= (Activity.boardSize[Activity.sublevel-1] - 1)) {
                //                        greenAnswerBallsPlacement.children[Activity.moveCount].opacity = 1.0;
                //                    } else if (Activity.moveCount >= (Activity.boardSize[Activity.sublevel-1] - 1)) {
                //                        Activity.reSetup();
                //                        break;
                //                    }
                //                }
                //                Activity.noOfBalls = 1;
                //                numberOfBalls.text = 1;
                //                Activity.machinePlay();

            }
        }
    }

    // Hidden Answer Balls
    Item {
        id: answerBalls
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











