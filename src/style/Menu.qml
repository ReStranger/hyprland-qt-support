import QtQuick
import QtQuick.Templates as T
import QtQuick.Window
import org.hyprland.style.impl

T.Menu {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    margins: 0
    padding: 6
    overlap: 1

    delegate: MenuItem { }

    contentItem: ListView {
        implicitHeight: contentHeight
        model: control.contentModel
        interactive: Window.window
                     ? contentHeight + control.topPadding + control.bottomPadding > control.height
                     : false
        clip: true
        currentIndex: control.currentIndex

        ScrollIndicator.vertical: ScrollIndicator { }
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40

        radius: {
            switch (HyprlandStyle.roundness) {
            case 0: return 0;
            case 1: return 4;
            case 2: return 8;
            case 3: return 16;
            }
        }

        color: control.palette.window
        border.width: HyprlandStyle.borderWidth
        border.color: HyprlandStyle.lightenOrDarken(control.palette.button, 1.4)
    }

    T.Overlay.modal: Rectangle {
        color: Qt.alpha(control.palette.shadow, 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Qt.alpha(control.palette.shadow, 0.12)
    }
}
