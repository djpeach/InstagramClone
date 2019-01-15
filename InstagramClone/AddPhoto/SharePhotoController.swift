//
//  SharePhotoController.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/14/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet {
            self.thumbnail.image = selectedImage
        }
    }
    
    let thumbnail: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.boldSystemFont(ofSize: 18)
        return tv
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 240, green: 240, blue: 240)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: view.safeAreaLayoutGuide.topAnchor, rightAnchor: view.rightAnchor, bottomAnchor: nil, leftAnchor: view.leftAnchor)
        containerView.setSize(widthAnchor: nil, heightAnchor: 100)
        
        containerView.addSubview(thumbnail)
        thumbnail.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: containerView.topAnchor, rightAnchor: nil, bottomAnchor: containerView.bottomAnchor, leftAnchor: containerView.leftAnchor, topPadding: 8, bottomPadding: 8, leftPadding: 8)
        thumbnail.setSize(widthAnchor: 84, heightAnchor: nil)
        
        containerView.addSubview(textView)
        textView.anchor(centerXAnchor: nil, centerYAnchor: nil, topAnchor: containerView.topAnchor, rightAnchor: containerView.rightAnchor, bottomAnchor: containerView.bottomAnchor, leftAnchor: thumbnail.rightAnchor, topPadding: 8, rightPadding: 8, bottomPadding: 8, leftPadding: 8)
    }
    
    @objc func handleShare() {
        
        guard let image = selectedImage else { return }
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else { return }
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(filename)
        storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                print("Failed to upload post image with error: \(err)")
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                
                return
            }
            
            storageRef.downloadURL(completion: { (url, err) in
                if let err = err {
                    print("Failed to get download URL for the image with error: \(err)")
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    
                }
                
                guard let imageUrl = url?.absoluteString else { return }
                
                self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
                
                print("Successfully uploaded post image: \(imageUrl)")
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String) {
        guard let caption = textView.text, caption.count > 0 else { return }
        guard let postImage = selectedImage else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Error saving post in database with error: \(err)")
            }
            
            print("Successfully uploaded post to DB")
        }
    }
}
