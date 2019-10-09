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
    override func viewDidLoad() {
        super.viewDidLoad()
        field.placeholder = "Enter Text"
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
        Label.text = field.text
        if let str = field.text{
            detectKeyWord(input: str)
        }
        field.resignFirstResponder()
    }
    
    func detectKeyWord(input:String){
        let functions:[String] = ["(",")","^","!","*","/","+","-"]
        let lower = input.lowercased()
        if lower.contains("change"){
            //means we need to make a change
            colorCheck(lower)
        }
        
        for i in 0...functions.count-1{
            if lower.contains(functions[i]){
                mathDetected(input:lower)
            }
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
    
    func mathDetected(input:String){
        Label.text = input
        if let num = Double("3.14159"){
            print(num + 1)
        }
    }
    
    
    @IBAction func valueChange(_ sender: UISlider) {
        //if let redC = slideBarRed.value, let greenC = slideBarGreen.value, let blueC = slideBarBlue.value{}
        let redC:CGFloat = CGFloat(slideBarRed.value)
        let greenC:CGFloat = CGFloat(slideBarGreen.value)
        let blueC:CGFloat = CGFloat(slideBarBlue.value)
        let alphaC:CGFloat = CGFloat(slideBarAlpha.value)
        Label.backgroundColor = UIColor(red: redC, green: greenC, blue: blueC, alpha: alphaC)
        
    }
    
    func updateHexCode(){
        if let r:Float = slideBarRed?.value{
            if let g:Float = slideBarGreen?.value{
                if let b:Float = slideBarBlue?.value{
                    let numR = Int(r*255)
                    let numG = Int(g*255)
                    let numB = Int(b*255)
                    let strR = convertToHex(num: numR)
                    let strG = convertToHex(num: numG)
                    let strB = convertToHex(num: numB)
                    HexCode.text = "#\(strR)\(strG)\(strB)"
                }
            }
        }
        HexCode.text = "#"
    }
    
    func colorCheck(_ lower:String){
        let colors:[String] = ["red","blue","black","green","purple","white","yellow","orange","magenta"]
        let uColor:[UIColor] = [.red,.blue,.black,.green,.purple,.white,.yellow,.orange,.magenta]
        if lower.contains("color"){
            for c in 0...colors.count-1{
                if lower.contains(colors[c]){
                    Label.backgroundColor = uColor[c]
                    break
                }
            }
        }
    }
    
}

