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
        profileImageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        profileImageView.setSize(width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        setupBottomToolbar()
        self.addSubview(userNameLabel)
        userNameLabel.anchor(top: profileImageView.bottomAnchor, leading: self.leadingAnchor, bottom: gridButton.topAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        setupUserStatsView()
        self.addSubview(editProfileButton)
        editProfileButton.anchor(top: postsLabel.bottomAnchor, leading: postsLabel.leadingAnchor, bottom: nil, trailing: followingLabel.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        editProfileButton.setSize(width: nil, height: 34)
    }
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        stackView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
        stackView.setSize(width: nil, height: 50)
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
        
        stackView.anchor(top: nil, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        stackView.setSize(width: nil, height: 50)
        topDividerView.anchor(top: stackView.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        topDividerView.setSize(width: nil, height: 0.5)
        bottomDividerView.anchor(top: stackView.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        bottomDividerView.setSize(width: nil, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
