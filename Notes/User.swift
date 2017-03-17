//
//  User.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 17/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import Foundation

class User {
    
    // MARK: - Initialization
    
    /// :nodoc:
    fileprivate init() {}
    
    // MARK: - Settings
    
    /// The authorized status for user.
    static var isAuthorized: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "user.isAuthorized")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user.isAuthorized")
            Log.add(text: "User.isAuthorized = \(newValue)", .info)
        }
    }
    
    /// The registered status for user.
    static var isRegistered: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "user.isRegistered")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user.isRegistered")
            Log.add(text: "User.isRegistered = \(newValue)", .info)
        }
    }
    
    /// The user password.
    static var password: String {
        get {
            return UserDefaults.standard.string(forKey: "user.password") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user.password")
            Log.add(text: "User.password = \(newValue)", .info)
        }
    }
    
    /// The tochID is false by default.
    static var isTochID: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "user.isTochID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user.isTochID")
            Log.add(text: "User.isTochID = \(newValue)", .info)
        }
    }
    
    

}
