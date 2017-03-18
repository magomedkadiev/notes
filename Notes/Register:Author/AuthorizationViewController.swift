//
//  AuthorizationViewController.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthorizationViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if User.isTochID {
            authenticateUser()
        }
    }
    
    
    // MARK: - Touch ID
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Приложите палец, чтобы войти в приложение"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.toMainScene()
                    } else {
                        Log.add(text: "Authentication failed. Input your password by yourself", .debug)
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    

    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = range.range(for: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        guard updatedText != User.password else {
            toMainScene()
            return false
        }
        
        return updatedText.characters.count < 32
    }
    
    // MARK: - Segue 
    
    func toMainScene() {
        performSegue(withIdentifier: "toMainScene", sender: self)
    }

}


