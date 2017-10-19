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
import CoreLocation

class HomeVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    
    //MARK: - Properties
    
    var delegate: CenterVCDelegate?
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width: 150, height: 150), backgroundColor: UIColor.white)
    var locationManager: CLLocationManager?
    var regionRadius: CLLocationDistance = 1000
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        checkLocationAuthStatus()
        centerMapOnUserLocation()
        
        mapView.delegate = self
        
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.heartBeat
        revealingSplashView.startAnimation()
        
        revealingSplashView.heartAttack = true
    }
    
    func checkLocationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager?.stopUpdatingLocation()
        } else {
            locationManager?.requestAlwaysAuthorization()
        }
    }
    
    func centerMapOnUserLocation() {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //MARK: - IBActions
    
    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggLeftPanel()
    }
    
    @IBAction func centerMapBtnWaPressed(_ sender: Any) {
        centerMapOnUserLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension HomeVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
    
    
}

//MARK: - MapViewDelegate
extension HomeVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        UpdateService.instance.updateUserLocation(withCoordinate: userLocation.coordinate)
        UpdateService.instance.updateDriverLocation(withCoordinate: userLocation.coordinate)
    }
}










