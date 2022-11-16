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
        
        let Drivermarker1 = NMFMarker()
        Drivermarker1.position = NMGLatLng(lat: 37.2744861, lng:  127.1283805)
        Drivermarker1.mapView = naverMapView
        Drivermarker1.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        Drivermarker1.iconTintColor = UIColor.blue
       
        //
        let Drivermarker2 = NMFMarker()
        Drivermarker2.position = NMGLatLng(lat: 37.272324, lng:  127.1289919)
        Drivermarker2.mapView = naverMapView
        Drivermarker2.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        Drivermarker2.iconTintColor = UIColor.blue
       
        //
        let Drivermarker3 = NMFMarker()
        Drivermarker3.position = NMGLatLng(lat: 37.2718358, lng:  127.120037)
        Drivermarker3.mapView = naverMapView
        Drivermarker3.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        Drivermarker3.iconTintColor = UIColor.blue
        
        //
        let Drivermarker4 = NMFMarker()
        Drivermarker4.position = NMGLatLng(lat: 37.2711035, lng:  127.1389174)
        Drivermarker4.mapView = naverMapView
        Drivermarker4.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        Drivermarker4.iconTintColor = UIColor.blue
       
        
        
        //
        let Drivermarker5 = NMFMarker()
        Drivermarker5.position = NMGLatLng(lat: 37.2796111, lng:  127.1283805)
        Drivermarker5.mapView = naverMapView
        Drivermarker5.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        Drivermarker5.iconTintColor = UIColor.blue
       
        let Drivermarker6 = NMFMarker()
        Drivermarker6.position = NMGLatLng(lat: 37.2728135, lng:  127.1283805)
        Drivermarker6.mapView = naverMapView
        Drivermarker6.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
        Drivermarker6.iconTintColor = UIColor.blue
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print(" MapPolyLineNaviViewController 위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            
            
            
//            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.2770729, lng: 127.1341291))
            cameraUpdate.animation = .easeIn
            naverMapView.moveCamera(cameraUpdate)
            
            //현재 위치 마커
            let marker = NMFMarker()
//            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.position = NMGLatLng(lat: 37.2770729, lng: 127.1341291)
            marker.mapView = naverMapView
//            marker.iconImage = NMFOverlayImage(image: UIImage(systemName: "figure.wave")!)
            marker.iconTintColor = UIColor.purple
            //
            let infoWindow = NMFInfoWindow()
            let dataSource = NMFInfoWindowDefaultTextSource.data()
            dataSource.title = "현위치"
            infoWindow.dataSource = dataSource
            infoWindow.open(with: marker)
        }
    }
}
