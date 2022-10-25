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
                    print("카카오톡 설치 여부 확인 에러")
                    print("error:\(error)")
                }
                else {
                    print("카카오톡 설치 여부 성공")
                    print("loginWithKakaoTalk() success.")
                    //do something
                    _ = oauthToken
                }
            }
        }
        
    }
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                onKakaoLoginCompleted(oauthToken?.accessToken)
            }
        }
        //카카오톡 설치되지 않은 경우 카카오 로그인 웹뷰를 띄운다.
        else{
            UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) { oauthToken, error  in
                onKakaoLoginCompleted(oauthToken?.accessToken)
            }
        }
        
        func onKakaoLoginCompleted(_ accessToken : String?){
            getKakaoUserInfo(accessToken)
            print("accessToken : \(accessToken)")
        }
        
        func getKakaoUserInfo(_ accessToken : String?){
            UserApi.shared.me() { [weak self] user, error in
                
                if error == nil {
                    let name = (user?.properties?["nickname"]!  )
                    let profile = (user?.properties?["profile_image"]!)
                    let userId = String(describing: user?.id)
                    print(userId)
                    print(name)
                    print(profile)
//                    guard let kakaoname = name else {r}
//                    if let kakaoName = name{
//                        UserDefaults.standard.setValue(kakaoName, forKey: "kakaoName")
//                    }else{
//                        return
//                    }
                    UserDefaults.standard.setValue(name, forKey: "kakaoName")
                    UserDefaults.standard.setValue(profile, forKey: "kakaoProfile")
                    
                }
                
                
            }
        }
//        if (AuthApi.hasToken()) {
//            UserApi.shared.accessTokenInfo { (_, error) in
//                if let error = error {
//                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
//                        print("sdkError:\(sdkError)")
//                        print("로그인이 필요합니다.")
//                    }
//                    else {
//                        print("여기는 에러 부분입니다 확인해주세요")
//                        print("error:\(error)")
//
//                    }
//                }
//                else {
//                    print("토큰이 체크되었습니다.")
//                    print("Token Checked")
//                }
//            }
//        }
//        else {
//            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//                if let error = error {
//                    print("else")
//                    print("여기는 에러 부분입니다 확인해주세요")
//                    print("error:\(error)")
//                }
//                else {
//                    print("카카오 로그인 성공")
//
//                    _ = oauthToken
//                    /// 로그인 관련 메소드 추가
//                }
//            }
//        }
        
//        UserApi.shared.me() { (user, error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                if let user = user {
//                    print("밑에 유저")
//                    print("user:\(user)")
//                    print(type(of: user))
//
//
//                    var scopes = [String]()
//                    if (user.kakaoAccount?.profileNeedsAgreement == true) { scopes.append("profile") }
//                    if (user.kakaoAccount?.emailNeedsAgreement == true) { scopes.append("account_email") }
//
//                    if scopes.count > 0 {
//                        print("사용자에게 추가 동의를 받아야 합니다.")
//
//
//                        UserApi.shared.loginWithKakaoAccount(scopes: scopes) { (_, error) in
//                            if let error = error {
//                                print(error)
//                            }
//                            else {
//                                UserApi.shared.me() { (user, error) in
//                                    if let error = error {
//                                        print(error)
//                                    }
//                                    else {
//                                        print("me() success.")
//
//                                        //do something
//                                        _ = user
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    else {
//                        print("사용자의 추가 동의가 필요하지 않습니다.")
//                    }
//                }
//            }
//        }
        
    }
    
    //
    @IBAction func waitButton(_ sender: Any) {
    }
}

