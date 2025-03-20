import SwiftUI

struct ContentView: View {
    @State private var currentInput = "0"
    @State private var previousInput = ""
    @State private var currentOperation: String? = nil
    
    var body: some View {
        VStack {
            // Display screen
            Text(currentInput)
                .font(.system(size: 64))
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.black.opacity(0.8))
                .foregroundColor(.white)
            
            // Calculator Buttons
            let buttons = [
                ["7", "8", "9", "/"],
                ["4", "5", "6", "*"],
                ["1", "2", "3", "-"],
                ["0", ".", "=", "+"]
            ]
            
            ForEach(0..<buttons.count, id: \.self) { row in
                HStack(spacing: 20) {
                    ForEach(buttons[row], id: \.self) { button in
                        Button(action: { self.buttonPressed(button) }) {
                            Text(button)
                                .font(.system(size: 32))
                                .frame(width: 80, height: 80)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(40)
                        }
                    }
                }
                .padding(.bottom, 10)
            }
        }
        .padding()
    }
    
    func buttonPressed(_ button: String) {
        switch button {
        case "=":
            calculateResult()
        case "/", "*", "-", "+":
            performOperation(button)
        default:
            updateInput(button)
        }
    }
    
    func updateInput(_ input: String) {
        if currentInput == "0" {
            currentInput = input
        } else {
            currentInput += input
        }
    }
    
    func performOperation(_ operation: String) {
        previousInput = currentInput
        currentInput = "0"
        currentOperation = operation
    }
    
    func calculateResult() {
        guard let operation = currentOperation else { return }
        
        let num1 = Double(previousInput) ?? 0
        let num2 = Double(currentInput) ?? 0
        var result: Double = 0
        
        switch operation {
        case "+":
            result = num1 + num2
        case "-":
            result = num1 - num2
        case "*":
            result = num1 * num2
        case "/":
            if num2 != 0 {
                result = num1 / num2
            } else {
                result = 0
            }
        default:
            break
        }
        
        currentInput = String(result)
        currentOperation = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
