//
//  File.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/9/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSMutableAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSMutableAttributedString(string: "Sign Up", attributes: [NSMutableAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSMutableAttributedString.Key.foregroundColor: UIColor(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    let logoContainerView: UIView = {
        let view = UIView()
        
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.anchor(centerXAnchor: view.centerXAnchor, centerYAnchor: view.centerYAnchor, topAnchor: nil, rightAnchor: nil, bottomAnchor: nil, leftAnchor: nil)
        
        view.backgroundColor = UIColor(red: 0, green: 120, blue: 175)
        return view
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
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginWasClicked), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    @objc func loginWasClicked() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if let err = err {
                print("Failed to log user in with error: \(err)")
                return
            }
            
            print("Successfully logged back in with user: \(user?.user.uid ?? "")")
            
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            mainTabBarController.setupViewControllers()
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @objc func handleShowSignUp() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoContainerView)
        logoContainerView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: view.topAnchor, rightAnchor: view.rightAnchor, bottomAnchor: nil, leftAnchor: view.leftAnchor)
        logoContainerView.setSize(widthAnchor: nil, heightAnchor: 200)
        
        view.backgroundColor = .white
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: nil, rightAnchor: view.safeRightAnchor, bottomAnchor: view.safeBottomAnchor, leftAnchor: view.safeLeftAnchor)
        dontHaveAccountButton.setSize(widthAnchor: nil, heightAnchor: 50)
        
        placeInputFields()
    }
    
    @objc func textWasEdited() {
        let emailHasText = emailTextField.text?.count ?? 0 > 0
        let passwordHasText = passwordTextField.text?.count ?? 0 > 0
        
        let formIsFilled = emailHasText && passwordHasText
        
        if formIsFilled {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .tBlue
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .tLightBlue
        }
    }
    
    fileprivate func placeInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        let stackViewHeight = CGFloat(stackView.arrangedSubviews.count * Int(stackView.spacing + 40))
        
        view.addSubview(stackView)
        
        stackView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: logoContainerView.safeBottomAnchor, rightAnchor: view.safeRightAnchor, bottomAnchor: nil, leftAnchor: view.safeLeftAnchor, topPadding: 40, rightPadding: 40, leftPadding: 40)
        stackView.setSize(widthAnchor: nil, heightAnchor: stackViewHeight)
        
    }
}
