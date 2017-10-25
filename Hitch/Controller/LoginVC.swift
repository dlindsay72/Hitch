//
//  LoginVC.swift
//  Hitch
//
//  Created by Dan Lindsay on 2017-10-16.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var loginBtn: RoundedShadowButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var toSignUpBtn: RoundedShadowButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        segmentControl.setTitleTextAttributes([NSAttributedStringKey.font: FONT], for: .normal)

        view.bindToKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //MARK: - IBActions
    
    @IBAction func toSignUpBtnWasPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let signInVC = storyboard.instantiateViewController(withIdentifier: SIGN_UP_VC) as? SignUpVC {
            present(signInVC, animated: true, completion: nil)
        } 
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if emailTextField.text != nil && passwordTextField.text != nil {
            loginBtn.animateButton(shouldLoad: true, withMessage: nil)
            self.view.endEditing(true)
            
            if let email = emailTextField.text, let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {
                        if let user = user {
                            // start of cut 2
                            if self.segmentControl.selectedSegmentIndex == 0 {
                                let userData = [PROVIDER: user.providerID] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                            } else {
                                let userData = [PROVIDER: user.providerID, USER_IS_DRIVER: true, IS_PICKUP_MODE_ENABLED: false, DRIVER_IS_ON_TRIP: false] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                            }
                        }
                        print("Email user authenticated successfully with Firebase")
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        if let errorCode = AuthErrorCode(rawValue: error!._code) {
                            switch errorCode {
                            case .invalidEmail:
                                print("That is not a valid email. Please try again.")
                            case .wrongPassword:
                                print("That password is incorrect. Please try again.")
                            default:
                                print("Something went wrong. Please try again. Error: \(error.debugDescription)")
                            }
                        }
                        //this is the start of our cut
                    }
                })
            }
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    
}
// cut 1
//                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
//                            if error != nil {
//                                if let errorCode = AuthErrorCode(rawValue: error!._code) {
//                                    switch errorCode {
//                                    case .invalidEmail:
//                                        print("That email is invalid. Please try again.")
//                                    default:
//                                        print("An unknown error occurred. Please try again. Error: \(error.debugDescription)")
//                                    }
//                                }
//                            } else {
//                                if let user = user {
//                                    if self.segmentControl.selectedSegmentIndex == 0 {
//                                        let userData = [PROVIDER: user.providerID] as [String: Any]
//                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
//                                    } else {
//                                        let userData = [PROVIDER: user.providerID, USER_IS_DRIVER: true, IS_PICKUP_MODE_ENABLED: false, DRIVER_IS_ON_TRIP: false] as [String: Any]
//                                        DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
//
//                                    }
//                                }
//                                print("Successfully created a new user with Firebase")
//                                self.dismiss(animated: true, completion: nil)
//                            }
//                        })
// cut 2





