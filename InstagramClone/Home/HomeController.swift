//
//  HomeController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/15/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

fileprivate let cellId = "CELLID"

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems()
        fetchPosts()
    }
    
    func setupNavigationItems() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        cell.post = self.posts[indexPath.item] 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height: CGFloat = 40 // profile image height
        height += 8 + 8 // top and bottom padding for profile image
        height += width // width of photo = height of photo == square photo :)
        height += 50 // height of action bar
        height += 120 // height of caption
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    fileprivate func fetchPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDictionary = snapshot.value as? [String : Any] else { return }
            let user = User(dictionary: userDictionary)
            
            let databaseRef = Database.database().reference().child("posts").child(uid)
            databaseRef.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String : Any] else { return }
                
                let post = Post(user: user, dictionary: dictionary)
                self.posts.append(post)
                
                self.collectionView.reloadData()
            }) { (err) in
                print("Failed to fetch posts with error: \(err)")
            }

        }) { (err) in
            print("Failed to fetch user for post with error: \(err)")
        }
    }
}
