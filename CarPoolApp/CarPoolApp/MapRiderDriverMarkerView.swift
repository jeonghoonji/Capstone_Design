//
//  MapRiderDriverMarkerView.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/11/14.
//

import Foundation
import UIKit
import NMapsMap
import CoreLocation

class MapRiderDriverMarkerView : UIViewController,CLLocationManagerDelegate {
    

    @IBOutlet weak var mapView: UIView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let naverMapView = NMFMapView(frame: mapView.frame)
        view.addSubview(naverMapView)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print(" MapPolyLineNaviViewController 위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            
            
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            naverMapView.moveCamera(cameraUpdate)
            
            //현재 위치 마커
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.mapView = naverMapView
        }
    }
}
