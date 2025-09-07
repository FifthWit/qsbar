import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "../utils" as Utils
import "./" as Blocks

RowLayout {
    anchors.verticalCenter: parent.verticalCenter

    property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    Rectangle {
        id: workspaceBar
        Layout.preferredWidth: 0 + 620
        Layout.preferredHeight: 23
        Layout.fillHeight: true
        radius: 7
        color: "transparent"

        Row {
            anchors.centerIn: parent
            spacing: 10

            Repeater {
                model: 10

                Rectangle {
                    required property int index
                    property bool focused: Hyprland.focusedMonitor?.activeWorkspace?.id === (index + 1)
                    property bool hovered: false
                    property var appTitles: Blocks.Hyprclients.clients
                        .filter(client => client.workspace === (index + 1))
                        .map(client => client.class)
                    
                    width: (String(index) + " " + Utils.IconResolver.resolveIcon(appTitles)).length * 20
                    height: 40
                    radius: 4
                    color: focused ? "#cdd6f4" : "#1e1e2e"

                    Text {
                        id: workspaceText
                        anchors.centerIn: parent
                        text: `${index + 1} ${Utils.IconResolver.resolveIcon(appTitles)}`
                        color: focused ? "#1e1e2e" : (hovered ? "#ff3a75": "white")
                        font.pixelSize: 15
                        font.bold: focused

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: Utils.HyprlandUtils.switchWorkspace(index + 1)
                        onEntered: hovered = true
                        onExited: hovered = false
                    }
                }
            }
        }
    }
}