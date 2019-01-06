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
    
    func signUpNewUser(email: String, username: String, password: String, profilePicture: UIImage) {
        
        /* Create User */
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Failed to create user with error: \(err)")
                return
            }
            guard let user = user?.user else { return }
            print("Successfully created user: \(user.uid)")
            
            guard let uploadData = profilePicture.jpegData(compressionQuality: 0.3) else { return }
            
            /* Store Image */
            let fileName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child(fileName)
            
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                if let err = err {
                    print("Failed to upload image to storage with error: \(err)")
                    return
                }
                
                    storageRef.downloadURL(completion: { (downloadURL, err) in
                        if let err = err {
                            print("Failed to fetch downloadURL for the profilePicture with error: \(err)")
                            return
                        }
                        
                        guard let profileImageURL = downloadURL?.absoluteString else { return }
                        print("Successfully uploaded profile image: \(profileImageURL)")
                        
                        /* Store User Info in db */
                        let userInfo = ["username": username, "profileImageUrl": profileImageURL]
                        let valuesToStore = [user.uid: userInfo]
                        Database.database().reference().child("users").updateChildValues(valuesToStore, withCompletionBlock: { (err, ref) in
                            if let err = err {
                                print("Failed to save user info to db with error: \(err)")
                                return
                            }
                            
                            print("Successfully saved user info to db")
                        })
                    })
                
            })
            
//            let usernameValues = ["username": username]
//            let values = [user.uid: usernameValues]
//            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
//                if let err = err {
//                    print("Failed to save user info to the db with error: \(err)")
//                    return
//                }
//                print("Successfully saved user info to db")
//            })
        }
    }
    
    func getPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
}
