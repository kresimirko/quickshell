import Quickshell.Wayland
import QtQuick
import qs

Text {
    id: windowTitle

    color: Consts.cText

    font.family: Consts.fFamily
    font.pixelSize: Consts.fPxSize

    text: ToplevelManager.activeToplevel.title
}
