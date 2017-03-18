//
//  SettingsTableViewController.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    // MARK: - Properties
    
    @IBOutlet weak var touchIDSwitch: UISwitch!
    
    @IBOutlet weak var openLastNoteSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        touchIDSwitch.isOn = User.isTochID
        openLastNoteSwitch.isOn = User.isOpenLastCreatedNote
    }
    
    // MARK: - UISwitch Action
    
    @IBAction func touchDidChange(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            User.isTochID = true
        case false:
            User.isTochID = false
        }
    }
    
    @IBAction func openLastNoteValueDidChange(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            User.isOpenLastCreatedNote = true
        case false:
            User.isOpenLastCreatedNote = false
        }
    }
 
    // MARK: - Logout Action
    
    @IBAction func logoutDidClick(_ sender: UIButton) {
        createActionSheetPermision()
    }
    
    
    func createActionSheetPermision() {
        let alert = UIAlertController(title: "Вы действительно хотите выйти?", message: nil, preferredStyle: .actionSheet)
        
        let logoutAction = UIAlertAction(title: "Выйти", style: .destructive) { (alert) in
            
            User.isRegistered = false
            User.isAuthorized = false
            User.password = ""
            self.toRegisterScene()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(logoutAction)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Segue
    
    func toRegisterScene() {
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Registration", bundle: nil).instantiateInitialViewController()!
    }

}
