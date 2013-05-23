var rotateLeft = "\u2939"
var rotateRight = "\u2935"
var leftArrow = "\u2190"
var division = "\u00f7"
var multiplication = "\u00d7"
var squareRoot = "\u221a"
var plusminus = "\u00b1"

var currentText = "0"
var lastText = ""
// currentOperation

var memory = 0
var lastOp = ""
var timer = 0
var currentOperation = ""

function disabled(op) {
    if (op == "." && currentText.toString().indexOf(".") != -1) {
        return true
    } else if (op == squareRoot &&  currentText.toString().search(/-/) != -1) {
        return true
    } else {
        return false
    }
}

 function doOperation(op) {
     if (disabled(op)) {
         return
     }

    if (op.toString().length==1 && ((op >= "0" && op <= "9") || op==".") ) {
        if (currentText.toString().length >= 14)
            return; // No arbitrary length numbers
        if (currentText == "0" || lastOp == '=')
            currentText = op.toString()
        else
            currentText = currentText + op.toString()
        lastOp = op
        calcwindow.displayOperation = ""
        return
    }
    lastOp = op

    if (op == plusminus) {
        if (Number(currentText.valueOf()) != 0)
            currentText = (currentText.valueOf() * -1).toString()
        else if (currentText == "-")
            currentText = "0"
        else
            currentText = "-"
        return
    }

    if (currentOperation == "+") {
        currentText = calcOpEngine.doCalcOp("+", lastText, currentText)
    } else if (currentOperation == "-") {
        currentText = calcOpEngine.doCalcOp("-", lastText, currentText)
    } else if (currentOperation == multiplication) {
        currentText = calcOpEngine.doCalcOp("*", lastText, currentText)
    } else if (currentOperation == division) {
        currentText = calcOpEngine.doCalcOp("/", lastText, currentText)
    } else if (currentOperation == "=") {
    }

    if (op == "+" || op == "-" || op == multiplication || op == division) {
        calcwindow.displayOperation = op
        currentOperation = op
        lastText = currentText
        currentText = ""
        return
    }

    currentOperation = ""
    calcwindow.displayOperation = ""

    lastText = ""

    if (op == "1/x") {
        currentText = (1 / currentText.valueOf()).toString()
    } else if (op == "x^2") {
        currentText = (currentText.valueOf() *
                currentText.valueOf()).toString()
    } else if (op == "Abs") {
        currentText = (Math.abs(currentText.valueOf())).toString()
    } else if (op == "Int") {
        currentText = (Math.floor(currentText.valueOf())).toString()
    } else if (op == squareRoot) {
        currentText = (Math.sqrt(currentText.valueOf())).toString()
    } else if (op == "mc") {
        memory = 0;
    } else if (op == "m+") {
        memory += currentText.valueOf()
    } else if (op == "mr") {
        currentText = memory.toString()
    } else if (op == "m-") {
        memory = currentText.valueOf()
    } else if (op == leftArrow) {
        currentText = currentText.toString().slice(0, -1)
        if (currentText.length == 0) {
            currentText = "0"
        }
    } else if (op == "Off") {
        Qt.quit();
    } else if (op == "C") {
        currentText = "0"
    } else if (op == "AC") {
        memory = 0
        lastOp = ""
        currentText ="0"
    }
}

