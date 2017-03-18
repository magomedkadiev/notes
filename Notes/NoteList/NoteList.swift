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
    
    dynamic var name = ""
    
    dynamic var createdAt = NSDate()
    
    let tasks = List<Note>()
}
