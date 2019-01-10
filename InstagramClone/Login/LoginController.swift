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
    
    @objc func handleShowSignUp() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(signUpButton)
        signUpButton.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: nil, rightAnchor: view.safeRightAnchor, bottomAnchor: view.safeBottomAnchor, leftAnchor: view.safeLeftAnchor)
        signUpButton.setSize(widthAnchor: nil, heightAnchor: 50)
    }
}
