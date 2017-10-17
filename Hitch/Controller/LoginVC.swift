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

        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    
    @IBAction func signUpLoginPressed(_ sender: Any) {
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
