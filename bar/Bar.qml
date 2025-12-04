import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import qs

Scope {
    id: root

    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar

            anchors {
                left: true
                right: true
                bottom: true
            }

            implicitHeight: 41
            color: "transparent"

            // background
            Rectangle {
                color: Colors.base
                width: parent.width
                height: parent.height
                opacity: 0.8
            }

            // border
            Rectangle {
                width: parent.width
                height: 1
                color: Colors.border
            }

            // the actual bar
            Item {
                implicitHeight: 40
                implicitWidth: parent.width
                y: 1

                RowLayout {
                    width: parent.width - 24
                    height: parent.height
                    spacing: 12
                    anchors.centerIn: parent

                    // workspaces
                    BarWorkspaces {}

                    // separator
                    Rectangle {
                        color: Colors.border
                        implicitWidth: 1
                        Layout.fillHeight: true
                    }

                    // window title
                    BarWindowTitle {}

                    // spacer
                    Item {
                        Layout.fillWidth: true
                    }

                    // system info
                    BarSystemInfo {}

                    // separator
                    Rectangle {
                        color: Colors.border
                        implicitWidth: 1
                        Layout.fillHeight: true
                    }

                    // tray
                    BarSystemTray {}

                    // separator
                    Rectangle {
                        visible: SystemTray.items.values.length > 0
                        color: Colors.border
                        implicitWidth: 1
                        Layout.fillHeight: true
                    }

                    // time
                    BarTime {}
                }
            }
        }
    }
}
