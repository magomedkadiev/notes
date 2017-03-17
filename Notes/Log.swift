//
//  Log.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 17/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import Foundation

class Log {
    
    // MARK: - Initialization
    
    /// :nodoc:
    fileprivate init() {}
    
    // MARK: - Logging
    
    /**
     Adds a message to terminal with the specified type.
     
     - parameter text: The log text.
     - parameter type: The log type.
     */
    static func add(text: String, _ type: LogType) {
        print("[\(String(describing: type).capitalized)] \(text)")
    }
}
