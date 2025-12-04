import QtQuick
import qs

Text {
    id: clock

    font.family: Consts.fFamily
    font.pixelSize: Consts.fPxSize

    color: Consts.cText

    text: Readings.time
}
