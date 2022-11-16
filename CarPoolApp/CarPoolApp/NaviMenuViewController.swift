

import UIKit
import NMapsMap
import CoreLocation
import KakaoSDKNavi
import UserNotifications
import FirebaseDatabase


struct Rider : Codable {
    let lat : String
    let lon : String
}

class NaviMenuViewController:UIViewController,CLLocationManagerDelegate{
    
    //    var locationManager = CLLocationManager()
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    let userLocation : Int = 0
    let duration : Int = 0
    let endString = UserDefaults.standard.string(forKey:"endPointTextUserDefaults")!
    let endX = UserDefaults.standard.string(forKey:"endPointXUserDefaults")!
    let endY = UserDefaults.standard.string(forKey:"endPointYUserDefaults")!
    
    var userViaListX = ""
    var userViaListY = ""
    var userList : [Rider] = []
    
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
    override func viewDidLoad() {
        print("naviView Start")
        super.viewDidLoad()
//        showAlert(tittle: "검색 시간 초과", content: "최대 9분거리 드라이버를 못 찾았어요!!", okBtb: "돌아가기", noBtn: "") // 팝업창 호출
        userNotificationCenter.delegate = self
        
        requestNotificationAuthorization()
        sendNotification(seconds: 10.0)
        
        
        print("endX:\(endX)")
        var option = NaviOption(coordType : .WGS84)
        let destination = NaviLocation(name: endString, x: endX, y: endY)
        // 경유지
        //        let viaList = [NaviLocation(name: "판교역 1번출구", x:  "127.063433", y: "37.1984409")]
        
        guard let navigateUrl = NaviApi.shared.navigateUrl(destination: destination, option:option /*,viaList: viaList?*/) else {
            return
        }
        UIApplication.shared.open(navigateUrl, options: [:], completionHandler: nil)
        
        
        
        let db = Database.database().reference().child("Rider")
        print("db:\(db)")
       
        ref = Database.database().reference()

        db.observe(DataEventType.value, with:{ (snapshot) in

            guard let snapData = snapshot.value as? [String:Any] else { return }

            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            do{
                print("data:\(data)")
                let decoder = JSONDecoder()
                let singList = try decoder.decode([Rider].self, from: data)
                self.userList = singList
                print("singList:\(singList)")
                print(type(of: singList))

                [CarPoolApp.Rider(lat: "", lon: "")]

                print(type(of:singList[0]))
                print(singList[0].lat)
                print(singList[0].lon)

                self.userViaListX = singList[0].lon
                self.userViaListY = singList[0].lat
                print(self.userViaListX)
                print(type(of: self.userViaListX))
                print(self.userViaListY)
                print(type(of: self.userViaListY))
            }catch let error{
                print(error)
            }
        })
        



//
    }
    
    
    
    @IBAction func returnNaviButton(_ sender: Any) {
        let option = NaviOption(coordType : .WGS84)
        let destination = NaviLocation(name: "강남대학교 이공관", x: endX, y: endY)
//        let viaList = [NaviLocation(name: "유저 경유지", x : self.userViaListX  , y : self.userViaListY )]

        let viaList = [NaviLocation(name: "유저 경유지", x : /*self.userViaListX*/ "127.1437385"  , y : /*self.userViaListY*/"37.275435" )]
        guard let navigateUrl = NaviApi.shared.navigateUrl(destination: destination,  option:option ,viaList: viaList) else { return }

        UIApplication.shared.open(navigateUrl, options: [:], completionHandler: nil)

    }
    
    
    
    func requestNotificationAuthorization() {
        print("notification Start1")
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    func sendNotification(seconds: Double) {
        print("notification Start2")
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "카풀을 원하는 유저가 있습니다."
//        notificationContent.subtitle = "\(userLocation) "
        notificationContent.subtitle = "라이더의 위치는 어정역입니다 "
//        notificationContent.body = "수락시 경유지 포함 예상 도착 시간~ \(duration)"
        notificationContent.body = "수락시 경유지 포함 예상 도착 시간 32분 입니다"
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    func showAlert(tittle:String, content:String, okBtb:String, noBtn:String) {
        
        let alert = UIAlertController(title: tittle, message: content, preferredStyle: UIAlertController.Style.alert)
        if(okBtb != "" && okBtb.count>0){
            let okAction = UIAlertAction(title: okBtb, style: .default) { (action) in
                return
            }
            alert.addAction(okAction)
        }
        if(noBtn != "" && noBtn.count>0){
            let noAction = UIAlertAction(title: noBtn, style: .default) { (action) in
                return
            }
            alert.addAction(noAction)
        }
        present(alert, animated: false, completion: nil)
        
    }
    
    
}
extension NaviMenuViewController : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("notification Start3")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("notification Start4")
        completionHandler([.alert, .badge, .sound])
    }
}
