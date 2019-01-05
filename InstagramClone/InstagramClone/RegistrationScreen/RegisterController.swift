//
//  RegisterController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/5/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController, RegisterDelegate {
    
    func signUpNewUser(email: String, username: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Failed to create user with error: \(err)")
                return
            }
            
            print("Successfully created user: \(user?.user.uid ?? "no user")")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let registerView = RegisterView()
        registerView.delegate = self
        self.view = registerView
    }
    
}
