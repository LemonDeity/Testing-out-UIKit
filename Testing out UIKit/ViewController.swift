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
        field.resignFirstResponder()
    }
    
    func changeRGBValues(){
        if field.contains("R:" as! UIFocusEnvironment){
            let rIndex = field.text?.firstIndex(of: "R")!
            
            
        }else{
            field.text = "Cannot Locate Red Value"
        }
        
        if field.contains("G:" as! UIFocusEnvironment){
            let gIndex = field.text?.range(of: "G:")
        }else{
            field.text = "Cannot Locate Green Value"
        }
        
        if field.contains("B:" as! UIFocusEnvironment){
            let bIndex = field.text?.range(of: "B:")
        }else{
            field.text = "Cannot Locate Blue Value"
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

