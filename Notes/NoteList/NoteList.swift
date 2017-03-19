//
//  NoteList.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import Foundation
import RealmSwift

class NoteList: Object {
    
    dynamic var id = 0
    
    dynamic var name = ""
    
    dynamic var createdAt = NSDate()
    
    let notes = List<Note>()
    
    /// Sets primary key.
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(NoteList.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
