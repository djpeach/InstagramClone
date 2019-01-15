//
//  PhotoSelectionHeader.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/14/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
    var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .cyan
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .brown
        
        addSubview(photoImageView)
        photoImageView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: self.topAnchor, rightAnchor: self.rightAnchor, bottomAnchor: self.bottomAnchor, leftAnchor: self.leftAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
