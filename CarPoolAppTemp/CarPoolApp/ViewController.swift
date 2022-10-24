//
//  ViewController.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/07/01.
//

import UIKit
//import KakaoSDKUser
import NMapsMap

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoTalk() success.")
//
//                    //do something
//                    _ = oauthToken
//                }
//            }
//        }
//
//        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoAccount() success.")
//
//                    //do something
//                    _ = oauthToken
//                }
//            }
        
    
        let naverMapView = NMFNaverMapView(frame: view.frame)
                view.addSubview(naverMapView)
    }


}

