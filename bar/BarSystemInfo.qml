import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import qs
import qs.bar
import qs.widgets

RowLayout {
    id: root

    property int statusItemWidth: 80
    property int statusItemWidthSmall: 40
    property int statusItemHeight: 30

    property PwNode pwNode: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [root.pwNode]
    }

    Timer {
        id: delayTimer
        repeat: false
    }

    function setTimeout(callback, delayTime) {
        delayTimer.interval = delayTime;
        delayTimer.triggered.connect(callback);
        delayTimer.start();
    }

    // audio
    Item {
        implicitWidth: root.statusItemWidth
        implicitHeight: root.statusItemHeight

        PillSlider {
            z: -1

            from: 0
            value: root.pwNode.audio.volume
            to: 1

            onValueChanged: root.pwNode.audio.volume = value
        }

        RowLayout {
            anchors.centerIn: parent

            Text {
                font.family: Consts.fFamilyIcon
                font.pixelSize: Consts.fPxSize
                
                color: Consts.cText
                
                text: "󰕾"
            }

            Text {

                font.family: Consts.fFamily
                font.pixelSize: Consts.fPxSize

                text: `${(root.pwNode.audio.volume * 100).toFixed(0)}%`
                color: Consts.cText
            }
        }

        MouseArea {
            anchors.fill: parent

            acceptedButtons: Qt.RightButton
            onClicked: pavuctlCmd.running = true
        }

        Process {
            id: pavuctlCmd
            command: ["pavucontrol-qt"]
        }
    }

    // internet
    Item {
        implicitWidth: root.statusItemWidth
        implicitHeight: root.statusItemHeight

        PillSlider {
            z: -1

            from: 0
            value: Readings.wifiStrength
            to: 100

            enabled: false
        }

        RowLayout {
            anchors.centerIn: parent

            Text {
                font.family: Consts.fFamilyIcon
                font.pixelSize: Consts.fPxSize
                
                color: Consts.cText

                text: "󰖩"
            }

            Text {
                font.family: Consts.fFamily
                font.pixelSize: Consts.fPxSize

                text: `${Readings.wifiStrength}%`
                color: Consts.cText
            }
        }

        MouseArea {
            anchors.fill: parent

            onClicked: nmtuiCmd.running = true
        }

        Process {
            id: nmtuiCmd
            command: ["hyprctl", "dispatch", "exec", "[float] kitty nmtui connect"]
        }
    }

    // brightness
    Item {
        implicitWidth: root.statusItemWidth
        implicitHeight: root.statusItemHeight

        PillSlider {
            id: brightnessSlider

            z: -1

            from: 0
            value: Readings.brightness
            to: 100

            onValueChanged: () => {
                // with zero delay, this makes the screen flash on quickshell reload
                // and clicking on the slider (instead of dragging) doesn't set
                // brightness properly
                // although... occasionally, even with this delay, the screen (or,
                // well, the backlight) flashes
                root.setTimeout(() => brightnessCmd.running = true, 20);
                brightnessPercentage.text = `${parseInt(brightnessSlider.value)}%`;
            }
        }

        RowLayout {
            anchors.centerIn: parent

            Text {
                font.family: Consts.fFamilyIcon
                font.pixelSize: Consts.fPxSize
                
                color: Consts.cText

                text: "󰃟"
            }

            Text {
                id: brightnessPercentage
                font.family: Consts.fFamily
                font.pixelSize: Consts.fPxSize
                text: `${Readings.brightness}%`
                color: Consts.cText
            }
        }

        Process {
            id: brightnessCmd
            command: ["brightnessctl", "s", `${brightnessSlider.value}%`, "-q"]
        }
    }

    // battery
    Item {
        implicitWidth: root.statusItemWidth
        implicitHeight: root.statusItemHeight

        PillSlider {
            z: -1

            from: 0
            value: UPower.displayDevice.percentage
            to: 1

            enabled: false
        }

        RowLayout {
            anchors.centerIn: parent

            Text {
                font.family: Consts.fFamilyIcon
                font.pixelSize: Consts.fPxSize

                color: Consts.cText

                text: "󰂁"
            }

            Text {
                font.family: Consts.fFamily
                font.pixelSize: Consts.fPxSize

                text: `${(UPower.displayDevice.percentage * 100).toFixed(0)}%`
                color: Consts.cText
            }
        }

        MouseArea {
            anchors.fill: parent

            onClicked: btopCmd.running = true
        }

        Process {
            id: btopCmd
            command: ["hyprctl", "dispatch", "exec", "[float] kitty btop"]
        }
    }
}
