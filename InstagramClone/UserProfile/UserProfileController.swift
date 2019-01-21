//
//  UserProfileController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/6/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProfileHeaderDelegate {
    func didChangeToListView() {
        isGridView = false
        collectionView.reloadData()
    }
    
    func didChangeToGridView() {
        isGridView = true
        collectionView.reloadData()
    }
    
    var isGridView = true
    
    var userId: String?
    
    fileprivate var posts = [Post]()
    
    let cellId = "cellId"
    let singleCellId = "SingleCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        // Fetch user info from Firebase and fill in the screen
        fetchUser()
        
        // register a supplementary view using our custom profileHeader, and a Kind of header
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        collectionView.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: singleCellId)
        
        setupLogOutButton()
//        fetchPosts()
    }
    
    fileprivate func fetchOrderedPosts() {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        let uidToUse = self.userId ?? currentUserUid
        let databaseRef = Database.database().reference().child("posts").child(uidToUse)
        
        
        
        databaseRef.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            
            guard let user = self.user else {return}
            
            let post = Post(user: user, dictionary: dictionary)
            self.posts.insert(post, at: 0)
            
            self.collectionView.reloadData()
        }) { (err) in
            print("Failed to fetch posts with error: \(err)")
        }
    }
    
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    @objc func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            print("Perform log out")
            do {
                try Auth.auth().signOut()
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.isNavigationBarHidden = true
                self.present(navController, animated: true, completion: nil)
            } catch let signOutErr {
                print("Failed to sign out with error: \(signOutErr)")
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Build Collection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isGridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfilePhotoCell
            cell.post = posts[indexPath.item]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: singleCellId, for: indexPath) as! HomePostCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isGridView {
            let width = (view.frame.width - 2) / 3
            return CGSize(width: width, height: width)
        }
        let width = view.frame.width
        var height: CGFloat = 40 // profile image height
        height += 8 + 8 // top and bottom padding for profile image
        height += width // width of photo = height of photo == square photo :)
        height += 50 // height of action bar
        height += 120 // height of caption
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    // MARK: Set Supplementary view
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        header.delegate = self
        header.user = self.user
        
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
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let uidToUse = self.userId ?? currentUserId
        
        Database.fetchUserWithUID(uid: uidToUse) { (user) in
            self.user = user
            self.navigationItem.title = self.user?.username
            
            // Call the collectionViewDelegate methods again
            // (this will set the header user, and update the photo)
            self.collectionView.reloadData()
            self.fetchOrderedPosts()
        }
    }
    
}
