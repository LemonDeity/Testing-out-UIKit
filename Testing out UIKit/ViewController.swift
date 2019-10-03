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
    override func viewDidLoad() {
        super.viewDidLoad()
        field.placeholder = "Enter Text"
    }

   
    @IBAction func ReturnKeyTapped(_ sender: UITextField) {
        Label.text = field.text
        if let str = field.text{
            detectKeyWord(input: str)
        }
        field.resignFirstResponder()
    }
    
    func detectKeyWord(input:String){
        let lower = input.lowercased()
        if lower.contains("change"){
            //means we need to make a change
            colorCheck(lower)
        }
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

