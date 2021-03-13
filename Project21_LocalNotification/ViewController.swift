//
//  ViewController.swift
//  Project21_LocalNotification
//
//  Created by iMac on 07.03.2021.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                
            } else {
                
            }
        }
    }
    
    @objc func scheduleLocal() {
        
        let center = UNUserNotificationCenter.current()

        //center.removeAllPendingNotificationRequests() // убрать блок по времени
        
        let content = UNMutableNotificationContent()
        content.title = "Title goes here"
        content.body  = "Main text goes here"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData" : "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        //Календарный триггер:
//        var dateComponents = DateComponents()
//        dateComponents.hour   = 10
//        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        // ИНтервальный триггер:
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
        registerCategories()
    }
    
    //Добавить кнопки к уведомлению
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let button1 = UNNotificationAction(identifier: "button1", title: "Tell me more", options: .foreground) // button
        let button2 = UNNotificationAction(identifier: "button2", title: "OK, I understand", options: .foreground) // button
        let category = UNNotificationCategory(identifier: "alarm", actions: [button1, button2], intentIdentifiers: [])// group of buttons
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            
            switch response.actionIdentifier {
            
            case UNNotificationDefaultActionIdentifier:
                print("Default identifier")
                
            case "button1":
                print("Tell me more...")
            case "button2":
                print("OK, I understand...")
            default:
                break
            }
        }
        
        completionHandler()
    }


}

