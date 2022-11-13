

import Foundation
import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import FirebaseDatabase

var ref: DatabaseReference!

class LoginViewController:UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
   

    override func viewDidLoad() {
        super.viewDidLoad()
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//
//        ref.child("people!").child("person2").setValue(["name1":"fomagran1"])
        
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
                print(user)
                if error == nil {
                    let name = (user?.properties?["nickname"]!  )
                    let profile = (user?.properties?["profile_image"]!)
//                    let email = (user?.properties?[])
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
//                    UserDefaults.standard.setValue(profile, forKey: "kakaoProfile")
                    
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
    
    @IBAction func riderButton(_ sender: Any) {
        let kakaoName = UserDefaults.standard.string(forKey: "kakaoName")
        let profileName = kakaoName!
        ref = Database.database().reference()
        
        //위도 latitude , 경도 longitude
//        ref.child("people!").child("person2").setValue(["name1":"fomagran1"])
        ref.child("Rider").child("object").setValue([
            "name":"\(profileName)",
            "lat" : "37.275435",
            "lon": "127.1437385",
            
        ])
        print("riderButton tapped")
    }
    
    
    @IBAction func driverButton(_ sender: Any) {
        let kakaoName = UserDefaults.standard.string(forKey: "kakaoName")
        let profileName = kakaoName!
        ref = Database.database().reference()
        
        ref.child("Driver").child("object").setValue([
            "name":"\(profileName)",
            "lat":"37.27412333",
            "lon":"127.1434213",
            "driving":"on"
            ])
        print("driverButton tapped")
    }
}






