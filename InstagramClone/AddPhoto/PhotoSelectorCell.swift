//
//  PhotoSelectorCell.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/10/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
    
    var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .brown
        
        self.addSubViews(views: [photoImageView])
        photoImageView.fillSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
