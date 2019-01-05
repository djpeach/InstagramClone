//
//  RegisterController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/5/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

class RegisterController: UIViewController, RegisterDelegate {
    
    func signUpNewUser() {
        print("Signing up new user")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let registerView = RegisterView()
        registerView.delegate = self
        self.view = registerView
    }
    
}
