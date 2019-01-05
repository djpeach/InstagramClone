//
//  RegisterController+RegisterDelegate.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/5/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

extension RegisterController {
    
    func signUpNewUser(email: String, username: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Failed to create user with error: \(err)")
                return
            }
            
            guard let user = user?.user else { return }
            
            let usernameValues = ["username": username]
            let values = [user.uid: usernameValues]
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                if let err = err {
                    print("Failed to save user info to the db with error: \(err)")
                    return
                }
                print("Successfully saved user info to db")
            })
            print("Successfully created user: \(user.uid)")
        }
    }
    
    func getPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
}
