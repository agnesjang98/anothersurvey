//
//  InterfaceController.swift
//  anothersurvey WatchKit Extension
//
//  Created by Agnes Jang on 11/11/19.
//  Copyright © 2019 Agnes Jang. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class InterfaceController: WKInterfaceController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var StartSurveyButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        registerLocal()
        scheduleLocal()
    }
    
    @objc func registerLocal() {
        print("called register")
        let center = UNUserNotificationCenter.current()
        // when i show a message, show the alert, a badge, and play a sound
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {granted, error in
            if granted {
                print("yay")
            }
            else {
                print("nay")
            }
        })
    }
        
    @objc func scheduleLocal() {
        registerCategories()
        print("called schedule")
        // setting content to show
        let center = UNUserNotificationCenter.current()
        
        // clear all notification requests
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Survey Time!"
        content.body = "How are you doing today?"
        content.categoryIdentifier = "survey"
        content.userInfo = ["customData": "test"]
        content.sound = .default
        
        // when to show the content
        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 17
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats:true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // make a request (tie content and trigger together)
        // has an identifier; needs to be unique; uuid
        let request1 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        dateComponents.hour = 12
        dateComponents.minute = 18
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats:true)
        let request2 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger2)
        dateComponents.hour = 12
        dateComponents.minute = 19
        let trigger3 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats:true)
        let request3 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger3)
        
        center.add(request1)
        center.add(request2)
        center.add(request3)
        
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        // delegate is our view controller so that any messages from the notifications
        // get sent back to us
        center.delegate = self
        let green = UNNotificationAction(identifier: "green", title: "Green", options: [])
        let yellow = UNNotificationAction(identifier: "yellow", title: "Yellow", options: [])
        let blue = UNNotificationAction(identifier: "blue", title: "Blue", options: [])
        let red = UNNotificationAction(identifier: "red", title: "Red", options: [])
        // foreground means when the button is tapped, launch app immediately
        let category = UNNotificationCategory(identifier: "survey", actions: [green, yellow, blue, red], intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                    print("default identifier")
            case "show":
                print("show more information")
            case "green":
                print("make API call, insert entry for green")
            case "yellow":
                print("make API call, insert entry for yellow")
            case "blue":
                print("make API call, insert entry for blue")
            case "red":
                print("make API call, insert entry for red")
            default:
                break
            }
        }
        completionHandler()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
