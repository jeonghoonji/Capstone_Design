//
//  MapMenuViewController.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/07/01.

import UIKit
import NMapsMap
import SwiftyJSON
import Alamofire

class MapMenuViewController:UIViewController{
    

    @IBOutlet weak var startPointTextField: UITextField!
    @IBOutlet weak var endPointTextField: UITextField!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var currentButton: UIButton!


    let NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
    
    
    
  
    override func viewDidLoad() {
        let station = "경기도 화성시 석우동"
        let encodeAddress = station.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        super.viewDidLoad()

        let naverMapView = NMFNaverMapView(frame: view.frame)
                mapView.addSubview(naverMapView)
        naverMapView.showCompass = true
        naverMapView.showLocationButton = true
        

        let coord = NMGLatLng(lat: 37.5670135, lng: 126.9783740)

        print("위도: \(coord.lat), 경도: \(coord.lng)")
        
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
                       print("홍대입구역의","위도는",lat,"경도는",lon)
                   case .failure(let error):
                       print(error.errorDescription ?? "")
                   default :
                       fatalError()
                   }
               }
    //
    }

    @IBAction func currentButtonTapped(_ sender: Any) {
//        naverMapView.positionMode = .direction
        print("button tapped")
    }
    
    
    //
}




