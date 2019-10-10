//
//  ViewController.swift
//  Calcu
//
//  Created by Armand Pretorius on 2019/10/02.
//  Copyright © 2019 Armand Pretorius. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen:Double = 0
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var finalResult: UILabel!
    
    @IBAction func numbers(_ sender: UIButton)
    {
        result.text = result.text! + String(sender.tag-1)
        print(result.text!)
       // numberOnScreen = Double(result.text!)!
    }
    
    
    @IBAction func operations(_ sender: UIButton) {
        
       // result.text = finalResult.text
        
        
        if finalResult.text != "" {
            result.text = finalResult.text
            finalResult.text = ""
        }
        
        if sender.tag == 11 {
            result.text = result.text! + "."
            print(result.text!)
        } else if sender.tag == 12 {
            result.text = result.text! + "+"
            print(result.text!)
        } else if sender.tag == 13 {
            result.text = result.text! + "-"
            print(result.text!)
        } else if sender.tag == 14 {
            result.text = result.text! + "*"
            print(result.text!)
        } else if sender.tag == 15 {
            result.text = result.text! + "/"
            print(result.text!)
        }
        
    }
    
    
    @IBAction func equal(_ sender: UIButton) {
        let expression = NSExpression(format: result.text!)
        guard let mathValue = expression.expressionValue(with: nil, context: nil) as? Double else {return}
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        
        guard let value = formatter.string(from: NSNumber(value: mathValue)) else {return}
        //result.text = ""
        finalResult.text = value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

