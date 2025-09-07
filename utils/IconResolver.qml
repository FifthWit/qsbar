pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: iconresolver
    
    
    function resolveIcon(icons: list<string>): string {
        const iconList = {
            "discord": "",
            "org.mozilla.firefox": "",
            "modrinth-app-wrapped": "󰍳",
            "Cider": "",
            "code": "",
            "steam": ""
        }
        
        let result = "";
        for (let i = 0; i < icons.length; i++) {
            if (iconList[icons[i]]) {
                if (result !== "") {
                    result += " ";
                }
                result += iconList[icons[i]];
            }
        }
        if (result === "" && icons.length !== 0) {
            result = "󰼇";
        }
        return result;
    }
}