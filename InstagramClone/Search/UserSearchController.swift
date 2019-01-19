//
//  UserSearchController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/19/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

fileprivate let cellId = "CELLID"

class UserSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var allUsers = [User]()
    var filteredUsers = [User]()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter Username"
        sb.barTintColor = UIColor.gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.init(red: 210, green: 210, blue: 210)
        sb.delegate = self
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
        fetchUsers()
        
        navigationController?.navigationBar.addSubview(searchBar)
        searchBar.fillSuperView(padding: .init(top: 0, left: 8, bottom: 8, right: 8))
        
        collectionView.register(UserSearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserSearchCell
        cell.user = filteredUsers[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (!searchText.isEmpty) {
            self.filteredUsers = self.allUsers.filter { (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            }
        } else {
            self.filteredUsers = self.allUsers
        }
        collectionView.reloadData()
    }
    
    fileprivate func fetchUsers() {
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key: String, value: Any) in
                
                guard let userDict = value as? [String: Any] else { return }
                
                let user = User(uid: key, dictionary: userDict)
                self.allUsers.append(user)
                
            })
            
            self.filteredUsers = self.allUsers
            self.collectionView.reloadData()
        }) { (err) in
            print("Failed to fetch users for search with error: \(err)")
        }
    }
}
