//
//  AuthorizationViewController.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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


