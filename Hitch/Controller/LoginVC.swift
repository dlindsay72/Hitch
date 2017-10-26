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
        
        segmentControl.setTitleTextAttributes([NSAttributedStringKey.font: fontSize20], for: .normal)

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
        if let signInVC = storyboard.instantiateViewController(withIdentifier: StoryBoardIdentifiers.signUpVC.rawValue) as? SignUpVC {
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
                            if self.segmentControl.selectedSegmentIndex == 0 {
                                let userData = [DatabaseKeys.provider.rawValue: user.providerID] as [String: Any]
                                print("This is the user data if a passenger: \(userData)")
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: false)
                            } else {
                                let userData = [DatabaseKeys.provider.rawValue: user.providerID, DatabaseKeys.userIsDriver.rawValue: true, DatabaseKeys.isPickupModeEnabled.rawValue: false, DatabaseKeys.driverIsOnTrip.rawValue: false] as [String: Any]
                                print("This is the user data if a driver: \(userData)")
                                DataService.instance.createFirebaseDBUser(uid: user.uid, userData: userData, isDriver: true)
                            }
                        }
                        print("Email user authenticated successfully with Firebase")
                        if Auth.auth().currentUser != nil {
                            print("The user is signed in")
                        
                        } else {
                            print("The user did not get signed in")
                        }
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






