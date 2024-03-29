//
//  LoginViewController.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/07/01.
//


//해야 할일
//- 로그인 토큰이 있을시 MapMenuViewController 으로 이동 코드 작성
//- 로그인 토큰이 없을시 회원가입 및 정보 동의 후 PickUserViewController 으로 이동하여 유저의 드라이버/라이더 정보 저장 후
//  MapMenuViewController으로 이동 코드 작성

import Foundation
import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class LoginViewController:UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //버튼을 카카오 로그인 이미지로 설정
        loginButton.setImage(UIImage(named: "kakao_login"), for: .normal)
        
        
        //카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    //do something
                    _ = oauthToken
                }
            }
        }
    
    }
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
//
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        print("로그인이 필요합니다.")
                    }
                    else {
                        print(error)
                    }
                }
                else {
                    print("Token Checked")
                }
            }
        }
        else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("카카오 로그인 성공")

                    _ = oauthToken
                    /// 로그인 관련 메소드 추가
                }
            }
        }
       
        
        //
    }
}

// 로그아웃 기능 추가
//UserApi.shared.logout {(error) in
//    if let error = error {
//        print(error)
//    }
//    else {
//        print("logout() success.")
//    }
//}
