//
//  HomeVC.swift
//  Hitch
//
//  Created by Dan Lindsay on 2017-10-15.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import MapKit
import RevealingSplashView

class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    
    var delegate: CenterVCDelegate?
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width: 150, height: 150), backgroundColor: UIColor.white)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.heartBeat
        revealingSplashView.startAnimation()
        
        revealingSplashView.heartAttack = true
    }
    
    //MARK: - IBActions
    
    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggLeftPanel()
    }
    
}

//MARK: - MapViewDelegate
extension HomeVC: MKMapViewDelegate {
    
}










