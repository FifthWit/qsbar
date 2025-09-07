import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "./"

RowLayout {
    Rectangle {
        id: date
        Layout.preferredWidth: 130
        Layout.preferredHeight: 40
        color: "#f7a6d1"
        radius: 5

        Text {
            anchors.centerIn: parent
                text: ` ${Datetime.date}`
            color: "#413955"
            font.pixelSize: 15
        }
    }

    Rectangle {
        id: time
        Layout.preferredWidth: 100
        Layout.preferredHeight: 40
        color: "#cba6f7"
        radius: 5

        Text {
            anchors.centerIn: parent
            text: ` ${Datetime.time}`
            color: "#413955"
            font.pixelSize: 15
        }
    }

    Rectangle {
        id: audio
        Layout.preferredWidth: 40
        Layout.preferredHeight: 40
        color: "#f2cdcd"
        radius: 5

        Text {
            anchors.centerIn: parent
            text: ""
            color: "#5f525c"
            font.pixelSize: 20
        }

        Process {
            id: pulseaudio
            command: ["sh", "-c", "pavucontrol"]
            running: false
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                pulseaudio.running = true
            }
        }
    }

    Rectangle {
        id: power
        Layout.preferredWidth: 40
        Layout.preferredHeight: 40
        color: "#f2cdcd"
        radius: 5

        Text {
            anchors.centerIn: parent
            text: "⏻"
            color: "#5f525c"
            font.pixelSize: 20
        }

        Process {
            id: logout
            command: ["sh", "-c", "wlogout"]
            running: false
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                logout.running = true
            }
        }
    }
}