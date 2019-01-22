//
//  CommentInputAccessoryView.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/21/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

protocol CommentInputAccessoryViewDelegate {
    func didSubmit(text: String)
}

class CommentInputAccessoryView: UIView {
    
    var delegate: CommentInputAccessoryViewDelegate?
    
    func clearCommentTextField() {
        commentTextField.text = nil
    }
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Comment"
        return textField
    }()
    let submitButton: UIButton = {
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return submitButton
    }()
    fileprivate func setupLineSeparatorView() {
        let lineSeparatorView = UIView()
        lineSeparatorView.backgroundColor = UIColor.init(red: 230, green: 230, blue: 230)
        addSubview(lineSeparatorView)
        lineSeparatorView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        lineSeparatorView.setSize(width: nil, height: 0.5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(submitButton)
        submitButton.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 12))
        submitButton.setSize(width: 100, height: nil)
        addSubview(commentTextField)
        commentTextField.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: submitButton.leadingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        
        setupLineSeparatorView()
    }
    
    @objc fileprivate func handleSubmit() {
        guard let text = commentTextField.text else { return }
        delegate?.didSubmit(text: text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
