
var rotateLeft = "\u2939"
var rotateRight = "\u2935"
var leftArrow = "\u2190"
var division = "\u00f7"
var multiplication = "\u00d7"
var squareRoot = "\u221a"
var plusminus = "\u00b1"


var curVal = 0
var memory = 0
var lastOp = ""
var timer = 0
var currentOperation = ""

function disabled(op) {
    if (op == "." && calcwindow.displayText.toString().indexOf(".") != -1) {
        return true
    } else if (op == squareRoot &&  calcwindow.displayText.toString().search(/-/) != -1) {
        return true
    } else {
        return false
    }
}

function doOperation(op) {
    console.log("Called with " + op)
    if (disabled(op)) {
        return
    }

    if (op.toString().length==1 && ((op >= "0" && op <= "9") || op==".") ) {
        if (calcwindow.displayText.toString().length >= 14)
            return; // No arbitrary length numbers
        if (lastOp.toString().length == 1 &&
            ((lastOp >= "0" && lastOp <= "9") ||
             lastOp == ".") ||
             lastOp == leftArrow) {
            if (calcwindow.displayText == "0")
                calcwindow.displayText = op.toString()
            else
               calcwindow.displayText = calcwindow.displayText + op.toString()
        } else {
            calcwindow.displayText = op
        }
        lastOp = op
        calcwindow.displayOperation = ""
        return
    }
    lastOp = op

    if (currentOperation == "+") {
        calcwindow.displayText = Number(calcwindow.displayText.valueOf()) + Number(curVal.valueOf())
    } else if (currentOperation == "-") {
        calcwindow.displayText = Number(curVal) - Number(calcwindow.displayText.valueOf())
    } else if (currentOperation == multiplication) {
        calcwindow.displayText = Number(curVal) * Number(calcwindow.displayText.valueOf())
    } else if (currentOperation == division) {
        calcwindow.displayText = Number(Number(curVal) /
                Number(calcwindow.displayText.valueOf())).toString()
    } else if (currentOperation == "=") {
    }

    if (op == "+" || op == "-" || op == multiplication || op == division) {
        calcwindow.displayOperation = op
        currentOperation = op
        curVal = calcwindow.displayText.valueOf()
        return
    }

    currentOperation = ""
    calcwindow.displayOperation = ""

    curVal = 0

    if (op == "1/x") {
        calcwindow.displayText = (1 / calcwindow.displayText.valueOf()).toString()
    } else if (op == "x^2") {
        calcwindow.displayText = (calcwindow.displayText.valueOf() *
                calcwindow.displayText.valueOf()).toString()
    } else if (op == "Abs") {
        calcwindow.displayText = (Math.abs(calcwindow.displayText.valueOf())).toString()
    } else if (op == "Int") {
        calcwindow.displayText = (Math.floor(calcwindow.displayText.valueOf())).toString()
    } else if (op == plusminus) {
        calcwindow.displayText = (calcwindow.displayText.valueOf() * -1).toString()
    } else if (op == squareRoot) {
        calcwindow.displayText = (Math.sqrt(calcwindow.displayText.valueOf())).toString()
    } else if (op == "mc") {
        memory = 0;
    } else if (op == "m+") {
        memory += calcwindow.displayText.valueOf()
    } else if (op == "mr") {
        calcwindow.displayText = memory.toString()
    } else if (op == "m-") {
        memory = calcwindow.displayText.valueOf()
    } else if (op == leftArrow) {
        calcwindow.displayText = calcwindow.displayText.toString().slice(0, -1)
        if (calcwindow.displayText.length == 0) {
            calcwindow.displayText = "0"
        }
    } else if (op == "Off") {
        Qt.quit();
    } else if (op == "C") {
        calcwindow.displayText = "0"
    } else if (op == "AC") {
        curVal = 0
        memory = 0
        lastOp = ""
        calcwindow.displayText ="0"
    }
}

