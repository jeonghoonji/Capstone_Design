//
//  TestView.swift
//  CarPoolApp
//
//  Created by 지정훈 on 2022/11/16.
//

import Foundation
import UIKit
import KakaoSDKNavi
class TestView : UIViewController, UNUserNotificationCenterDelegate {
    
    
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    let userLocation : Int = 0
    let duration : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNotificationCenter.delegate = self
        
        requestNotificationAuthorization()
        sendNotification(seconds: 5.0)
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


//extension NaviMenuViewController : UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("notification Start3")
//        completionHandler()
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("notification Start4")
//        completionHandler([.alert, .badge, .sound])
//    }
//}
