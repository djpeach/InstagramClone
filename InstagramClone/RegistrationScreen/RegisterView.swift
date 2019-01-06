//
//  RegisterView.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/5/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    
    var delegate: RegisterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(addPhotoWasClicked), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.addTarget(self, action: #selector(textWasEdited), for: .editingChanged)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.addTarget(self, action: #selector(textWasEdited), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.addTarget(self, action: #selector(textWasEdited), for: .editingChanged)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(signUpWasClicked), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    
    @objc func signUpWasClicked() {
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let username = usernameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        guard let profilePicture = plusPhotoButton.imageView?.image else { return }
        
        delegate?.signUpNewUser(email: email, username: username, password: password, profilePicture: profilePicture)
    }
    
    @objc func textWasEdited() {
        let emailHasText = emailTextField.text?.count ?? 0 > 0
        let usernameHasText = usernameTextField.text?.count ?? 0 > 0
        let passwordHasText = passwordTextField.text?.count ?? 0 > 0
        
        let formIsFilled = emailHasText && usernameHasText && passwordHasText
        
        if formIsFilled {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .tBlue
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .tLightBlue
        }
    }
    
    @objc func addPhotoWasClicked() {
        delegate?.getPhoto()
    }
    
    fileprivate func buildView() {
        self.backgroundColor = .white
        placeAddPhotoButton()
        placeInputFields()
    }
    
    fileprivate func placeAddPhotoButton() {
        self.addSubview(plusPhotoButton)
        
        plusPhotoButton.anchor(centerXAnchor: self.centerXAnchor, centerYAnchor: nil, topAnchor: self.safeTopAnchor, rightAnchor: nil, bottomAnchor: nil, leftAnchor: nil, topPadding: 20)
        plusPhotoButton.setSize(widthAnchor: 140, heightAnchor: 140)
    }
    
    fileprivate func placeInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        let stackViewHeight = CGFloat(stackView.arrangedSubviews.count * Int(stackView.spacing + 50))
        
        self.addSubview(stackView)
        
        stackView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: plusPhotoButton.safeBottomAnchor, rightAnchor: self.safeRightAnchor, bottomAnchor: nil, leftAnchor: self.safeLeftAnchor, topPadding: 20, rightPadding: 40, leftPadding: 40)
        stackView.setSize(widthAnchor: nil, heightAnchor: stackViewHeight)
        
    }
    
    func updateAddPhotoButton(withImage newImage: UIImage) {
        plusPhotoButton.setImage(newImage.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
    }
}
