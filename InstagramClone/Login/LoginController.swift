//
//  File.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/9/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign Up.", for: .normal)
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
    
    @objc func handleShowSignUp() {
        let signUpController = SignUpController()
//        navigationController?.isNavigationBarHidden = true
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
        
        view.addSubview(signUpButton)
        signUpButton.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: nil, rightAnchor: view.safeRightAnchor, bottomAnchor: view.safeBottomAnchor, leftAnchor: view.safeLeftAnchor)
        signUpButton.setSize(widthAnchor: nil, heightAnchor: 50)
    }
}
