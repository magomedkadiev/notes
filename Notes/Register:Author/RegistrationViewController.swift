//
//  RegistrationViewController.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 17/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var touchIDSwitch: UISwitch!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

        touchIDSwitch.isOn = User.isTochID
        passwordTextField.becomeFirstResponder()
    }
    
    // MARK: - UISwitch Action
 
    @IBAction func switchDidChange(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            User.isTochID = true
        case false:
            User.isTochID = false
        }
    }
    
    // MARK: - UIButton Action
    
    @IBAction func doneDidClick(_ sender: UIButton) {
        
        guard let password = passwordTextField.text else {
            Log.add(text: "Password is empty!", .error)
            return
        }
        
        User.isRegistered = true
        User.isAuthorized = true
        User.password = password
        toMainScene()
    }
    

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        return true
    }
    
    // MAR: - Segue
    
    func toMainScene() {
        performSegue(withIdentifier: "toMainScene", sender: self)
    }
    
}
