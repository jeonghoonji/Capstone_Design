//
//  MapMenuViewController.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/07/01.


import Foundation
import UIKit
import NMapsMap


class MapMenuViewController:UIViewController{


    @IBOutlet weak var startPointTextField: UITextField!
    @IBOutlet weak var endPointTextField: UITextField!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var currentButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let naverMapView = NMFNaverMapView(frame: view.frame)
                mapView.addSubview(naverMapView)
        naverMapView.showCompass = true
        naverMapView.showLocationButton = true


        let coord = NMGLatLng(lat: 37.5670135, lng: 126.9783740)

        print("위도: \(coord.lat), 경도: \(coord.lng)")
    //
    }

    @IBAction func currentButtonTapped(_ sender: Any) {
//        naverMapView.positionMode = .direction
        print("button tapped")
    }
    
    
    //
}




