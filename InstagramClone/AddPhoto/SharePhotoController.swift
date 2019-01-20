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
    
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")

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
        
        view.addSubViews(views: [containerView])
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        containerView.setSize(width: nil, height: 100)
        
        containerView.addSubViews(views: [thumbnail, textView])
        
        thumbnail.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: nil, padding: .init(top: 8, left: 8, bottom: 8, right: 0))
        thumbnail.setSize(width: 84, height: nil)
        
        textView.anchor(top: containerView.topAnchor, leading: thumbnail.trailingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
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
                
                NotificationCenter.default.post(name: SharePhotoController.updateFeedNotificationName, object: nil)
            })
        }
    }
    
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String) {
        guard let caption = textView.text, caption.count > 0 else { return }
        guard let postImage = selectedImage else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970, "invertedCreationDate": -1 * Date().timeIntervalSince1970] as [String : Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Error saving post in database with error: \(err)")
            }
            
            print("Successfully uploaded post to DB")
        }
    }
}
