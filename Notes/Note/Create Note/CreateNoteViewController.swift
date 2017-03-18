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
    
    @IBOutlet weak var noteTextView: UITextView!
    
    var selectedList: NoteList!
    
    var note: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard note == nil else {
            noteTextView.text = note.name
            return
        }
        
    }
    
    // MARK: - Done Button Action
    
    @IBAction func doneButtonDidClick(_ sender: UIButton) {
        
        guard noteTextView.text.characters.count > 0 else {
            // empty field
            return
        }
        
        guard note == nil else {
            NoteManager.shared.updateSelectedNote(note, name: noteTextView.text)
            dismiss(animated: true, completion: nil)
            return
        }
        
        createNewNote()
        dismiss(animated: true, completion: nil)
    }
    
    func createNewNote() {
        let note = Note()
        note.name = noteTextView.text
        NoteManager.shared.addNote(note, toSelectedList: selectedList)
    }

}
