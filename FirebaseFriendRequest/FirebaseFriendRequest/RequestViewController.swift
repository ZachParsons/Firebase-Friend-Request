//
//  RequestViewController.swift
//  FirebaseFriendRequest
//
//  Created by Kiran Kunigiri on 7/8/16.
//  Copyright © 2016 Kiran. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(FriendSystem.system.requestList)

        // UI updates everytime list changes
        // addRequestObserver def on FriendSystem 197 
        FriendSystem.system.addRequestObserver {
            print(FriendSystem.system.requestList)
            self.tableView.reloadData()
        }
    }

}

extension RequestViewController: UITableViewDataSource {
    
    // sets one section for all rows
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // sets number of rows as count of friend requests
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.requestList.count
    }
    
    // sets one row per object returned from current user's friend requests index path
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
        cell!.button.setTitle("Accept", for: UIControlState())
        // sets table row cell to display each user's email
        cell!.emailLabel.text = FriendSystem.system.requestList[indexPath.row].email
        // calls send request function on user's id
        // acceptFriendRequest def on FriendSystem 131
        cell!.setFunction {
            let id = FriendSystem.system.requestList[indexPath.row].id
            FriendSystem.system.acceptFriendRequest(id!)
        }
        
        // Return cell
        return cell!
    }
    
}
