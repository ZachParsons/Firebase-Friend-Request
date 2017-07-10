//
//  UserListViewController.swift
//  FirebaseFriendRequest
//
//  Created by Kiran Kunigiri on 7/8/16.
//  Copyright © 2016 Kiran. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // gets the current user's email to display at top
        FriendSystem.system.getCurrentUser { (user) in
            self.usernameLabel.text = user.email
        }
        
        // UI updates everytime list changes
        // addUserObserver def on FriendSystem 145
        FriendSystem.system.addUserObserver { () in
            self.tableView.reloadData()
        }
    }

    // action for tapping logout button
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        FriendSystem.system.logoutAccount()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let rootVC = appDelegate.window!.rootViewController
        
        if rootVC == self.tabBarController {
            self.present((storyboard?.instantiateInitialViewController())!, animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

// extends class UserListViewController def above on 11 as inheriting from UITableViewDataSource
extension UserListViewController: UITableViewDataSource {
    
    // sets one section for all rows
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // sets number of rows as count of registered users
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.userList.count
    }
    
    // sets one row per object returned from users index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell
        if cell == nil {
            tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell
        }
        
        // Modify cell
        // sets table row cell to display user email
        cell!.emailLabel.text = FriendSystem.system.userList[indexPath.row].email
        
        // calls send request function on user's id
        // sendRequestToUser def on FriendSystem 120
        cell!.setFunction {
            let id = FriendSystem.system.userList[indexPath.row].id
            FriendSystem.system.sendRequestToUser(id!)
        }
        
        // Return cell
        return cell!
    }
    
}
