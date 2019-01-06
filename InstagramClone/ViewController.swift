//
//  ViewController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/6/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        }
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
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    fileprivate func buildView() {
        view.backgroundColor = .white
        placeAddPhotoButton()
        placeInputFields()
    }
    
    fileprivate func placeAddPhotoButton() {
        view.addSubview(plusPhotoButton)
        
        plusPhotoButton.anchor(centerXAnchor: view.centerXAnchor, centerYAnchor: nil, topAnchor: view.safeTopAnchor, rightAnchor: nil, bottomAnchor: nil, leftAnchor: nil, topPadding: 20)
        plusPhotoButton.setSize(widthAnchor: 140, heightAnchor: 140)
    }
    
    fileprivate func placeInputFields() {
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
