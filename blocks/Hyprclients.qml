pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    property var clients: []

    Process {
        id: clientsProc
        command: ["/home/admin/Projects/qsbar/sh/hyprclients.sh"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                try {
                    clients = JSON.parse(data.trim());
                } catch (e) {
                    console.error("Failed to parse clients JSON:", e);
                    clients = [];
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clientsProc.running = true
    }
}

