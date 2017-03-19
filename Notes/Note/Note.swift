//
//  Note.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    
    dynamic var id = 0
    
    dynamic var name = ""
    
    dynamic var notes = ""

    dynamic var createdAt = NSDate()
    
    dynamic var isCompleted = false
    
    dynamic var isNotificated = false
    
    /// Sets primary key.
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Note.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
