//
//  CreateNoteViewController.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Done Button Action
    
    @IBAction func doneButtonDidClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
