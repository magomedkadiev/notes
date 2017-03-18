//
//  NotesViewController.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    
    // MARK: - Properties
    
    @IBOutlet weak var createSectionButton: UIBarButtonItem!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Create Section Action
    
    @IBAction func createSectionDidClick(_ sender: UIBarButtonItem) {
        createAlertInputView()
    }
    
    // MARK: - UIAlertController
    
    func createAlertInputView() {
        let alert = UIAlertController(title: "Создать новый раздел", message: nil, preferredStyle: .alert)
        
        alert.addTextField {_ in}
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена",
                                      style: .cancel,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
 
}
