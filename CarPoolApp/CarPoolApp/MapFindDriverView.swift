//
//  MapFindDriverView.swift
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

struct UserList: Codable {
    let users: [Coordinate]
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}

class MapFindDriverView : UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    
    func load() -> Data? {
        
        let fileNm: String = "MapDriverUser"
        let extensionType = "json"
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {

            return nil
        }
    }
    
    func parsing(){
        guard let jsonData = load() else { return  }
        print(jsonData)
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let xData = try encoder.encode(jsonData)
            var resultX = String(data: xData, encoding: .utf8)!
            print(resultX)
            
        }catch (let error) {
            print(error)
        }
        print("dad")
       
        let sodeul = try? JSONDecoder().decode(UserList.self, from: jsonData)
        print(sodeul)
//        print(sodeul?.users[0].longitude)
//        print(sodeul?.users[0].latitude)
//        print(sodeul?.users[1].longitude)
//        print(sodeul?.users[1].latitude)
//        print(sodeul?.users[2].longitude)
//        print(sodeul?.users[2].latitude)
//        print(sodeul?.users[3].longitude)
//        print(sodeul?.users[3].latitude)
//        guard
//            let jsonData = load(),
////            print("jsonData\(jsonData)")
//            let dictData = String(data: jsonData, encoding: .utf8)
//
//        else { return }
        //
//        guard
//            let jsonData = load(),
//            let userList = try? JSONDecoder().decode(UserList.self, from: jsonData)
//        else { return }
//
//        print("userList:\(dictData)")
//        print(type(of: dictData))
        print("결과값")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parsing()

        let naverMapView = NMFMapView(frame: mapView.frame)
        view.addSubview(naverMapView)
        
        let marker1 = NMFMarker()
        marker1.position = NMGLatLng(lat: 37.2744861, lng:  127.1283805)
        marker1.mapView = naverMapView
        
        let marker2 = NMFMarker()
        marker2.position = NMGLatLng(lat: 37.272324, lng:  127.1289919)
        marker2.mapView = naverMapView
        
        let marker3 = NMFMarker()
        marker3.position = NMGLatLng(lat: 37.2718358, lng:  127.120037)
        marker3.mapView = naverMapView
        
        let marker4 = NMFMarker()
        marker4.position = NMGLatLng(lat: 37.2711035, lng:  127.1389174)
        marker4.mapView = naverMapView
        
        let marker5 = NMFMarker()
        marker5.position = NMGLatLng(lat: 37.2796111, lng:  127.1283805)
        marker5.mapView = naverMapView
        
        //
        let marker6 = NMFMarker()
        marker6.position = NMGLatLng(lat: 37.2728135, lng:  127.1283805)
        marker6.mapView = naverMapView

        
       
        
        if CLLocationManager.locationServicesEnabled() {
            print(" MapPolyLineNaviViewController 위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
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
