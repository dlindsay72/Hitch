//
//  LeftSidePanelVC.swift
//  Hitch
//
//  Created by Dan Lindsay on 2017-10-15.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var pickupModeLbl: UILabel!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var accountTypeLbl: UILabel!
    @IBOutlet weak var signUpLoginBtn: UIButton!
    
    //MARK: - Properties
    
    let currentUserId = Auth.auth().currentUser?.uid
    let appDelgate = AppDelegate.getAppDelegate()
    
    //MARK: - viewDidLoad and viewWillAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pickupModeSwitch.isOn = false
        pickupModeLbl.isHidden = true
        pickupModeSwitch.isHidden = true
        
        observePassengersAndDrivers()
        
        if Auth.auth().currentUser == nil {
            clearLabelsAndImageViews()
        } else {
            userEmailLbl.text = Auth.auth().currentUser?.email
            self.userImageView.isHidden = false
            signUpLoginBtn.setTitle("Logout", for: .normal)
            
        }
    }
    
    //MARK: - Methods

    func observePassengersAndDrivers() {
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let currentUserID = Auth.auth().currentUser?.uid {
                        if snap.key == currentUserID {
                            self.accountTypeLbl.text = "DRIVER"
                            self.pickupModeLbl.isHidden = false
                            self.pickupModeLbl.text = "PICKUP MODE DISABLED"
                            self.pickupModeSwitch.isHidden = false
                            let switchStatus = snap.childSnapshot(forPath: DatabaseKeys.isPickupModeEnabled.rawValue).value as! Bool
                            self.pickupModeSwitch.isOn = switchStatus
                            print("This is what shows up in REF_DRIVERS observer: \(String(describing: Auth.auth().currentUser!.uid))")
                        }
                    }
                    
                }
            }
        }
        DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.accountTypeLbl.text = "PASSENGER"
                        self.userImageView.isHidden = false
                        print("This is what shows up in REF_USER observer: \(String(describing: Auth.auth().currentUser!.uid))")
                    }
                }
            }
        }
        
    }
    
    func clearLabelsAndImageViews() {
        userEmailLbl.text = ""
        accountTypeLbl.text = ""
        pickupModeSwitch.isHidden = true
        pickupModeLbl.text = ""
        userImageView.isHidden = true
        signUpLoginBtn.setTitle("Login", for: .normal)
    }
    
    //MARK: - IBActions
    
    @IBAction func pickupModeSwitchToggled(_ sender: Any) {
        if pickupModeSwitch.isOn {
            pickupModeLbl.text = "PICKUP MODE ENABLED"
            appDelgate.MenuContainerVC.toggLeftPanel()
            if let currentUser = currentUserId {
                DataService.instance.REF_DRIVERS.child(currentUser).updateChildValues([DatabaseKeys.isPickupModeEnabled.rawValue: true])
            }
        } else {
            pickupModeLbl.text = "PICKUP MODE DISABLED"
            appDelgate.MenuContainerVC.toggLeftPanel()
            if let currentUser = currentUserId {
                DataService.instance.REF_DRIVERS.child(currentUser).updateChildValues([DatabaseKeys.isPickupModeEnabled.rawValue: false])
            }
        }
    }
    
    
    @IBAction func signUpLoginPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: StoryBoardIdentifiers.loginVC.rawValue) as? LoginVC {
                present(loginVC, animated: true, completion: nil)
            }
        } else {
            do {
                try Auth.auth().signOut()
                clearLabelsAndImageViews()
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
}










