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
    
    func addNoteList(_ list: NoteList) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(list)
        }
    }
    
    func removeList(_ list: NoteList) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(list)
        }
    }
    
    func addNote(_ note: Note, toSelectedList: NoteList) {
        let realm = try! Realm()
        
        try! realm.write {
            toSelectedList.notes.append(note)
        }
    }
    
    func makeCompleteSelectedNote(note: Note) {
        let realm = try! Realm()
        
        try! realm.write {
            note.isCompleted = true
        }
    }
    
    func updateSelectedNote(_ note: Note, name: String) {
        let realm = try! Realm()
        
        try! realm.write {
            note.name = name
        }
    }
    
}
