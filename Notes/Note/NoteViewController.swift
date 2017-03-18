//
//  NoteViewController.swift
//  Notes
//
//  Created by Султан Магомедкадиев on 18/03/2017.
//  Copyright © 2017 Magomedkadiev. All rights reserved.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController {

    // MARK: - Properties
    
    var selectedList: NoteList!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var createNoteButton: UIBarButtonItem!
    
    var isOpenLastCreatedNote: Bool = false
    
    var completedNotes: Results<Note>!
    
    var openNotes: Results<Note>! {
        didSet {
            noteNotificationToken?.stop()
            
            noteNotificationToken = openNotes.addNotificationBlock {
                [weak self] (changes: RealmCollectionChange) in
                
                guard let tableView = self?.tableView else { return }
                switch changes {
                case .initial:
                    tableView.reloadData()
                    
                case .update:
                    tableView.reloadData()
                    
                case .error(let error):
                    Log.add(text: "\(error)", .error)
                }
            }
        }
    }
    
    fileprivate var noteNotificationToken: NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = selectedList.name
        openNotes = selectedList.notes.filter("isCompleted = %@", false).sorted(byKeyPath: "createdAt", ascending:false)
        completedNotes = selectedList.notes.filter("isCompleted = %@", true).sorted(byKeyPath: "createdAt", ascending:false)
        
        if isOpenLastCreatedNote {
            setupBackButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupBackButton() {
        let button = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = button

    }
    
    func goBack() {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()
        
        if let tabbarController = initialViewController as? UITabBarController {
            tabBarController?.selectedIndex = 0
            appDelegate.window?.rootViewController = tabbarController
            appDelegate.window?.makeKeyAndVisible()

        }
    }
 
    // MARK: - Create Note Action
    
    @IBAction func createNoteDidClick(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toCreationNote", sender: nil)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toCreationNote":
            let createNoteViewController = segue.destination as! CreateNoteViewController
            createNoteViewController.selectedList = selectedList
            createNoteViewController.note = sender as? Note
            
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension NoteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if openNotes.count > 0 {
            if completedNotes.count > 0 {
                return 2
            } else {
                return 1
            }
        } else {
            if completedNotes.count > 0 {
                return 1
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            if openNotes.count == 0 {
                return completedNotes.count
            } else {
                return openNotes.count
            }
        }
        return completedNotes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if openNotes.count == 0 {
                return "COMPLETED NOTES"
            } else {
                return "OPEN NOTES"
            }
        }
        return "COMPLETED NOTES"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! NoteCell
        var note: Note!
        
        if indexPath.section == 0 {
            if openNotes.count == 0 {
                note = completedNotes[indexPath.row]
            } else {
                note = openNotes[indexPath.row]
            }
        } else {
            note = completedNotes[indexPath.row]
        }
        
        cell.note = note
        cell.viewController = self
        cell.indexPath = indexPath
        
        return cell
    }
}

fileprivate func getTabBarViewController() -> UITabBarController {
    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
    let rootViewController = appDelegate.window!.rootViewController!
    
    if let tabbarController = rootViewController as? UITabBarController {
        return tabbarController
    } else if let navigationController = rootViewController as? UINavigationController {
        for viewController in navigationController.viewControllers {
            if viewController.isKind(of: UITabBarController.self) {
                return viewController as! UITabBarController
            }
        }
    }
    assert(false, "CANT FIND TABBAR CONTROLLER")
    return rootViewController as! UITabBarController
}
