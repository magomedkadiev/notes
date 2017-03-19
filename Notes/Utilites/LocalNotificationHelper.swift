//
//  LocalNotificationHelper.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 19/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class LocalNotificationHelper: NSObject {
    
    static var shared = LocalNotificationHelper()
    
    /// Check if the user has enabled notifications for this app and return true/false.
    func checkNotificationEnabled() -> Bool {
        guard let settings = UIApplication.shared.currentUserNotificationSettings else {
            return false
        }
        if settings.types == .none {
            return false
        } else {
            return true
        }
    }
    
    /// Setup schedule notification.
    func scheduleLocal(note: Note, alertDate: Date) {
        
        guard checkNotificationEnabled() else {
            Log.add(text: "Please, turn on your push notification", .debug)
            return
        }
        
        let notification = UILocalNotification()
        var fireDate = Date(timeIntervalSinceNow: 0)
        fireDate = alertDate
        notification.fireDate = fireDate
        notification.alertBody = note.name
        notification.alertAction = "Due : \(alertDate)"
        notification.soundName = "localNotificationSound.mp3"
        notification.userInfo = ["noteID": note.id]
        notification.applicationIconBadgeNumber = 1
        UIApplication.shared.scheduleLocalNotification(notification)
        
        Log.add(text: "Notification setup for noteID: \(note.id)", .info)
    }
    
    func removeNotification(note: Note) {
        
        // loop through the pending notifications
        for notification in UIApplication.shared.scheduledLocalNotifications! as [UILocalNotification] {
            
            // Cancel the notification that corresponds to this task entry instance (matched by taskTypeId)
            if (notification.userInfo!["noteID"] as? Int == note.id) {
                UIApplication.shared.cancelLocalNotification(notification)
                
                Log.add(text: "Notification deleted for noteID: \(note.id)", .info)
                break
            }
        }
    }
}
