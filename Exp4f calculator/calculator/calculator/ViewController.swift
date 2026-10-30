import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var firstNumber: Double = 0
    var operation: String = ""
    var typingNewNumber: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func numController(_ sender: UIButton) {
        let number = sender.titleLabel!.text!
        
        if typingNewNumber == true {
            displayLabel.text = number
            typingNewNumber = false
        } else {
            displayLabel.text = displayLabel.text! + number
        }
    }
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        firstNumber = Double(displayLabel.text!)!
        operation = sender.titleLabel!.text!
        typingNewNumber = true
    }
    
    @IBAction func equalsPressed(_ sender: UIButton) {
        let secondNumber = Double(displayLabel.text!)!
        var result: Double = 0
        
        switch operation {
        case "+":
            result = firstNumber+secondNumber
        case "-":
            result = firstNumber-secondNumber
        case "*":
            result = firstNumber*secondNumber
        case "/":
            result = firstNumber / secondNumber
        case "%":
            result = Double(Int(firstNumber) % Int(secondNumber))
        default:
            result = 0
        }
        
        displayLabel.text = String(result)
        typingNewNumber = true
    }
    
        @IBAction func trigButtonPressed(_ sender: UIButton) {
            let currentNumber = Double(displayLabel.text!)!
            let buttonText = sender.titleLabel!.text!.lowercased()
            var result: Double = 0
            let radians = currentNumber * (Double.pi / 180)
            switch buttonText {
            case "sin":
                result = sin(radians)
            case "cos":
                result = cos(radians)
            case "tan":
                result = tan(radians)
            default:
                result = 0
            }
            
            displayLabel.text = String(result)
            typingNewNumber = true
        }
    
    @IBAction func decimal(_ sender:UIButton){
        if typingNewNumber == true {
            displayLabel.text = "0."
            typingNewNumber = false
        }
        else if displayLabel.text!.contains(".") == false {
            displayLabel.text = displayLabel.text! + "."
        }
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        firstNumber = 0
        operation = ""
        displayLabel.text = "0"
        typingNewNumber = true
    }
}
