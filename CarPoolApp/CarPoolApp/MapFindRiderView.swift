//
//  MapFindRiderView.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/11/14.
//


import Foundation
import UIKit
import NMapsMap
import SwiftyJSON
import Alamofire
import CoreLocation
import KakaoSDKNavi
import FirebaseDatabase
import MapKit



class MapFindRiderView : UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let naverMapView = NMFMapView(frame: mapView.frame)
        view.addSubview(naverMapView)
        
        
        let marker1 = NMFMarker()
        marker1.position = NMGLatLng(lat: 37.2744861, lng:  127.1283805)
        marker1.mapView = naverMapView
        marker1.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        marker1.iconTintColor = UIColor.blue
       
        //
        let marker2 = NMFMarker()
        marker2.position = NMGLatLng(lat: 37.272324, lng:  127.1289919)
        marker2.mapView = naverMapView
        marker2.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        marker2.iconTintColor = UIColor.blue
       
        //
        let marker3 = NMFMarker()
        marker3.position = NMGLatLng(lat: 37.2718358, lng:  127.120037)
        marker3.mapView = naverMapView
        marker3.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        marker3.iconTintColor = UIColor.blue
        
        //
        let marker4 = NMFMarker()
        marker4.position = NMGLatLng(lat: 37.2711035, lng:  127.1389174)
        marker4.mapView = naverMapView
        marker4.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        marker4.iconTintColor = UIColor.blue
 
        
        //
        let marker5 = NMFMarker()
        marker5.position = NMGLatLng(lat: 37.2796111, lng:  127.1283805)
        marker5.mapView = naverMapView
        marker5.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        marker5.iconTintColor = UIColor.blue
       
        let marker6 = NMFMarker()
        marker6.position = NMGLatLng(lat: 37.2728135, lng:  127.1283805)
        marker6.mapView = naverMapView
        marker6.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        marker6.iconTintColor = UIColor.blue
        
        if CLLocationManager.locationServicesEnabled() {
            print(" MapPolyLineNaviViewController 위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
//            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.2770729, lng: 127.1341291))
            cameraUpdate.animation = .easeIn
            naverMapView.moveCamera(cameraUpdate)
            
            //현재 위치 마커
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.iconImage = NMFOverlayImage(image: UIImage(systemName: "car.rear.fill")!)
            marker.iconTintColor = UIColor.red
            marker.width = 20
            marker.height = 20
            marker.mapView = naverMapView
            
            
        }
    }
}
