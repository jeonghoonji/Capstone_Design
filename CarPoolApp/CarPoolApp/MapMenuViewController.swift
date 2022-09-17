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
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var currentButton: UIButton!

    var locationManager = CLLocationManager()
    
    
    
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //위치 정보 묻기
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    
        
        let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: NAVER_CLIENT_ID)
        let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: NAVER_CLIENT_SECRET)
        let headers = HTTPHeaders([header1,header2])
        
        let starText: String
        
        let naverMapView = NMFNaverMapView(frame: view.frame)
                mapView.addSubview(naverMapView)
        naverMapView.showCompass = true
        naverMapView.showLocationButton = true

        
        
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
                       print(city)
                       // 화성시,수원시,용인시 등등
                       let area2 = region["area2"]
                       var si = area2["name"]
                       print(si)
                       // 석우동, 동탄1동, 반석동 등등
                       let area3 = region["area3"]
                       var dong = area3["name"]
                       print(dong)
                       
                       
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
        
        
        let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: NAVER_CLIENT_ID)
        let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: NAVER_CLIENT_SECRET)
        let headers = HTTPHeaders([header1,header2])
        
        
        AF.request(NAVER_GEOCODE_URL + encodeAddress, method: .get,headers: headers).validate()
               .responseJSON { response in
                   switch response.result {
                   case .success(let value as [String:Any]):
                       let json = JSON(value)
                       let data = json["addresses"]
                       let lat = data[0]["y"]
                       let lon = data[0]["x"]
                       print("\(self.endPointTextField.text)","위도는",lat,"경도는",lon)
                   case .failure(let error):
                       print(error.errorDescription ?? "")
                   default :
                       fatalError()
                   }
               }
        
//
    
    }
    
    
    @IBAction func currentButtonTapped(_ sender: Any) {
        print("button tapped")
        
    }
    
    
    //
}




