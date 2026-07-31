import QtQuick
import QtQuick.Templates as T
import org.hyprland.style.impl

T.Slider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)

    padding: 6

    handle: Rectangle {
        x: control.leftPadding + (control.availableWidth - width) * control.visualPosition
        y: control.topPadding + (control.availableHeight - height) / 2
        implicitWidth: 18
        implicitHeight: 18

        radius: {
            switch (HyprlandStyle.roundness) {
            case 0: return 0;
            case 1: return 4;
            case 2: return 8;
            case 3: return 9;
            }
        }

        border.width: HyprlandStyle.borderWidth

        MotionBehavior on color { ColorAnimation { duration: 60 } }
        color: control.enabled
            ? HyprlandStyle.overlay(control.palette.button, control.palette.highlight, control.pressed ? 0.45 : control.hovered ? 0.30 : 0.15)
            : control.palette.midlight

        MotionBehavior on border.color { ColorAnimation { duration: 60 } }
        border.color: control.enabled
            ? HyprlandStyle.overlay(HyprlandStyle.lightenOrDarken(control.palette.button, 1.4), control.palette.highlight, control.pressed ? 1.0 : control.hovered ? 0.75 : 0.55)
            : control.palette.mid
    }

    background: Item {
        implicitWidth: 200
        implicitHeight: 20

        Rectangle {
            x: control.leftPadding
            y: parent.height / 2 - height / 2
            width: control.availableWidth
            height: 6
            radius: 3
            color: control.enabled ? control.palette.midlight : control.palette.mid
        }

        Rectangle {
            x: control.leftPadding
            y: parent.height / 2 - height / 2
            width: control.visualPosition * control.availableWidth
            height: 6
            radius: 3

            MotionBehavior on color { ColorAnimation { duration: 60 } }
            color: control.enabled ? control.palette.highlight : Qt.alpha(control.palette.highlight, 0.4)
        }
    }
}
