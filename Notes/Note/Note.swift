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
    
    dynamic var name = ""
    
    dynamic var notes = ""

    dynamic var createdAt = NSDate()
    
    dynamic var isCompleted = false
}
