import QtQuick
import QtQuick.Templates as T
import org.hyprland.style.impl

// This is private and we shouldn't use it, however rewriting IconLabel and ColorImage would take
// unnecessary low-level work for this module.
import QtQuick.Controls.impl as ControlsPrivate

T.MenuItem {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    icon.width: 16
    icon.height: 16
    icon.color: control.palette.windowText

    contentItem: ControlsPrivate.IconLabel {
        readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
        readonly property real indicatorPadding: control.checkable && control.indicator ? control.indicator.width + control.spacing : 0
        leftPadding: !control.mirrored ? indicatorPadding : arrowPadding
        rightPadding: control.mirrored ? indicatorPadding : arrowPadding

        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: Qt.AlignLeft

        icon: control.icon
        text: control.text
        font: control.font
        color: control.enabled ? control.palette.windowText : control.palette.placeholderText
    }

    indicator: Item {
        implicitWidth: 16
        implicitHeight: 16

        x: control.mirrored ? control.width - width - control.rightPadding : control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        visible: control.checkable

        CheckDelegate {
            anchors.fill: parent
            checkState: control.checked ? Qt.Checked : Qt.Unchecked
            color: control.enabled ? control.palette.windowText : control.palette.placeholderText
            visible: control.checked
        }
    }

    arrow: Text {
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2

        visible: control.subMenu
        text: control.mirrored ? "<" : ">"
        font: control.font
        color: control.enabled ? control.palette.windowText : control.palette.placeholderText
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 32

        radius: {
            switch (HyprlandStyle.roundness) {
            case 0: return 0;
            case 1: return 4;
            case 2: return 6;
            case 3: return 8;
            }
        }

        MotionBehavior on color { ColorAnimation { duration: 60 } }
        color: {
            let highlightTint = control.down ? 0.30 : control.highlighted ? 0.22 : 0.0;
            return HyprlandStyle.overlay(control.palette.window, control.palette.highlight, highlightTint);
        }

        MotionBehavior on border.color { ColorAnimation { duration: 60 } }
        border.width: control.highlighted ? 1 : 0
        border.color: Qt.alpha(control.palette.highlight, 0.5)
    }
}
