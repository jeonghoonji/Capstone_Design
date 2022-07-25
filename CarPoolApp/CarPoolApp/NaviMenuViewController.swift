//
//  NaviMenuViewController.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/07/01.
//

import Foundation
import UIKit
import NMapsMap


class NaviMenuViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let naverMapView = NMFNaverMapView(frame: view.frame)
                view.addSubview(naverMapView)
        naverMapView.showCompass = false
        naverMapView.showLocationButton = true
        

//        NMFmapview.positionMode = .
        
    
    }
    
}

extension class NMFMapView : UIView{
    
}
