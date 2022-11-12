

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Database.database().reference().child("Rider")
        print("db:\(db)")


        userNotificationCenter.delegate = self
        
        requestNotificationAuthorization()
        sendNotification(seconds: 10)
        
       
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
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    func sendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "카풀을 원하는 유저가 있습니다."
        notificationContent.subtitle = "\(userLocation) "
        //        notificationContent.subtitle = "유저 위치 "
        notificationContent.body = "수락시 경유지 포함 예상 도착 시간~ \(duration)"
        
        
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
    
    
}
extension NaviMenuViewController : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
