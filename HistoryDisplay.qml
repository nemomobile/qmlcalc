import QtQuick 2.0
import "calculator.js" as CalcEngine

Flickable {
    id: scrollArea
    contentWidth: text.paintedWidth
    contentHeight: text.paintedHeight
    clip: true
    flickableDirection: Flickable.VerticalFlick

    property string historyText: ""
    property string currentText: ""
    property bool hasOperation: false
 
    function updateText() {
        var re = ""
        var hadOperation = hasOperation
        hasOperation = false

        if (calcwindow.displayPrevious != "")
            re = calcwindow.displayPrevious + " "
        if (calcwindow.displayOperation != "") {
            re += "<span style='color:#cd6600'>" + calcwindow.displayOperation + "</span> "
            hasOperation = true
        }

        re += calcwindow.displayText

        if (currentText != "" && calcwindow.displayPrevious == "" && hadOperation) {
            historyText += currentText + "<div align=right><span style='color:#cd6600'>=</span> " + calcwindow.displayText + "</div>"
            currentText = ""
        } else
            currentText = re
    }

    Component.onCompleted: updateText()
    onHeightChanged: scrollArea.contentY = Math.max(0, scrollArea.contentHeight - scrollArea.height)

    TextEdit {
        id: text
        width: scrollArea.width
        height: scrollArea.height

        color: "white"
        font.pixelSize: 40
        readOnly: true

        text: historyText + "<div align=left>" + currentText + "</div>"

        onTextChanged: {
            scrollArea.contentY = Math.max(0, scrollArea.contentHeight - scrollArea.height)
        }
    }

    MouseArea {
        width: scrollArea.width
        height: scrollArea.contentHeight

        onClicked: {
            var pos = text.positionAt(mouse.x, mouse.y)-1

            // TextEdit offers no way to get plain text directly. The text property
            // returns a ton of HTML, but these positions are based on plain text.
            // The only way I can find to get that is through selectedText.
            text.selectAll()
            var str = text.selectedText.toString()
            text.deselect()

            for (; pos >= 0; pos--) {
                if ((str[pos] < '0' || str[pos] > '9') &&
                    str[pos] != '-' && str[pos] != '.')
                    break
            }
            pos++

            var end
            for (end = pos; end < str.length; end++) {
                if ((str[end] < '0' || str[end] > '9') &&
                    str[end] != '-' && str[end] != '.')
                    break
            }
            if (end == pos)
                return

            var word = str.substr(pos, end - pos)
            if (word == '-')
                return

            for (var i = 0; i < word.length; i++) {
                if (word[i] != '-')
                    calcwindow.doOp(word[i])
            }

            if (word[0] == '-')
                calcwindow.doOp(CalcEngine.plusminus)

            // Fake an equals sign after; this ensures that further number input
            // will replace the number instead of appending to it, but operators
            // work as normal.
            calcwindow.doOp('=')
        }
    }
}

