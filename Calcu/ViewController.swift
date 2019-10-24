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
    
    var log: [Any] = []
    
    
    //labels
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var finalResult: UILabel!
    
    //tip buttons
    
    @IBOutlet weak var tipTen: UIButton!
    @IBOutlet weak var tipFifteen: UIButton!
    @IBOutlet weak var tipTwenty: UIButton!
    
    @IBOutlet weak var tipButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tipButtonClicked(_ sender: UIButton) {
        
        if equalButton.isHidden == false {
            equalButton.isHidden = true
            tipTen.isHidden = false
            tipFifteen.isHidden = false
            tipTwenty.isHidden = false
        } else {
            equalButton.isHidden = false
            tipTen.isHidden = true
            tipFifteen.isHidden = true
            tipTwenty.isHidden = true
        }
        
    }
    
    @IBAction func numbers(_ sender: UIButton)
    {
        
        if finalResult.text != "" {
            result.text = ""
            finalResult.text = ""
        }
        
        result.text = result.text! + String(sender.tag-1)
        print(result.text!)
       // numberOnScreen = Double(result.text!)!
        
        UserDefaults.standard.array(forKey: "listA")
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
        
        //log = UserDefaults.standard.array(forKey: "listA")!
        log.append(result.text! + "=" + value)
        
       // print(log)
        UserDefaults.standard.set(log, forKey: "listA")
       // var listA = UserDefaults.standard.array(forKey: "listA")
        
        if let list = UserDefaults.standard.array(forKey: "listA") {
            print("List: \(list)")
        }
        
    }
    
    
    @IBAction func tipCalculation(_ sender: UIButton) {
        if finalResult.text != "" {
            result.text = finalResult.text
            finalResult.text = ""
        }
        
        if sender.tag == 16 {
            result.text = result.text! + "*10/100"
            print(result.text!)
        } else if sender.tag == 17 {
            result.text = result.text! + "*15/100"
            print(result.text!)
        } else if sender.tag == 18 {
            result.text = result.text! + "*20/100"
            print(result.text!)
        }
        equalButton.isHidden = false
        tipTen.isHidden = true
        tipFifteen.isHidden = true
        tipTwenty.isHidden = true
        
        equal(equalButton)
    }
    
    
    @IBAction func ViewLog(_ sender: UIButton) {
        print("Log Clicked")
        if let list = UserDefaults.standard.array(forKey: "listA") {
            print("List: \(list)")
        }
    }
    



}

