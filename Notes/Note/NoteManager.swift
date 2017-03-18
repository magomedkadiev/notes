//
//  NoteManager.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class NoteManager {
    
    static var shared = NoteManager()
    
    var noteList: Results<NoteList> {
        return try! Realm().objects(NoteList.self)
    }
    
    func addNoteList(name: String) {
        let realm = try! Realm()
        let newNoteList = NoteList()
        realm.beginWrite()
        
        newNoteList.name = name
        realm.add(newNoteList)
        
        try! realm.commitWrite()

    }
    
    
}
