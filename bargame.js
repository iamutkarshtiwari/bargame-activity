/* GCompris - bargame.js
 *
 * Copyright (C) 2016 UTKARSH TIWARI <iamutkarshtiwari@kde.org >
 *
 * Authors:
 *   Bruno Coudoin (bruno.coudoin@gcompris.net) (GTK+ version)
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
.pragma library
.import GCompris 1.0 as GCompris
.import QtQuick 2.0 as Quick

var boardPaused = 0
var numberBalls = [[1, 4], [2, 6], [3, 6]]
var boardSize = [15, 19, 29]
var sampleBallsNo = [4, 6, 6]
var tuxPositionFactor = [1.05, 1.8, 1.05]
var ballSizeFactor = [0, 4, 4]
var elementSizeFactor = [0, 4, 7]
var noOfLables = [2, 3, 5]
var moveCount = -1
var level = 1
var maxlevel = 4
var sublevel = 1
var numberOfSublevel = 3
var bool = false
var listWin = false
var currentLevel = 0
var numberOfLevel = 4
var items
var noOfBalls = 1

function start(items_) {
    items = items_
    currentLevel = 0
    //initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1
}

function nextLevel() {
    if(numberOfLevel <= ++currentLevel ) {
        currentLevel = 0
    }
    initLevel();
}

function previousLevel() {
    if(--currentLevel < 0) {
        currentLevel = numberOfLevel - 1
    }
    initLevel();
}

function calculateWinPlaces() {
    var winners = [];
    var winnersList = [];
    var min = numberBalls[sublevel - 1][0];
    var max = numberBalls[sublevel - 1][1];
    var period = (min + max);

    for (var x = 0; x < min; x++) {
        winnersList.push((boardSize[sublevel - 1] - 1 - x) % period);
    }

    for (var x = 0; x < (boardSize[sublevel - 1]); x++ ) {
        if (winnersList.indexOf((x + 1) % period) >= 0) {
            winners.push(x);
        }
    }

    var level_win = (level - 1) * min;

    if (level_win == 0) {
        winners = [];
    } else {
        winners = winners.slice(-level_win);
    }

    listWin =  winners;
}

function machinePlay() {

    function accessible(x) {
        if (listWin.indexOf(x + moveCount) >= 0) {
            return true;
        } else {
            return false;
        }
    }

    function randomNumber(minimum, maximum){
        return Math.round( Math.random() * (maximum - minimum) + minimum);
    }

    var playable = [];

    for (var x = numberBalls[sublevel - 1][0]; x < numberBalls[sublevel - 1][1] + 1; x++) {
        if (accessible(x)) {
            playable.push(x);
        }
    }
    if (playable.length != 0) {
        var value = playable[Math.floor(Math.random()*playable.length)];
    } else {
        var value = randomNumber(numberBalls[sublevel - 1][0], numberBalls[sublevel - 1][1]);
    }

    play(false, value);


}

function play(human, value) {

    for ( var x = 0; x < value ; x++) {
        moveCount++;
        if (moveCount <= (boardSize[sublevel - 1] - 1)) {
            if (human == true) {
                items.greenAnswerBallsPlacement.children[moveCount].opacity = 1.0;
            } else {
                items.blueAnswerBallsPlacement.children[moveCount].opacity = 1.0;
            }
        }
        if (moveCount == (boardSize[sublevel - 1] - 1)) {
            reSetup();
            return;
        }
    }
    if (human == true) {
        machinePlay();
    }

}





function reSetup() {


    moveCount = -1;
    sublevel++;
    items.numberOfBalls.text = 1;
    if (sublevel > numberOfSublevel) {
        sublevel = 1;
        level++;
        if (level > maxlevel) {
            level = maxlevel;
            sublevel = 1;
        }
    }

    // Tux refresh
    items.tux.source = "resources/bargame/tux" + level + ".png";
    items.tux.y = items.rootWindow.height - items.rootWindow.height / 1.8;
    items.tux.x = items.rootWindow.width - items.rootWindow.width / tuxPositionFactor[sublevel - 1];

    // Blue sample balls refresh
    items.blueBalls.columns = sampleBallsNo[sublevel - 1];

    // Green sample balls refresh
    items.greenBalls.columns = sampleBallsNo[sublevel - 1];

    // Box setup refresh
    items.boxes.columns = boardSize[sublevel-1];

    // Mask setup refresh
    items.masks.columns = boardSize[sublevel-1];

    // Hiding all visible balls
    items.greenAnswerBallsPlacement.columns = boardSize[sublevel-1]
    items.blueAnswerBallsPlacement.columns = boardSize[sublevel-1]

    // Resetting ball plate



    items.backgroundImage.source = "resources/bargame/school_bg" + level + ".jpg"


}

