//
//  TapMenuNaviView.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/11/14.
//


import Foundation
import UIKit
import KakaoSDKNavi


class TapMenuNaviView : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var option = NaviOption(coordType : .WGS84)
        let destination = NaviLocation(name: "강남대학교 이공관", x: "127.1341291", y: "37.2770729")
        
        // 경유지
        //        let viaList = [NaviLocation(name: "판교역 1번출구", x:  "127.063433", y: "37.1984409")]
        
        guard let navigateUrl = NaviApi.shared.navigateUrl(destination: destination, option:option /*,viaList: viaList?*/) else {
            return
        }
        UIApplication.shared.open(navigateUrl, options: [:], completionHandler: nil)
       
    }
    
   
}
