//
//  UserProfileController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/6/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        // Fetch user info from Firebase and fill in the screen
        fetchUser()
        
        // register a supplementary view using our custom profileHeader, and a Kind of header
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
    }
    
    // MARK: Set Supplementary view
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        
        header.user = self.user
        
        // not correct (not how you build a header view, create a custom one and use it during suppView registration instead
        // header.addSubView(UIImageView())
        
        return header
    }
    
    // Set the size of the header in this section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    // Create optional user var
    var user: User?
    
    // Fetch and set user to user var
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
        guard let dictionary = snapshot.value as? [String: Any] else { return }
        
        self.user = User(dictionary: dictionary)
        self.navigationItem.title = self.user?.username
        
        // Call the collectionViewDelegate methods again
        // (this will set the header user, and update the photo)
        self.collectionView.reloadData()
        
        }) { (err) in
            print("Failed to fetch user: \(err)")
        }
    }
    
}

// MARK: Define User object

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
