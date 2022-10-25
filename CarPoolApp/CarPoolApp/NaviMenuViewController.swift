

import UIKit
import NMapsMap
import CoreLocation
import KakaoSDKNavi

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
            //            print(locationManager.location?.coordinate)
            
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            naverMapView.moveCamera(cameraUpdate)
            
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.mapView = naverMapView
            
            //            let endPointMarker = NMFMarker()
            //            endPointMarker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            //            endPointMarker.mapView = naverMapView
            //            
        } else {
            print("위치 서비스 Off 상태")
        }
        
        
        
        
        
    }
    
}
