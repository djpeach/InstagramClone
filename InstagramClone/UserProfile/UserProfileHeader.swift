//
//  UserProfileHeader.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/6/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    // MARK: Create view for profile image
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile_selected")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        self.addSubview(profileImageView)
        profileImageView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: self.topAnchor, rightAnchor: nil, bottomAnchor: nil, leftAnchor: self.leftAnchor, topPadding: 12, rightPadding: 0, bottomPadding: 0, leftPadding: 12)
        profileImageView.setSize(widthAnchor: 80, heightAnchor: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        setupProfileImage()
    }
    
    // Create dynamic optional user var
    var user: User? {
        didSet {
            // When it gets set (will get set by UserProfile's fetchUser()), update the image
            setupProfileImage()
        }
    }
    
    fileprivate func setupProfileImage() {
        
        // Get imageUrl from user object
        guard let profileImageUrl = user?.profileImageUrl else { return }
        guard let url = URL(string: profileImageUrl) else { return }
        
        // Use Swift's URLSession's shared session to fetch the image
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            
            // get back on main UI Thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
