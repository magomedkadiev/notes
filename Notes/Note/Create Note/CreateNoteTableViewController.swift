//
//  CreateNoteTableViewController.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit

class CreateNoteTableViewController: UITableViewController {

    // MARK: - Properties
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var selectedList: NoteList!
    
    var note: Note!
    
    var isNotificationOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noteTextView.becomeFirstResponder()
        
        guard note == nil else {
            // updating note
            noteTextView.text = note.name
            notificationSwitch.isOn = note.isNotificated
            isNotificationOn = note.isNotificated
            datePicker.isHidden = !note.isNotificated
            return
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return isNotificationOn ? 215 : 44
        default:
            return 44
        }
    } 
    
    // MARK: - Done Button Action
    
    @IBAction func doneButtonDidClick(_ sender: UIButton) {
        
        guard noteTextView.text.characters.count > 0 else {
            // empty field
            dismiss(animated: true, completion: nil)
            return
        }
        
        guard note == nil else {
            // updating note
            var notified = false
            if isNotificationOn {
                notified = true
                LocalNotificationHelper.shared.scheduleLocal(note: note, alertDate: datePicker.date)
            }
            NoteManager.shared.updateSelectedNote(note, name: noteTextView.text, notified: notified)
            dismiss(animated: true, completion: nil)
            return
        }
        
        createNewNote()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UISwitch Action 
    
    @IBAction func notificationSwitchDidClick(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            isNotificationOn = true
            datePicker.isHidden = false
            updateNotificationCell()
        case false:
            isNotificationOn = false
            datePicker.isHidden = true
            updateNotificationCell()
        }
    }
    
    func updateNotificationCell() {
        self.tableView.beginUpdates()
        let indexPath = IndexPath(row: 0, section: 1)
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.endUpdates()
    }
    
    func createNewNote() {
        let note = Note()
        note.id = note.incrementID()
        note.name = noteTextView.text!
        
        if isNotificationOn {
            note.isNotificated = true
            LocalNotificationHelper.shared.scheduleLocal(note: note, alertDate: datePicker.date)
        }
        
        NoteManager.shared.addNote(note, toSelectedList: selectedList)
    }

}

