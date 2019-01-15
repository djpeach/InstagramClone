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
            guard let url = URL(string: imageUrl) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print("Failed to fetch post image with error: \(err)")
                }
                
                guard let imageData = data else { return }
                let photoImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.photoImageView.image = photoImage
                }
            }.resume()
        }
    }
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
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
