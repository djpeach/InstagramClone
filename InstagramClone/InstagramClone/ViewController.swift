//
//  ViewController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/5/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 18)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 18)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 18)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(plusPhotoButton)
        
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        plusPhotoButton.anchor(centerXAnchor: view.centerXAnchor, centerYAnchor: nil, topAnchor: view.safeTopAnchor, rightAnchor: nil, bottomAnchor: nil, leftAnchor: nil, topPadding: 20)
        
        plusPhotoButton.setSize(widthAnchor: 140, heightAnchor: 140)
        
        setupInputFields()
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let stackViewHeight = CGFloat(stackView.arrangedSubviews.count * Int(stackView.spacing + 50))
        
        view.addSubview(stackView)
        
        stackView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: plusPhotoButton.safeBottomAnchor, rightAnchor: view.safeRightAnchor, bottomAnchor: nil, leftAnchor: view.safeLeftAnchor, topPadding: 20, rightPadding: 40, leftPadding: 40)
        
        stackView.setSize(widthAnchor: nil, heightAnchor: stackViewHeight)
        
    }
    
}

