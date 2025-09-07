import Quickshell
import Quickshell.Hyprland
import "blocks" as Blocks
import QtQuick

ShellRoot {
    property string activeWindowTitle: ""

    Connections {
        target: Hyprland
        function onRawEvent(ev) {
            if (ev.name === "activewindow") {
                const [, title] = ev.parse(2)
                activeWindowTitle = title ?? ""
            }
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData
            
            anchors { top: true; left: true; right: true }
            implicitHeight: 45
            color: "#181825"

            Blocks.Workspaces {
                id: workspacerow
            }

            Text {
                color: "white"
                id: titleText
                anchors.centerIn: parent
                text: activeWindowTitle
            }

            Blocks.Sidewidgets {
                id: sidewidgets
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}