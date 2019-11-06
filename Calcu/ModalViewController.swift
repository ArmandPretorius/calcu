//
//  ModalViewController.swift
//  Calcu
//
//  Created by Student on 2019/11/04.
//  Copyright © 2019 Armand Pretorius. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate: class {
    func removeBlurredBackgroundView()
}
class ModalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: ModalViewControllerDelegate?
    let identifier = "LogTableViewCell"
    
    @IBAction func CloseModal(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        delegate?.removeBlurredBackgroundView()
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        view.backgroundColor = UIColor.clear
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let myLog = UserDefaults.standard.array(forKey: "listA") as? [String] {
            return myLog.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let myLog = UserDefaults.standard.array(forKey: "listA") as? [String] {
            
            if let cell = tableview.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? LogTableViewCell {
                
                cell.logLabel.text = myLog[indexPath.item]
                
                return cell
            }
            
//            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! UITableViewCell
//            //set
//            cell.textLabel?.text = myLog[indexPath.item] as? String
//            //style
//            cell.layer.borderWidth = 15
//            cell.layer.borderColor = UIColor.clear.cgColor
//            cell.textLabel?.textColor = .white
//            cell.textLabel?.textAlignment = .center
//            cell.layer.cornerRadius = 20
//
//            let margins: UIEdgeInsets
//
//            margins = UIEdgeInsets(top: 200, left: 100, bottom: 0, right: 100)
//            cell.separatorInset = margins
//            cell.layoutMargins = margins
            
            return UITableViewCell()
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? LogTableViewCell {
                //set
                cell.logLabel.text = "Empty Log"
                return cell
            }
            return UITableViewCell()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.array(forKey: "listA") != nil {
            clearLogButtonOutlet.isHidden = false
        } else {
            clearLogButtonOutlet.isHidden = true
        }
        // Do any additional setup after loading the view.
        
        tableview.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    @IBOutlet weak var clearLogButtonOutlet: UIButton!
    
    @IBAction func ClearLogButton(_ sender: UIButton) {
        if UserDefaults.standard.array(forKey: "listA") != nil {
            clearLogButtonOutlet.isHidden = false
            UserDefaults.standard.removeObject(forKey: "listA")
            CloseModal(clearLogButtonOutlet)
        } else {
            clearLogButtonOutlet.isHidden = true
            //CloseModal(clearLogButtonOutlet)
        }
      
    }
    
    
}
