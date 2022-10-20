//
//  MapMenuViewController.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/07/01.


//해야할일
//- 네이버 지도 처럼 맵위에 길찾기 텍스트 필드를 넣고 싶었지만 능력부족 지도를 보여주는 부분과 텍스트필드쪽 오토레이아웃 잡기
//- 지도 아래 부분으로 드라이버 찾기 버튼 -> 이게 서버로 전송한는 버튼이며 FindDriverView으로 가는 코드 구현



import UIKit
import NMapsMap 
import SwiftyJSON
import Alamofire
import CoreLocation

class MapMenuViewController:UIViewController,CLLocationManagerDelegate{
    

    @IBOutlet weak var startPointTextField: UITextField!
    @IBOutlet weak var endPointTextField: UITextField!
    @IBOutlet weak var mapView: UIView!
    

    
    @IBOutlet weak var testLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    struct Addresses: Decodable{
        var x : Double = 0.0
        var y : Double = 0.0
        
        init(x: Double, y: Double) {
            self.x = x
            self.y = y
        }
    }
   
 
    
    //깃허브에는 숨길 코드
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //위치 정보 묻기
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    
        
        let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: NAVER_CLIENT_ID)
        let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: NAVER_CLIENT_SECRET)
        let headers = HTTPHeaders([header1,header2])
        

    
        
        let naverMapView = NMFMapView(frame: view.frame)
                mapView.addSubview(naverMapView)

        //현재 위치로 이동후 마커 표시 ( 출발지 )
        if CLLocationManager.locationServicesEnabled() {
            print(" MapPolyLineNaviViewController 위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            //            print(locationManager.location?.coordinate)
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            naverMapView.moveCamera(cameraUpdate)
            
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.mapView = naverMapView
        }

        
        
        // 경위도는 double이며 CLLocationDegrees이기 때문에 강제 언래핑이 아닌 guard문을 이용하여 풀기
        guard let user_latitude = locationManager.location?.coordinate.latitude else {return }
        guard let uesr_longitude = locationManager.location?.coordinate.longitude else {return }
        
        // user_latitude, uesr_longitude 을 String형으로 변환해서 쿼리문 만들기
        let reverseURL :String = NAVER_REVERSE_GEOCODE_URL + String(uesr_longitude) + "," + String(user_latitude) + "&sourcecrs=epsg:4326&output=json&orders=legalcode"
        
        
                   
        AF.request(reverseURL, method: .get ,headers: headers ).validate()
               .responseJSON { response in
                   switch response.result {
                   case .success(let value as [String:Any]):
                       let json = JSON(value)
                       
                       let results = json["results"]
                       let region = results[0]["region"]
                       
                       // 경기도,서울시,부산시,강원도 등등
                       let area1 = region["area1"]
                       var city = area1["name"]

                       // 화성시,수원시,용인시 등등
                       let area2 = region["area2"]
                       var si = area2["name"]
                       
                       // 석우동, 동탄1동, 반석동 등등
                       let area3 = region["area3"]
                       var dong = area3["name"]
                       
                       self.startPointTextField.text = "\(city) \(si) \(dong)"
                    case .failure(let error):
                       print(error.errorDescription ?? "")
                   default :
                       fatalError()
                   }
               }
        
       


    //
    }
    
    @IBAction func getDirectionButtonTapped(_ sender: UIButton) {
        let station = endPointTextField.text
        guard let encodeAddress = station?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! else { return  }

        //숨겨야할 코드
        let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: NAVER_CLIENT_ID)
        let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: NAVER_CLIENT_SECRET)
        let headers = HTTPHeaders([header1,header2])
        print("headers: \(headers)")
        //폴리메뉴로 도착지 한글 보내기
        let endString = (self.endPointTextField.text)!
        UserDefaults.standard.setValue(endString, forKey: "endPointTextUserDefaults")

        AF.request(NAVER_GEOCODE_URL + encodeAddress, method: .get,headers: headers).validate()
               .responseJSON { response in
                   switch response.result {
                   case .success(let value /*as [String:Any]*/):

                       let json = JSON(value)
                       let data = json["addresses"]
                       let detail = data[0]

                       let lan = detail["y"]
                       let lon = detail["x"]
                       print("detail\(detail)")
//                       print("lan: \(lan)")
//                       print("lan Type:\(type(of:lan))")
//                       print("lan: \(lon)")
                       
//                       let test : Addresses = Addresses(x: lan.rawValue as! Double, y: lon.rawValue as! Double)
//                       print(test)

               
                       print("lon Type:\(type(of:lon))")
                   case .failure(let error):
                       print(error.errorDescription ?? "")
                   default :
                       fatalError()
                   }
               }
        
    //
    }


    
    @IBAction func testButton(_ sender: Any) {
        //
        let header1 = HTTPHeader(name: "Authorization", value: KAKAO_API_KEY)
        let kakaoHeaders = HTTPHeaders([header1])
//        print("kakaoHeaders: \(kakaoHeaders)")
        AF.request(KAKAO_URL,method: .get , headers: kakaoHeaders).validate()
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
                    print("KAKAO SUCCESS")
                    let json = JSON(value)
                    print(json)
                    
                    
                case .failure(let error):
                    print("KAKAO FAIL")
                    print(error.errorDescription ?? "" )
                default:
                    fatalError()
                }
            }
    }
    



    @IBAction func kakaoTestButton(_ sender: Any) {
        let header1 = HTTPHeader(name: "Authorization", value: KAKAO_API_KEY)
        let kakaoHeaders = HTTPHeaders([header1])
        AF.request(KAKAO_URL_ADDRESS,method: .get , headers: kakaoHeaders).validate()
            .responseJSON{ response in
                switch response.result {
                case .success(let value):
                    print("KAKAO SUCCESS")
                    let json = JSON(value)
                    print(json)
                    
                    
                case .failure(let error):
                    print("KAKAO FAIL")
                    print(error.errorDescription ?? "" )
                default:
                    fatalError()
                }
            }
        
    //
    }
    
    
    
//
}




