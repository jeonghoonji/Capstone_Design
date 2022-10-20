//
//  MapMenuTestViewController.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/09/17.
//

import UIKit
import NMapsMap
import SwiftyJSON
import Alamofire
import CoreLocation




class MapPolyLineNaviViewController:UIViewController,CLLocationManagerDelegate{

    var test1 : Double = 0.0
    var test2 : Double = 0.0
    
    @IBOutlet weak var mapView: UIView!

    var locationManager = CLLocationManager()
    
    let endString = UserDefaults.standard.string(forKey:"endPointTextUserDefaults")!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("endString: \(endString)")
    
        let naverMapView = NMFMapView(frame: view.frame)
                view.addSubview(naverMapView)
//        naverMapView.showCompass = true
//        naverMapView.showLocationButton = true
        
        //원하는 좌표 마커
        // 이마트 좌표
        let marker1 = NMFMarker()
        marker1.position = NMGLatLng(lat: 37.2143049, lng: 127.0795158)
        marker1.mapView = naverMapView
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
                
        if CLLocationManager.locationServicesEnabled() {
            print(" MapPolyLineNaviViewController 위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            //            print(locationManager.location?.coordinate)
            
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            naverMapView.moveCamera(cameraUpdate)
            
            //현재 위치 마커
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.mapView = naverMapView
            }
        //
        let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: NAVER_CLIENT_ID)
        let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: NAVER_CLIENT_SECRET)
        let headers = HTTPHeaders([header1,header2])
        
        print("headers:\(headers)")
        
        
        //viewdidLoad
        }

//class
}



