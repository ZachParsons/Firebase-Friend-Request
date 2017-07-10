//
//  FriendViewController.swift
//  FirebaseFriendRequest
//
//  Created by Kiran Kunigiri on 7/8/16.
//  Copyright © 2016 Kiran. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI updated everytime list changes
        // addFriendObserver def on FriendSystem 169
        FriendSystem.system.addFriendObserver {
            self.tableView.reloadData()
        }
    }
}

extension FriendViewController: UITableViewDataSource {
   
    // sets one section for all rows
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // sets number of rows as count of friended users
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.friendList.count
    }
    
    // sets one row per object returned from current user's friends index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell
        if cell == nil {
            tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell
        }
        
        // Modify cell
        // add's button with title remove to de-friend
        // refers to public struct UIControlState
        cell!.button.setTitle("Remove", for: UIControlState())
        // sets table row cell to display each user's email
        cell!.emailLabel.text = FriendSystem.system.friendList[indexPath.row].email
        // calls send request function on user's id
        // removeFriend def on FriendSystem 125
        cell!.setFunction {
            let id = FriendSystem.system.friendList[indexPath.row].id
            FriendSystem.system.removeFriend(id!)
        }
        
        // Return cell
        return cell!
    }
    
}
