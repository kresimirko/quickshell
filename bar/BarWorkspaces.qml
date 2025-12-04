import Quickshell.Hyprland
import QtQuick
import qs

Repeater {
    id: workspaces
    model: 5

    Text {
        id: workspaceLabel

        required property int index

        color: Hyprland.focusedWorkspace.id == index + 1 ? Colors.accent : Colors.text
        text: index + 1

        MouseArea {
            anchors.fill: parent

            onClicked: Hyprland.dispatch(`workspace ${workspaceLabel.index + 1}`)
        }
    }
}
