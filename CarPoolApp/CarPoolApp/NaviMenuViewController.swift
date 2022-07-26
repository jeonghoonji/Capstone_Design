//
//  NaviMenuViewController.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/07/01.
//

import UIKit
import NMapsMap
import CoreLocation

class NaviMenuViewController:UIViewController,CLLocationManagerDelegate{
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let naverMapView = NMFMapView(frame: view.frame)
                view.addSubview(naverMapView)
//        naverMapView.showCompass = false
//        naverMapView.showLocationButton = true
        
        locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestWhenInUseAuthorization()
                
                if CLLocationManager.locationServicesEnabled() {
                    print("위치 서비스 On 상태")
                    locationManager.startUpdatingLocation()
                    print(locationManager.location?.coordinate)
                    
                    
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
                                cameraUpdate.animation = .easeIn
                                naverMapView.moveCamera(cameraUpdate)
                } else {
                    print("위치 서비스 Off 상태")
                }

            }
    
}
