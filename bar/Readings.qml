pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // clock
    readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd dd/MM/yyyy, HH:mm");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    // backlight
    readonly property string brightness: {
        `${brightnessNum}%`;
    }
    readonly property int brightnessNum: {
        (brightnessCurrentCmd.value / brightnessMaxCmd.value * 100).toFixed(0);
    }

    Process {
        id: brightnessCurrentCmd
        command: ["brightnessctl", "g"]
        running: true

        property int value

        stdout: StdioCollector {
            // no need for parseInt, Qt seems to do it automatically
            onStreamFinished: brightnessCurrentCmd.value = text
        }
    }

    Process {
        id: brightnessMaxCmd
        command: ["brightnessctl", "m"]
        running: true

        property int value

        stdout: StdioCollector {
            onStreamFinished: brightnessMaxCmd.value = text
        }
    }

    readonly property int hardwareOptimum: -45
    readonly property int hardwareMin: -90

    // wifi
    readonly property string wifiStrength: {
        `${wifiStrengthNum}%`;
    }
    readonly property int wifiStrengthNum: {
        // waybar formula
        (100 - ((Math.abs(wifiStrengthCmd.value - hardwareOptimum) / (hardwareOptimum - hardwareMin)) * 100)).toFixed(0);
    }

    Process {
        id: wifiStrengthCmd
        command: ["awk", "-F", " ", "FNR == 3 {print $4}", "/proc/net/wireless"]
        running: true

        property int value

        stdout: StdioCollector {
            onStreamFinished: wifiStrengthCmd.value = text
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: wifiStrengthCmd.running = true
    }
}
