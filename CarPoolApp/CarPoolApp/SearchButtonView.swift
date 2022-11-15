//
//  SearchButtonView.swift
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

var destinationText = UserDefaults.standard.string(forKey: "PickUserViewControllerDestinationTextData")
class SearchButtonView : UIViewController {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(destinationText)
        
        let naverMapView = NMFMapView(frame: mapView.frame)
        view.addSubview(naverMapView)
        
//        let marker1 = NMFMarker()
//        marker1.position = NMGLatLng(lat: Double(endY) ?? 0.0, lng: Double(endX) ?? 0.0)
//        marker1.mapView = naverMapView
        
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
