import QtQuick
import QtQuick.Templates as T
import org.hyprland.style.impl

T.Switch {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

        text: control.text
        font: control.font
        color: control.enabled ? control.palette.windowText : control.palette.placeholderText
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    indicator: Rectangle {
        implicitWidth: 38
        implicitHeight: 22

        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: Math.floor(control.topPadding + (control.availableHeight - height) / 2)

        radius: height / 2
        border.width: HyprlandStyle.borderWidth

        MotionBehavior on color { ColorAnimation { duration: 60 } }
        color: {
            if (!control.enabled)
                return control.checked ? Qt.alpha(control.palette.highlight, 0.35) : control.palette.mid

            if (!control.checked)
                return control.palette.mid

            let highlightTint = control.down ? 0.95 : control.hovered ? 0.85 : 0.75;
            return HyprlandStyle.overlay(control.palette.button, control.palette.highlight, highlightTint);
        }

        MotionBehavior on border.color { ColorAnimation { duration: 60 } }
        border.color: {
            if (!control.enabled)
                return control.palette.mid

            if (!control.checked)
                return HyprlandStyle.lightenOrDarken(control.palette.button, 1.25)

            return HyprlandStyle.overlay(HyprlandStyle.lightenOrDarken(control.palette.button, 1.4), control.palette.highlight, 1.0);
        }

        Rectangle {
            x: control.visualPosition * (parent.width - width - 4) + 2
            y: 2
            width: parent.height - 4
            height: parent.height - 4
            radius: height / 2

            MotionBehavior on x { SmoothedAnimation { duration: 120 } }
            MotionBehavior on color { ColorAnimation { duration: 60 } }

            border.width: 1
            MotionBehavior on border.color { ColorAnimation { duration: 60 } }

            color: control.enabled ? control.palette.button : control.palette.midlight
            border.color: control.enabled
                ? HyprlandStyle.lightenOrDarken(control.palette.button, 1.2)
                : control.palette.mid
        }

        Rectangle {
            anchors.fill: parent
            anchors.margins: -1
            radius: parent.radius + 1
            color: "transparent"

            MotionBehavior on border.color { ColorAnimation { duration: 60 } }
            border.color: control.visualFocus ? Qt.alpha(control.palette.highlight, 0.8) : "transparent"
        }
    }
}
