//
//  HomePostCell.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/15/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .yellow
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
