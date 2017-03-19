//
//  NoteListViewController.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit
import RealmSwift

class NoteListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var createSectionButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var noteList: Results<NoteList>! {
        didSet {
            noteListNotificationToken?.stop()
            
            noteListNotificationToken = noteList.addNotificationBlock {
                [weak self] (changes: RealmCollectionChange) in
                
                guard let tableView = self?.tableView else { return }
                switch changes {
                case .initial:
                    tableView.reloadData()
                    
                case .update(_, let deletions, let insertions, let modifications):
                    
                    tableView.beginUpdates()
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .none)
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .fade)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .none)
                    tableView.endUpdates()
                    
                case .error(let error):
                    Log.add(text: "\(error)", .error)
                }
            }
        }
    }
    
    fileprivate var noteListNotificationToken: NotificationToken!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noteList = NoteManager.shared.noteList.sorted(byKeyPath: "createdAt", ascending:false)
    }
    
    // MARK: - Deinitialization
    
    deinit {
        //noteListNotificationToken.stop()
    }
    
    // MARK: - Create Section Action
    
    @IBAction func createSectionDidClick(_ sender: UIBarButtonItem) {
        createAlertInputView()
    }
    
    // MARK: - UIAlertController
    
    func createAlertInputView() {
        let alert = UIAlertController(title: "Создать новый раздел", message: nil, preferredStyle: .alert)
        
        alert.addTextField {_ in}
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
            
            guard let name = alert?.textFields![0].text else {
                return
            }
            
            guard name.characters.count > 0 else {
                return
            }
            
            let noteList = NoteList()
            noteList.id = noteList.incrementID()
            noteList.name = name
            
            NoteManager.shared.addNoteList(noteList)
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toNote":
            let noteViewController = segue.destination as! NoteViewController
            noteViewController.selectedList = sender as! NoteList
            
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource

extension NoteListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteListCell") as! NoteListCell
        
        cell.noteList = noteList[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedList = noteList[indexPath.row]
            NoteManager.shared.removeList(selectedList)
        }
    }
}

// MARK: - UITableViewDelegate

extension NoteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedList = noteList[indexPath.row]
        performSegue(withIdentifier: "toNote", sender: selectedList)
    }
}
