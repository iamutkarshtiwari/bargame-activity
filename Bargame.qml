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
        source: "resources/bargame/school_bg1.jpg"
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
        property alias tux: tux
        property alias blueBalls: blueBalls
        property alias greenBalls: greenBalls

        property alias boxes: boxes
        property alias masks: masks
        property alias numberOfBalls: numberOfBalls



        property alias backgroundImage: backgroundImage
        property alias blueAnswerBallsPlacement: blueAnswerBallsPlacement
        property alias greenAnswerBallsPlacement: greenAnswerBallsPlacement
        property alias answerBalls: answerBalls
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
        source: "resources/bargame/tux1.png"
        height: rootWindow.height / 3.8
        width: rootWindow.width / 8
        y: rootWindow.height - rootWindow.height / 1.8
        x: rootWindow.width - rootWindow.width / 1.05
    }

    // Upper blue balls sample
    Grid {
        id: blueBalls
        columns: 4
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
        columns: 4
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
        // The empty boxes grid
        Grid {
            id: boxes
            rows: 1
            columns: 15
            x: 0
            y: rootWindow.height / 1.4
            Repeater {
                id: startCase
                model: boxes.columns
                Image {
                    id: greenCase
                    source:"resources/bargame/" + ((index == boxes.columns - 1) ? "case_last.png" : "case.png")
                    height: rootWindow.height / (9 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                    width: rootWindow.width / (15 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                    visible: true
                    // Numbering label
                    Text {
                        text: index + 1
                        font.pixelSize: rootWindow.height / 25
                        font.bold: true
                        visible: ((index + 1) % 5 == 0 && index > 0) ? true : false
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.top
                        }
                    }
                }
            }
        }


        // Hidden Answer Balls
        Item {
            id: answerBalls
            // All green balls placement
            Grid {

                id: greenAnswerBallsPlacement
                x: rootWindow.width / 2000
                y: rootWindow.height / 1.6
                columns: 15
                rows: 1

                Repeater {
                    model: greenAnswerBallsPlacement.columns
                    Image {
                        id: greenBall
                        source: "resources/bargame/green_ball.png"
                        height: rootWindow.height / (9 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                        width: rootWindow.width / (15 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                        opacity: 0.0
                    }
                }
            }
            // All blue balls placement
            Grid {
                id: blueAnswerBallsPlacement
                x: rootWindow.width / 2000
                y: rootWindow.height / 1.4
                columns: 15
                rows: 1
                Repeater {
                    model: blueAnswerBallsPlacement.columns
                    Image {
                        source: "resources/bargame/blue_ball.png"
                        height: rootWindow.height / (9 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                        width: rootWindow.width / (15 + (Activity.sublevel - 1) * Activity.elementSizeFactor[Activity.sublevel - 1])
                        opacity: 0.0
                    }
                }
            }
        }


        // Masks
        Grid {
            id: masks
            x: rootWindow.width / 2000
            y: rootWindow.height / 1.4
            rows: 1
            columns: 15
            Repeater {
                id: startMask
                model: masks.columns
                Image {
                    id: greenMask
                    source: "resources/bargame/" + ((index == boxes.columns - 1) ? "mask_last.png" : "mask.png")
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
                Activity.play(true, numberOfBalls.text );
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
                Activity.noOfBalls ++;
                if (Activity.noOfBalls > Activity.numberBalls[Activity.sublevel - 1 ][1]) {
                    Activity.noOfBalls = Activity.numberBalls[Activity.sublevel - 1 ][0];
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











