//
//  SignInVC.swift
//  Hitch
//
//  Created by Dan Lindsay on 2017-10-24.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import Firebase


class SignUpVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var signUpBtn: RoundedShadowButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: RoundedCornerTextField!
    @IBOutlet weak var passwordTextField: RoundedCornerTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.bindToKeyboard()
        
        segmentControl.setTitleTextAttributes([NSAttributedStringKey.font: fontSize20], for: .normal)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    //MARK: - IBActions
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpBtnWasPressed(_ sender: Any) {
        if emailTextField.text != nil && passwordTextField.text != nil {
            signUpBtn.animateButton(shouldLoad: true, withMessage: nil)
            self.view.endEditing(true)
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        if let errorCode = AuthErrorCode(rawValue: error!._code) {
                            switch errorCode {
                            case .invalidEmail:
                                print("That email is invalid. Please try again.")
                            case .emailAlreadyInUse:
                                print("That email is already in use. Please try again.")
                            default:
                                print("An unknown error occurred. Please try again. Error: \(error.debugDescription)")
                            }
                        }
                    } else {
                        if let user = user {
                            if self.segmentControl.selectedSegmentIndex == 0 {
                                let userData = [DatabaseKeys.provider.rawValue: user.providerID] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                            } else {
                                let userData = [DatabaseKeys.provider.rawValue: user.providerID, DatabaseKeys.userIsDriver.rawValue: true, DatabaseKeys.isPickupModeEnabled.rawValue: false, DatabaseKeys.driverIsOnTrip.rawValue: false] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                            }
                        }
                        print("Successfully created a new user with Firebase")
                        try! Auth.auth().signOut()
                        print("User has been signed out")
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
            
        }
    }
}
