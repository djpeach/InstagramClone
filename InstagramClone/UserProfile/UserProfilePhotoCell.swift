//
//  UserProfilePhotoCell.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/14/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let imageUrl = post?.imageUrl else { return }
            photoImageView.loadImage(urlString: imageUrl)
        }
    }
    
    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: topAnchor, rightAnchor: rightAnchor, bottomAnchor: bottomAnchor, leftAnchor: leftAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
