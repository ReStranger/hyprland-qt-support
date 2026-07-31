import QtQuick
import QtQuick.Templates as T
import org.hyprland.style.impl

T.MenuSeparator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 2
    verticalPadding: padding + 4
    horizontalPadding: 6

    contentItem: Rectangle {
        implicitWidth: 188
        implicitHeight: 1
        color: HyprlandStyle.lightenOrDarken(control.palette.button, 1.25)
    }
}
