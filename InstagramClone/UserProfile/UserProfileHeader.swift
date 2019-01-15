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
    
    // Create dynamic optional user var
    var user: User? {
        didSet {
            guard let profileImageUrl = user?.profileImageUrl else { return }
            profileImageView.loadImage(urlString: profileImageUrl)
            
            userNameLabel.text = self.user?.username
        }
    }
    
    // MARK: Create view for profile image
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.image = #imageLiteral(resourceName: "profile_selected")
        return iv
    }()
    
    let gridButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
//        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    
    let listButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    
    let bookmarkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSMutableAttributedString(string: "posts", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSMutableAttributedString(string: "followers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSMutableAttributedString(string: "following", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit Profile", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(profileImageView)
        profileImageView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: self.topAnchor, rightAnchor: nil, bottomAnchor: nil, leftAnchor: self.leftAnchor, topPadding: 12, rightPadding: 0, bottomPadding: 0, leftPadding: 12)
        profileImageView.setSize(widthAnchor: 80, heightAnchor: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        setupBottomToolbar()
        self.addSubview(userNameLabel)
        userNameLabel.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: profileImageView.bottomAnchor, rightAnchor: self.safeRightAnchor, bottomAnchor: gridButton.topAnchor, leftAnchor: self.safeLeftAnchor, rightPadding: 12, leftPadding: 12)
        setupUserStatsView()
        self.addSubview(editProfileButton)
        editProfileButton.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: postsLabel.bottomAnchor, rightAnchor: followingLabel.rightAnchor, bottomAnchor: nil, leftAnchor: postsLabel.leftAnchor, topPadding: 2)
        editProfileButton.setSize(widthAnchor: nil, heightAnchor: 34)
    }
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        stackView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: self.safeTopAnchor, rightAnchor: self.safeRightAnchor, bottomAnchor: nil, leftAnchor: profileImageView.rightAnchor, topPadding: 12, rightPadding: 12, leftPadding: 12)
        stackView.setSize(widthAnchor: nil, heightAnchor: 50)
    }
    
    fileprivate func setupBottomToolbar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        self.addSubview(topDividerView)
        self.addSubview(bottomDividerView)
        
        stackView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: nil, rightAnchor: self.safeRightAnchor, bottomAnchor: self.safeBottomAnchor, leftAnchor: self.safeLeftAnchor)
        stackView.setSize(widthAnchor: nil, heightAnchor: 50)
        
        topDividerView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: stackView.topAnchor, rightAnchor: self.safeRightAnchor, bottomAnchor: nil, leftAnchor: self.safeLeftAnchor)
        topDividerView.setSize(widthAnchor: nil, heightAnchor: 0.5)
        
        bottomDividerView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: stackView.bottomAnchor, rightAnchor: self.safeRightAnchor, bottomAnchor: nil, leftAnchor: self.safeLeftAnchor)
        bottomDividerView.setSize(widthAnchor: nil, heightAnchor: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
