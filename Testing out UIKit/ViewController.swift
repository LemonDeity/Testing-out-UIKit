//
//  ViewController.swift
//  Testing out UIKit
//
//  Created by Range, Noah H on 10/1/19.
//  Copyright © 2019 Range, Noah H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var slideBarRed: UISlider!
    @IBOutlet weak var slideBarGreen: UISlider!
    @IBOutlet weak var slideBarBlue: UISlider!
    @IBOutlet weak var slideBarAlpha: UISlider!
    @IBOutlet weak var HexCode: UILabel!
    @IBOutlet weak var rValue: UILabel!
    @IBOutlet weak var gValue: UILabel!
    @IBOutlet weak var bValue: UILabel!
    @IBOutlet weak var alphaValue: UILabel!
    @IBOutlet weak var Mode: UISwitch!
    //on means RGB off means Hex
    override func viewDidLoad() {
        super.viewDidLoad()
        field.placeholder = "R:___ G:___ B:___"
        slideBarRed.maximumValue = 1.0
        slideBarBlue.maximumValue = 1.0
        slideBarGreen.maximumValue = 1.0
        slideBarGreen.minimumValue = 0
        slideBarBlue.minimumValue = 0
        slideBarRed.minimumValue = 0
        slideBarAlpha.maximumValue = 1.0
        slideBarAlpha.minimumValue = 0
        slideBarRed.value = 1.0
        slideBarGreen.value = 1.0
        slideBarBlue.value = 1.0
        slideBarAlpha.value = 1.0
        slideBarRed.tintColor = .red
        slideBarBlue.tintColor = .blue
        slideBarGreen.tintColor = .green
        
        print(slideBarRed.value)
    }

   
    @IBAction func ReturnKeyTapped(_ sender: UITextField) {
        //rgb format will be R:___ G:___ B:___
        if Mode.isOn{
            changeRGBValues()
        }else{
            changeHexValue()
        }
        field.resignFirstResponder()
    }
    
    func changeHexValue(){
        var redF = false, greenF = false, blueF = false,alphaF = false
        var newRValue:Float = 0
        var newGValue:Float = 0
        var newBValue:Float = 0
        var newAValue:Float = 0
        if let input = field.text{
            if input[input.startIndex]=="#"&&input.count==9{
                newRValue = letterToNumber(str: input, index: 1)
                newGValue = letterToNumber(str: input, index: 3)
                newBValue = letterToNumber(str: input, index: 5)
                newAValue = letterToNumber(str: input, index: 7)
            }else{
                redF.toggle()
                greenF.toggle()
                blueF.toggle()
                alphaF.toggle()
                print("Something isn't right")
            }
        }
        
        if redF||greenF||blueF{
            var errorMessage = "ERROR-Cannot find "
            if redF{
                errorMessage += "Red "
            }
            
            if greenF{
                errorMessage += "Green "
            }
            
            if blueF{
                errorMessage += "Blue "
            }
            
            if alphaF{
                errorMessage += "Alpha"
            }
            print(errorMessage)
        }else{
            slideBarRed.value = newRValue
            slideBarGreen.value = newGValue
            slideBarBlue.value = newBValue
            slideBarAlpha.value = newAValue
            valueChange(slideBarBlue)
        }
    }
    
    func changeRGBValues(){
        var redF = false, greenF = false, blueF = false
        var newRValue:Float = 0
        var newGValue:Float = 0
        var newBValue:Float = 0
        if let input = field.text{
            
            if input.contains("R:"){
                //offsetBy start = 2
                newRValue = updateFromKeyboard(input: input, offsetStart: 2)
            }else{
                redF.toggle()
            }
            
            if input.contains("G:"){
                //offsetStart = 8
                newGValue = updateFromKeyboard(input: input, offsetStart: 8)
            }else{
                greenF.toggle()
            }
            
            if input.contains("B:"){
                //offsetStart = 14
                newBValue = updateFromKeyboard(input: input, offsetStart: 14)
            }else{
                blueF.toggle()
            }
        }
        if redF||greenF||blueF{
            var errorMessage = "ERROR-Cannot find "
            if redF{
                errorMessage += "Red "
            }
            
            if greenF{
                errorMessage += "Green "
            }
            
            if blueF{
                errorMessage += "Blue"
            }
            print(errorMessage)
        }else{
            slideBarRed.value = newRValue
            slideBarGreen.value = newGValue
            slideBarBlue.value = newBValue
            valueChange(slideBarBlue)
        }
    }
    
    func convertToHex(num : Int) -> String{
        let index1:Int = num/16
        let index2:Int = (num%16)
        let str1 = numberToLetter(num: index1)
        let str2 = numberToLetter(num: index2)
        return str1+str2
    }
    
    private func numberToLetter(num : Int) -> String{
        switch(num){
        case 10:
            return "A"
        case 11:
            return "B"
        case 12:
            return "C"
        case 13:
            return "D"
        case 14:
            return "E"
        case 15:
            return "F"
        default:
            return String(num)
        }
    }
    
    private func letterToNumber(str: String, index:Int) -> Float{
        //the String will be in the form __ FF -> 255 AF -> 175
        let index1 = str.index(str.startIndex, offsetBy: index)
        let index2 = str.index(str.startIndex, offsetBy: index+1)
        let string1 = String(str[index1])
        let string2 = String(str[index2])
        
        func cases(strg: String) -> Int{
            switch(strg){
            case "A":
                return 10
            case "B":
                return 11
            case "C":
                return 12
            case "D":
                return 13
            case "E":
                return 14
            case "F":
                return 15
            default:
                return Int(strg)!
            }
        }
        
        let num1 = cases(strg: string1)
        let num2 = cases(strg: string2)
        let sum = Double((num1*16)+num2)
        return Float(sum/255.0)
    }
    
    func updateFromKeyboard(input: String, offsetStart : Int) -> Float{
        var newValue:Float = 0
        let index1 = input.index(input.startIndex, offsetBy: offsetStart)
        let index2 = input.index(input.startIndex, offsetBy: offsetStart+1)
        let index3 = input.index(input.startIndex, offsetBy: offsetStart+2)
        if let one = Int(String(input[index1])){
            if let two = Int(String(input[index2])){
                if let thr = Int(String(input[index3])){
                    let total = Double((100*one)+(10*two)+thr)
                    newValue = Float(total/255.0)
                }
            }
        }
        return newValue
    }
    
    @IBAction func valueChange(_ sender: UISlider) {
        //if let redC = slideBarRed.value, let greenC = slideBarGreen.value, let blueC = slideBarBlue.value{}
        let redC:CGFloat = CGFloat(slideBarRed.value)
        let greenC:CGFloat = CGFloat(slideBarGreen.value)
        let blueC:CGFloat = CGFloat(slideBarBlue.value)
        let alphaC:CGFloat = CGFloat(slideBarAlpha.value)
        Label.backgroundColor = UIColor(red: redC, green: greenC, blue: blueC, alpha: alphaC)
        updateHexCode()
        
    }
    
    @IBAction func modeChanged(_ sender: UISwitch) {
        if Mode.isOn{
            field.placeholder = "R:___ G:___ B:___"
        }else{
            field.placeholder = "#FFFFFF"
        }
    }
    
    @IBAction func exitKeyboard(_ sender: UIGestureRecognizer) {
        field.resignFirstResponder()
    }
    
    func updateHexCode(){
        if let r:Float = slideBarRed?.value{
            if let g:Float = slideBarGreen?.value{
                if let b:Float = slideBarBlue?.value{
                    if let alpha:Float = slideBarAlpha?.value{
                        let numR = Int(r*255)
                        let numG = Int(g*255)
                        let numB = Int(b*255)
                        let numA = Int(alpha*255)
                        let strR = convertToHex(num: numR)
                        let strG = convertToHex(num: numG)
                        let strB = convertToHex(num: numB)
                        let strA = convertToHex(num: numA)
                        print("Red : \(strR)")
                        print("Green : \(strG)")
                        print("Blue : \(strB)")
                        HexCode.text = "#\(strR)\(strG)\(strB)\(strA)"
                        rValue.text = "R : \(numR)"
                        gValue.text = "G : \(numG)"
                        bValue.text = "B : \(numB)"
                        alphaValue.text = "Alpha: \(numA)"
                    }
                }
            }
        }
    }
    
}

