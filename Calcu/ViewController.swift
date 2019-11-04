//
//  ViewController.swift
//  Calcu
//
//  Created by Armand Pretorius on 2019/10/02.
//  Copyright © 2019 Armand Pretorius. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ModalViewControllerDelegate {
    
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
    
    //memory button
    
    @IBOutlet weak var memorySaveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // tipButton.layer.borderColor
        tipButton.layer.borderWidth = 1
        
        if let memoryValue = UserDefaults.standard.string(forKey: "memory"){
            memorySaveButton.setTitle(memoryValue, for: .normal)
        }
        
    }
    
    @IBAction func memoryFunctions(_ sender: UIButton) {
        
        if sender.tag == 19 {
            //Memory Save and Recall
            
            if let memoryValue = UserDefaults.standard.string(forKey: "memory") {
                // Has value in userdefaults
                
                if finalResult.text != ""  {
                    if result.text != "" {
                        let memory = finalResult.text
                        UserDefaults.standard.set(memory, forKey: "memory")
                        memorySaveButton.setTitle(memory, for: .normal)
                        finalResult.text = ""
                        result.text = ""
                    }
                } else {
                    finalResult.text = ""
                    result.text = result.text! + memoryValue
                }
                
            } else {
                // No value
                if finalResult.text != "" {
                    let memory = finalResult.text
                    UserDefaults.standard.set(memory, forKey: "memory")
                    memorySaveButton.setTitle(memory, for: .normal)
                    finalResult.text = ""
                    result.text = ""
                }
               
            }
        } else if sender.tag == 20 {
            //Memory Clear
            
            memorySaveButton.setTitle("m", for: .normal)
            UserDefaults.standard.removeObject(forKey: "memory")
            //finalResult.text = ""
            
        }
        else if sender.tag == 21 {
            //M+ Add to Memory

            if finalResult.text != "" {
                let addMemory = UserDefaults.standard.string(forKey: "memory")! + "+" + finalResult.text!
                
                let expression = NSExpression(format: addMemory)
                guard let mathValue = expression.expressionValue(with: nil, context: nil) as? Double else {return}
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 6
                
                guard let value = formatter.string(from: NSNumber(value: mathValue)) else {return}
                
                UserDefaults.standard.set(value, forKey: "memory")
                memorySaveButton.setTitle(value, for: .normal)
                finalResult.text = ""
                result.text = ""
            }
           

        } else if sender.tag == 22 {
//            //M- Minus from Memory

            if finalResult.text != "" {
                let minusMemory = UserDefaults.standard.string(forKey: "memory")! + "-" + finalResult.text!
                
                let expression = NSExpression(format: minusMemory)
                guard let mathValue = expression.expressionValue(with: nil, context: nil) as? Double else {return}
                
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 6
                
                guard let value = formatter.string(from: NSNumber(value: mathValue)) else {return}
                
                UserDefaults.standard.set(value, forKey: "memory")
                memorySaveButton.setTitle(value, for: .normal)
                finalResult.text = ""
                result.text = ""
            }
        }
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
        
        equal(equalButton)
        
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
        
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        
        self.overlayBlurredBackgroundView()
        
    }
    
    
    //MODAL BLUR FUNCTIONS
    func overlayBlurredBackgroundView() {
        
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        
        view.addSubview(blurredBackgroundView)
        
    }
    
    func removeBlurredBackgroundView() {
        
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "ShowModalView" {
                if let viewController = segue.destination as? ModalViewController {
                    viewController.delegate = self
                    viewController.modalPresentationStyle = .overFullScreen
                }
            }
        }
    }
    



}

