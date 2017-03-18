//
//  NoteViewController.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    // MARK: - Properties
    
    var selectedList: NoteList!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var createNoteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = selectedList.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
 
    // MARK: - Create Note Action
    
    @IBAction func createNoteDidClick(_ sender: UIBarButtonItem) {
        
    }
}
