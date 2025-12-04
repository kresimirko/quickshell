import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick

Repeater {
    id: tray
    model: SystemTray.items

    Rectangle {
        id: trayIcon

        width: 16
        height: 16
        color: "transparent"

        QsMenuAnchor {
            id: trayIconMenu

            // required property SystemTrayItem modelData

            menu: modelData.menu
            anchor.item: trayIcon
            anchor.gravity: Edges.Top | Edges.Right
        }

        IconImage {
            id: trayIconImage

            // required property SystemTrayItem modelData

            anchors.centerIn: parent
            width: 16
            height: 16
            source: modelData.icon
        }

        MouseArea {
            id: trayIconMouseArea

            // required property SystemTrayItem modelData

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
