//
//  ContentView.swift
//  Shared
//
//  Created by Stephanie Yung on 4/26/21.
//

import SwiftUI

enum CalcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "*"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self{
        case .add, .subtract, .multiply, .divide, .equal:
//            return .orange
            return (Color(UIColor(red: 56/255.0,green: 149/255.0, blue: 211/255.0, alpha: 1)))
            
        case .clear, .negative, .percent:
//            return Color(.lightGray)
            return (Color(UIColor(red: 211/255.0,green: 211/255.0, blue: 211/255.0, alpha: 1)))
        
        default: //numbers
//            return (Color(UIColor(red: 55/255.0,green: 55/255.0, blue: 55/255.0, alpha: 1)))
            return (Color(UIColor(red: 47/255.0,green: 79/255.0, blue: 79/255.0, alpha: 1)))
        }
        
    }
}

enum Operation{
    case add, subtract, multiply, divide, none
}

enum SingleOperation{
    case negative, percent, decimal, none
}

struct ContentView: View {
    @State var value = "0" //state makes initalize = 0
    
    @State var currentOperation: Operation = .none //current operation
    @State var currentSingleOperation: SingleOperation = .none //current operation
    
//    @ObservedObject var input = value(limit: 5)
    
    @State var runningNumber = 0.0
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
        
    ]
    var body: some View {
        ZStack{
//            .padding(20)
            Color.black.edgesIgnoringSafeArea(.all)
//            ZStack(alignment: .top){
//                Text("This is a test")
//                    .font(.system(size: 70))
//                    .lineLimit(1)
//                    .minimumScaleFactor(0.0001)
//                    .foregroundColor(.white)
//            }
            VStack(spacing: 10){
//                .padding(20)
                
                Text("Basic Calculator")
                    .padding(.top, 25)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
//                    .alignment: .top
                    .font(.system(size: 70))
                    .lineLimit(1)
                    .minimumScaleFactor(0.0001)
                    .foregroundColor(.white)
                Spacer() //push everything to the bottom of stack
                //Text Display
                HStack (spacing: 12){
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 80))
                        .lineLimit(1)
                        .minimumScaleFactor(0.0001)
                        .foregroundColor(.white)
                }
                .padding()
                
                //Buttons
                ForEach(buttons, id: \.self) {row in
                    HStack{
                        ForEach(row, id: \.self) {item in
                            Button(action: {self.didTap(button: item)}, label:{
                                Text(item.rawValue)
                                    .font(.system(size: 40))
                                    .frame(width: self.buttonWidth(item: item)-10, height: self.buttonHeight(item:item) - 20)
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 2)
                }
//                .padding(.bottom,5)
            }
            .padding(.bottom, 35)
//            .padding(0)
        }
    }
    
    var formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 8
        f.numberStyle = .decimal
        return f
    }()
    
    func didTap(button: CalcButton){
        //tap on number
        //tap on operator
        //tap on clear
        switch button {
        case.add, .subtract, .multiply, .divide, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0.0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0.0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0.0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0.0
            }
//            else if button == .negative{
//                self.currentOperation = .negative
//                self.runningNumber = Double(self.value) ?? 0.0
//            }
            else if button == .equal{
                let currentValue = self.runningNumber
                let runningValue = Float(self.value) ?? 0.0
//                let testNum = 8.888
                switch self.currentOperation{
                //update value string
//                case .add: self.value = "\(currentValue + runningValue)"
//                case .subtract: self.value = "\(currentValue - runningValue)"
//                case .multiply: self.value = "\(currentValue * runningValue)"
//                case .divide: self.value = "\(currentValue / runningValue)"
                
                case .add: self.value = "\(Float(currentValue) + Float(runningValue))"
//                case .add: self.value = String(format: "%.14f", currentValue + runningValue)
                case .subtract: self.value = "\(Float(currentValue) - Float(runningValue))"
                case .multiply: self.value = "\(Float(currentValue) * Float(runningValue))"
                case .divide: self.value = "\(Float(currentValue) / Float(runningValue))"
//                case .negative: self.value = "\(Double(currentValue) * -1)"

                
//                case .divide: self.value = String(testNum)
                case .none:
                    break
                }
            }
//            break
            if button != .equal {
                self.value = "0"
            }
        
        case .clear:
            self.value = "0"
            break
        
        case .decimal, .negative, .percent:
            if button == .negative{
                self.currentSingleOperation = .negative
                let currentValue = Float(self.value) ?? 0.0
                self.value = "\(Float(currentValue) * -1)"
//                self.runningNumber = Double(self.value) ?? 0.0
            }
            else if button == .decimal{
                self.currentSingleOperation = .decimal
//                self.runningNumber = Double(self.value) ?? 0.0
                let currentValue = Float(self.value) ?? 0.0
//                self.value = "\(Double(currentValue))"
                self.value = String(format: "%.0f", currentValue) + "."
//                self.runningNumber = Double(self.value) ?? 0.0
            }
            else if button == .percent{
                self.currentSingleOperation = .percent
                let currentValue = Float(self.value) ?? 0.0
                if currentValue < 1.0{
                    self.value = "\(Float(currentValue) * 100)"
                }
                else{
                    self.value = "\(Float(currentValue))"
                }
    
//                self.runningNumber = Double(self.value) ?? 0.0
            }
            
            break
            
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            }
            else{
                self.value = "\(self.value)\(number)" //self value is the new number
            }
            
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero{
            return ((UIScreen.main.bounds.width - (6*12)) / 4) * 2
        }
        //take the whole screen, with its bounds and widths
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight(item: CalcButton) -> CGFloat {
        //take the whole screen, with its bounds and widths
        return (UIScreen.main.bounds.width - (10*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
