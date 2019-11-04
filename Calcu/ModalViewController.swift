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
        if let myLog = UserDefaults.standard.array(forKey: "listA"){
            return myLog.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let myLog = UserDefaults.standard.array(forKey: "listA"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! UITableViewCell
            cell.textLabel?.text = myLog[indexPath.item] as? String
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! UITableViewCell
            cell.textLabel?.text = "Empty Log"
            return cell
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
