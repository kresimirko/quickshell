pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Slider {
    id: slider

    anchors.fill: parent

    background: Rectangle {
        id: sliderBg
        color: '#20ffffff'

        // https://evileg.com/en/post/577/
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: sliderBg.width
                height: sliderBg.height
                Rectangle {
                    anchors.centerIn: parent
                    width: sliderBg.width
                    height: sliderBg.height
                    radius: 12
                }
            }
        }

        Rectangle {
            width: slider.visualPosition * parent.width
            height: parent.height
            color: "#40ffffff"
        }
    }
}