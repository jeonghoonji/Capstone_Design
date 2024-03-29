
import Foundation
import UIKit
import NMapsMap
import SwiftyJSON
import Alamofire
import CoreLocation
import KakaoSDKNavi

class MapPolyLineNaviViewController : UIViewController,CLLocationManagerDelegate{
    
    var polylineArray : [String] = []
    var sumStr : String = ""
    var str : String = "NMFPolylineOverlay( ["
    var str1 : String = ""
    var str2 : String = "]) "
    
    
    //깃허브 숨길 코드
    let KAKAO_API_KEY = "KakaoAK 2802fecadb4f108816903ba754d617ed"

    let NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
    let NAVER_CLIENT_ID = "jk1xs2tu2j"
    let NAVER_CLIENT_SECRET = "JjUu0Dj6QJTszkxa35uQeKUtbN8RoMm4wIyzml6N"
    let NAVER_REVERSE_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords="
    let sourcecrs = "&sourcecrs="
    let orders = "&orders="
    let output = "&output="
    

    @IBOutlet weak var mapView: UIView!

    var locationManager = CLLocationManager()
    
    let endString = UserDefaults.standard.string(forKey:"endPointTextUserDefaults")!
    let endX = UserDefaults.standard.string(forKey:"endPointXUserDefaults")!
    let endY = UserDefaults.standard.string(forKey:"endPointYUserDefaults")!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user_latitude = locationManager.location?.coordinate.latitude else {return }
        guard let uesr_longitude = locationManager.location?.coordinate.longitude else {return }
        

        let KAKAO_URL = "https://apis-navi.kakaomobility.com/v1/directions?origin=" + String(uesr_longitude) + "," + String(user_latitude) + "&destination=" + endX + "," + endY + "&waypoints=&priority=RECOMMEND&car_fuel=GASOLINE&car_hipass=false&alternatives=false&road_details=false"
        let polyHeader = HTTPHeader(name: "Authorization", value: KAKAO_API_KEY)
        let polyKakaoHeaders = HTTPHeaders([polyHeader])
        
        let naverMapView = NMFMapView(frame: mapView.frame)
                view.addSubview(naverMapView)
        
        //경기도 화성시 석우동
        //경기도 용인시 구갈동
        AF.request(KAKAO_URL,method: .get , headers: polyKakaoHeaders).validate()
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
                    print("POLY KAKAO SUCCESS")
                    let json = JSON(value)
                    let routes = json["routes"]
                    let test = routes[0]
                    let sections = test["sections"]
                    let test2 = sections[0]
                    let roads = test2["roads"]
                    for i in 0..<roads.count{
                        var test3 = roads[i]
                        var vertexes = test3["vertexes"]
                        for j in 0..<vertexes.count{
                            do{
                                let encoder = JSONEncoder()
                                encoder.outputFormatting = .prettyPrinted
                                let xData = try encoder.encode(vertexes[j])
                                var resultX = String(data: xData, encoding: .utf8)!
                                self.polylineArray.append(resultX)
                            }catch (let error) {
                                print(error)
                            }
                        }
                    }
                    
                    var arr : [String] = []
//
                    for i in stride(from: 0, through: (self.polylineArray.count)-2, by: 2){
                        self.str1 +=  "NMGLatLng(lat: \(Double(self.polylineArray[i+1]) ?? 0.0 ), lng: \(Double(self.polylineArray[i]) ?? 0.0)),"
                        arr.append(
                                   " NMFPolylineOverlay( [ NMGLatLng(lat: \(Double(self.polylineArray[i+1]) ?? 0.0 ), lng: \(Double(self.polylineArray[i]) ?? 0.0) ) ] ) "
                        )
                    }
                    
                    
                    print("여기 실행")
                    print(self.polylineArray.count)
                    var pathOverlay = NMFPath()
                    let test1 : NMGLineString = NMGLineString(points: 1.1)
                    print("test1\(test1)")
//
//                    for i in stride(from: 0, through: (self.polylineArray.count)-2, by: 2){
////                        print("for 실행")
//                        pathOverlay.path = NMGLineString(points: [
//                            NMGLatLng(lat: Double(self.polylineArray[i+1]) ?? 0.0 , lng: Double(self.polylineArray[i]) ?? 0.0 )
//                        ])
////                        pathOverlay.mapView = naverMapView
//                    }
                    

                case .failure(let error):
                    print("POLY KAKAO FAIL")
                    print(error.errorDescription ?? "" )
                default:
                    fatalError()
                }
            }
        
//        let polyline = NMFPolylineOverlay([
//            NMGLatLng(lat: 37.57152, lng: 126.97714),
//            NMGLatLng(lat: 37.56607, lng: 126.98268),
//            NMGLatLng(lat: 37.56445, lng: 126.97707),
//            NMGLatLng(lat: 37.55855, lng: 126.97822)  ])
//
//        polyline?.mapView = naverMapView
//
        
        
//        let pathOverlay = NMFPath()
//        pathOverlay.path = NMGLineString(points: [
//            NMGLatLng(lat: 37.57152, lng: 126.97714),
//            NMGLatLng(lat: 37.56607, lng: 126.98268),
//            NMGLatLng(lat: 37.56445, lng: 126.97707),
//            NMGLatLng(lat: 37.55855, lng: 126.97822)
//        ])
//        pathOverlay.mapView = naverMapView
//
        
        //원하는 좌표 마커
        //목적지 좌표 마커
        let marker1 = NMFMarker()
        marker1.position = NMGLatLng(lat: Double(endY) ?? 0.0, lng: Double(endX) ?? 0.0)
        marker1.mapView = naverMapView
        

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
        //
        
                
        //viewdidLoad
        }

    
    //안내시작 버튼
    @IBAction func naviStartButton(_ sender: Any) {
        
        //x -> Longitude 37
        //y -> Latitude 127
        var option = NaviOption(coordType : .WGS84)
        let destination = NaviLocation(name: "카카오판교오피스", x: endX, y: endY)
        // 경유지
//        let viaList = [NaviLocation(name: "판교역 1번출구", x:  "127.063433", y: "37.1984409")]
   
        guard let navigateUrl = NaviApi.shared.navigateUrl(destination: destination, option:option /*,viaList: viaList?*/) else {
            return
        }
        UIApplication.shared.open(navigateUrl, options: [:], completionHandler: nil)

    }
    
    //class
}



