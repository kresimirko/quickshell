import qs
import QtQuick
import QtQuick.Controls

Button {
    id: root

    padding: 6

    contentItem: Text {
        text: root.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Consts.cText
    }

    background: Rectangle {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        color: "white"
        opacity: root.down ? 0.1 : (root.hovered ? 0.2 : 0.1)
        radius: 12
    }
}
