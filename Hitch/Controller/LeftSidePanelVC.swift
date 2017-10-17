//
//  LeftSidePanelVC.swift
//  Hitch
//
//  Created by Dan Lindsay on 2017-10-15.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class LeftSidePanelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpLoginPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: LOGIN_VC) as? LoginVC {
            present(loginVC, animated: true, completion: nil)
        }
        
    }
    
    

}
