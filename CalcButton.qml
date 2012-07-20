/****************************************************************************
 **
 ** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
 ** All rights reserved.
 ** Contact: Nokia Corporation (qt-info@nokia.com)
 **
 ** This file is part of the QtDeclarative module of the Qt Toolkit.
 **
 ** $QT_BEGIN_LICENSE:LGPL$
 ** GNU Lesser General Public License Usage
 ** This file may be used under the terms of the GNU Lesser General Public
 ** License version 2.1 as published by the Free Software Foundation and
 ** appearing in the file LICENSE.LGPL included in the packaging of this
 ** file. Please review the following information to ensure the GNU Lesser
 ** General Public License version 2.1 requirements will be met:
 ** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
 **
 ** In addition, as a special exception, Nokia gives you certain additional
 ** rights. These rights are described in the Nokia Qt LGPL Exception
 ** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
 **
 ** GNU General Public License Usage
 ** Alternatively, this file may be used under the terms of the GNU General
 ** Public License version 3.0 as published by the Free Software Foundation
 ** and appearing in the file LICENSE.GPL included in the packaging of this
 ** file. Please review the following information to ensure the GNU General
 ** Public License version 3.0 requirements will be met:
 ** http://www.gnu.org/copyleft/gpl.html.
 **
 ** Other Usage
 ** Alternatively, this file may be used in accordance with the terms and
 ** conditions contained in a signed written agreement between you and Nokia.
 **
 **
 **
 **
 **
 ** $QT_END_LICENSE$
 **
 ****************************************************************************/

import QtQuick 1.1

Item {
    id: button

    property alias operation: buttonText.text
    property alias color: buttonText.color
    property bool togglable: false

    signal clicked

    Text {
        id: buttonText
        anchors.centerIn: parent; anchors.verticalCenterOffset: -1
        font.pixelSize: parent.width > parent.height ? parent.height * .5 : parent.width * .5
        style: Text.Sunken; color: "white"; styleColor: Qt.lighter(color, 1.2); smooth: true

        Rectangle {
            id: shade
            anchors.centerIn: parent;
            width: (parent.width > parent.height) ? parent.width : parent.height
            height: width
            radius: 20; color: "#63B8FF"; opacity: 0
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            doOp(operation)
            button.clicked()
        }
    }

    states: [
       State {
           name: "pressed"; when: mouseArea.pressed == true
           PropertyChanges { target: shade; opacity: .4 }
           PropertyChanges { target: shade; scale: 1.5 }
           PropertyChanges { target: button; z: 1 }
       },

       State {
           name: "toggled"
           when: calcwindow.displayOperation == button.operation && button.togglable
           PropertyChanges { target: shade; opacity: .6 }
           PropertyChanges { target: shade; scale: 1.8 }
       }
    ]

    transitions: [
        Transition {
            from: ""
            to: "pressed"
            NumberAnimation {
                properties: "z,scale";
                easing.type: Easing.OutExpo;
                duration: 50
            }
            NumberAnimation {
               properties: "opacity";
               easing.type: Easing.OutExpo;
               duration: 100
            }
        },
        Transition {
            from: "pressed"
            to: ""
            NumberAnimation {
               properties: "z,scale";
               easing.type: Easing.OutExpo;
               duration: 200
            }
            NumberAnimation {
               properties: "opacity";
               easing.type: Easing.OutExpo;
               duration: 300
            }
        },
        Transition {
            from: "pressed"
            to: "toggled"
            NumberAnimation {
               properties: "z,scale";
               easing.type: Easing.OutExpo;
               duration: 200
            }
            NumberAnimation {
               properties: "opacity";
               easing.type: Easing.OutExpo;
               duration: 300
            }
        }
    ]
}

