//
//  NoteListCell.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class NoteListCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var noteListNameLabel: UILabel!
    
    var noteList: NoteList! {
        didSet {
            noteListNameLabel.text = noteList.name
        }
    }
}
