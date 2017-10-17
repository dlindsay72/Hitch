//
//  LoginVC.swift
//  Hitch
//
//  Created by Dan Lindsay on 2017-10-16.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.bindToKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //MARK: - IBActions
    
    @IBAction func signUpLoginPressed(_ sender: Any) {
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
