//
//  NoteCell.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteTextView: UITextView!
    
    var viewController: NoteViewController!
    
    var indexPath: IndexPath!
    
    @IBOutlet weak var completeButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    var note: Note! {
        didSet {
            noteTextView.text = note.name
            
            if note.isCompleted == true {
                editButton.isHidden = true
                self.isUserInteractionEnabled = false
                completeButton.setImage(#imageLiteral(resourceName: "Ok Filled_30"), for: .normal)
                
            } else {
                editButton.isHidden = false
                self.isUserInteractionEnabled = true
                completeButton.setImage(#imageLiteral(resourceName: "Ok_30"), for: .normal)
            }
        }
    }
    
 
    @IBAction func complteButtonDidClick(_ sender: UIButton) {
        NoteManager.shared.makeCompleteSelectedNote(note: note)
        viewController.tableView.reloadData()
    }

    @IBAction func editButtonDidClick(_ sender: UIButton) {
        viewController.performSegue(withIdentifier: "toCreationNote", sender: note)
    }
}
