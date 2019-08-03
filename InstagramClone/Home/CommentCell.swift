//
//  CommentCell.swift
//  InstagramFirebase
//
//  Created by Brian Voong on 5/2/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    var comment: Comment? {
        didSet {
            guard let comment = comment else { return }
            
            let attributedText = NSMutableAttributedString(string: comment.user.username, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: " " + comment.text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
            
            textView.attributedText = attributedText
            
            profileImageView.loadImage(urlString: comment.user.profileImageUrl)
        }
    }
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isScrollEnabled = false
        return textView
    }()
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .blue
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        profileImageView.setSize(width: 44, height: 44)
        profileImageView.layer.cornerRadius = 44 / 2
        
        addSubview(textView)
        textView.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 4, left: 4, bottom: 4, right: 4))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
