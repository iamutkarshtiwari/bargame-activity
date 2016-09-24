import QtQuick 2.6
import QtQuick.Window 2.0

Item {


    Image {
        id : cases
        source: "resources/bargame/case.png"
        height: Screen.height / 10
        width: Screen.width / 10
    }

//    MouseArea {
//        anchors.fill: blueRec
//        id: blueRecMouseArea
//        hoverEnabled: button.hoverEnabled
//        onEntered: {
//            blueRec.color = 'Red'

//        }
//        onExited: {
//            blueRec.color = "Blue"
//        }

//        onClicked: {
//            //console.log("hello from qml")
//            buttonClicked()
//            //Qt.quit();
//        }
//    }

//    Text {
//        text: qsTr("This is the Bargame ")
//        anchors.centerIn: parent
//    }

}


 Image {
        id: blueBall
        source: "resources/bargame/blue_ball.png"

        width: Screen.width / 10
        height: Screen.height / 10
    }



