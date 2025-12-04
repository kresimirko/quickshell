import Quickshell.Wayland
import QtQuick
import qs

Text {
    id: windowTitle
    color: Colors.text
    text: ToplevelManager.activeToplevel.title
}
