pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    // font
    readonly property string fFamily: "Fira Sans"
    readonly property string fFamilyIcon: "Caskaydia Cove NF"
    readonly property string fPxSize: "14"

    // colors
    readonly property string cBase: "#1A1110"
    readonly property string cBorder: "#423736"
    readonly property string cText: "#F1DEDD"
    readonly property string cAccent: "#AC8A8C"
}
