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
import com.nokia.meego 1.0
import "qrc:/js/calculator.js" as CalcEngine

PageStackWindow {
    id: calcwindow

    Component.onCompleted: {
        theme.inverted = true
    }

    function doOp(operation) { CalcEngine.doOperation(operation) }

    property string displayOperation: ""
    property string displayText: "0"

    initialPage: Page {
        orientationLock: PageOrientation.LockPortrait

        Item {
            id: main
            state: "orientation Portrait"
            //+ runtime.orientation

            width: parent.width; height: parent.height; anchors.centerIn: parent

            Column {
                id: box; spacing: 8

                anchors { fill: parent; topMargin: 6; bottomMargin: 6; leftMargin: 6; rightMargin: 6 }

                Display {
                    id: display
                    width: box.width-3
                    height: 150
                }

                Rectangle {
                   height: 1
                   width: grid.width * 0.8
                   color: "#444444"
                   anchors {
                       horizontalCenter: parent.horizontalCenter; verticalCenterOffset: -1
                   }
                }

                // TODO: optimise for landscape layout
                Grid {
                    property real h: ((box.height - (display.height)) / 6) - ((spacing * (6 - 1)) / 6)
                    id: grid; rows: 6; columns: 3; spacing: 6

                    property real w: (box.width / columns) - ((spacing * (columns - 1)) / columns)

                    CalcButton { width: grid.w; height: grid.h; color: '#333333'; operation: "C" }
                    CalcButton { width: grid.w; height: grid.h; operation: CalcEngine.division; togglable: true }
                    CalcButton { width: grid.w; height: grid.h; operation: CalcEngine.multiplication; togglable: true }

                    CalcButton { width: grid.w; height: grid.h; operation: CalcEngine.plusminus }
                    CalcButton { width: grid.w; height: grid.h; operation: "-"; togglable: true }
                    CalcButton { width: grid.w; height: grid.h; operation: "+"; togglable: true }

                    CalcButton { width: grid.w; height: grid.h; operation: "7"; }
                    CalcButton { width: grid.w; height: grid.h; operation: "8"; }
                    CalcButton { width: grid.w; height: grid.h; operation: "9"; }

                    CalcButton { width: grid.w; height: grid.h; operation: "4"; }
                    CalcButton { width: grid.w; height: grid.h; operation: "5"; }
                    CalcButton { width: grid.w; height: grid.h; operation: "6"; }

                    CalcButton { width: grid.w; height: grid.h; operation: "1"; }
                    CalcButton { width: grid.w; height: grid.h; operation: "2"; }
                    CalcButton { width: grid.w; height: grid.h; operation: "3"; }

                    CalcButton { width: grid.w; height: grid.h; operation: "0"; }
                    CalcButton { width: grid.w; height: grid.h; operation: "." }
                    CalcButton { width: grid.w; height: grid.h; operation: "="; color: '#FCB514' }

   /*
   * TODO: fit these into some kind of advanced layout
                    CalcButton { width: grid.w; height: grid.h; operation: CalcEngine.squareRoot }
                    CalcButton { width: grid.w; height: grid.h; operation: "x^2" }
                    CalcButton { width: grid.w; height: grid.h; operation: "1/x" }
                    CalcButton { width: grid.w; height: grid.h; color: 'green'; operation: "mc" }
                    CalcButton { width: grid.w; height: grid.h; color: 'green'; operation: "m+" }
                    CalcButton { width: grid.w; height: grid.h; color: 'green'; operation: "m-" }
                    CalcButton { width: grid.w; height: grid.h; color: 'green'; operation: "mr" }
                    CalcButton { width: grid.w; height: grid.h; color: 'purple'; operation: "Off" }
                    CalcButton { width: grid.w; height: grid.h; color: 'purple'; operation: "AC" }
   */
                }
            }
   /*
            states: [
                State {
                    name: "orientation " + Orientation.Landscape
                    PropertyChanges { target: main; rotation: 90; width:
                    calcwindow.height; height: calcwindow.width }
                },
                State {
                    name: "orientation " + Orientation.PortraitInverted
                    PropertyChanges { target: main; rotation: 180; }
                },
                State {
                    name: "orientation " + Orientation.LandscapeInverted
                    PropertyChanges { target: main; rotation: 270; width:
                    calcwindow.height; height: calcwindow.width }
                }
            ]
   */
            transitions: Transition {
                SequentialAnimation {
                    RotationAnimation { direction: RotationAnimation.Shortest; duration: 300; easing.type: Easing.InOutQuint  }
                    NumberAnimation { properties: "x,y,width,height"; duration: 300; easing.type: Easing.InOutQuint }
                }
            }
        }
    }
}

