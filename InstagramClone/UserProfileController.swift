//
//  UserProfileController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/6/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        fetchUser()
    }
    
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let username = dictionary["username"] as? String
            self.navigationItem.title = username
        }) { (err) in
            print("Failed to fetch user: \(err)")
        }
    }
    
}
