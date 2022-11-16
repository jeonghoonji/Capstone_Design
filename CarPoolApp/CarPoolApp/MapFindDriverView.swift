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
        
        
        let Usermarker1 = NMFMarker()
        Usermarker1.position = NMGLatLng(lat: 37.27574, lng:  127.13249)
        Usermarker1.mapView = naverMapView
        Usermarker1.iconImage = NMFOverlayImage(image: UIImage(systemName: "car.rear.and.tire.marks")!)
        Usermarker1.iconTintColor = UIColor.red
       
        //
        let Usermarker2 = NMFMarker()
        Usermarker2.position = NMGLatLng(lat: 37.2716614, lng: 127.1273424)
        Usermarker2.mapView = naverMapView
        Usermarker2.iconImage = NMFOverlayImage(image: UIImage(systemName: "car.rear.and.tire.marks")!)
        Usermarker2.iconTintColor = UIColor.red
       
        //
        let Usermarker3 = NMFMarker()
        Usermarker3.position = NMGLatLng(lat: 37.2717136, lng:  127.1302734)
        Usermarker3.mapView = naverMapView
        Usermarker3.iconImage = NMFOverlayImage(image: UIImage(systemName: "car.rear.and.tire.marks")!)
        Usermarker3.iconTintColor = UIColor.red
        
        //
        let Usermarker4 = NMFMarker()
        Usermarker4.position = NMGLatLng(lat: 37.2687313, lng:  127.1289391)
        Usermarker4.mapView = naverMapView
        Usermarker4.iconImage = NMFOverlayImage(image: UIImage(systemName: "car.rear.and.tire.marks")!)
        Usermarker4.iconTintColor = UIColor.red
       
        
        //
        let Usermarker5 = NMFMarker()
        Usermarker5.position = NMGLatLng(lat: 37.2724545, lng:  127.1376502)
        Usermarker5.mapView = naverMapView
        Usermarker5.iconImage = NMFOverlayImage(image: UIImage(systemName: "car.rear.and.tire.marks")!)
        Usermarker5.iconTintColor = UIColor.red
       
        let Usermarker6 = NMFMarker()
        Usermarker6.position = NMGLatLng(lat: 37.286581, lng:  127.1037513)
        Usermarker6.mapView = naverMapView
        Usermarker6.iconImage = NMFOverlayImage(image: UIImage(systemName: "car.rear.and.tire.marks")!)
        Usermarker6.iconTintColor = UIColor.red
       
        
//        let destination = NaviLocation(name: "강남대학교 이공관", x: "127.1341291", y: "37.2770729")
        
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
            marker.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.stand")!)
            marker.iconTintColor = UIColor.blue
            marker.width = 20
            marker.height = 20
            marker.mapView = naverMapView
            
            
            
            
        }
        
        
        
    }
   
}
