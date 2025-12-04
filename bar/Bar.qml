import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Widgets
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
                    Repeater {
                        id: workspaces
                        model: 5

                        Text {
                            required property int index

                            color: Hyprland.focusedWorkspace.id == index + 1 ? Colors.accent : Colors.text
                            text: index + 1

                            MouseArea {
                                anchors.fill: parent

                                onClicked: Hyprland.dispatch(`workspace ${index + 1}`);
                            }
                        }
                    }

                    // separator
                    Rectangle {
                        color: Colors.border
                        width: 1
                        Layout.fillHeight: true
                    }

                    // window title
                    Text {
                        id: windowTitle
                        color: Colors.text
                        text: ToplevelManager.activeToplevel.title
                    }

                    // spacer
                    Rectangle {
                        Layout.fillWidth: true
                    }

                    // system info
                    BarSystemInfo {}

                    // separator
                    Rectangle {
                        color: Colors.border
                        width: 1
                        Layout.fillHeight: true
                    }

                    // tray
                    Repeater {
                        id: tray
                        model: SystemTray.items

                        Rectangle {
                            id: trayIcon

                            // TODO: make "hitboxes" larger
                            width: 16
                            height: 16
                            color: "transparent"

                            QsMenuAnchor {
                                id: trayIconMenu
                                menu: modelData.menu
                                anchor.item: trayIcon
                                anchor.gravity: Edges.Top | Edges.Right
                            }

                            IconImage {
                                id: trayIconImage
                                anchors.centerIn: parent
                                width: 16
                                height: 16
                                source: modelData.icon
                            }

                            // TODO: add scrolling and tooltips
                            MouseArea {
                                id: trayIconMouseArea
                                width: parent.width
                                height: parent.height
                                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                                onClicked: mouse => {
                                    switch (mouse.button) {
                                    case Qt.LeftButton:
                                        modelData.activate();
                                        break;
                                    case Qt.MiddleButton:
                                        modelData.secondaryActivate();
                                        break;
                                    case Qt.RightButton:
                                        trayIconMenu.anchor.rect.x = mouse.x;
                                        trayIconMenu.anchor.rect.y = mouse.y;
                                        trayIconMenu.open();
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    // separator
                    Rectangle {
                        visible: SystemTray.items.values.length > 0
                        color: Colors.border
                        width: 1
                        Layout.fillHeight: true
                    }

                    Text {
                        id: clock
                        color: Colors.text
                        text: Readings.time
                    }
                }
            }
        }
    }
}
