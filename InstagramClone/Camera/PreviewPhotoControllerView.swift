//
//  File.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/20/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit
import Photos

class PreviewPhotoContainerView: UIView {
    
    let previewImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "save_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleSave() {
        let library = PHPhotoLibrary.shared()
        
        guard let previewImage = previewImageView.image else { return }
        
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: previewImage)
        }) { (success, err) in
            if let err = err {
                print("Error saving to photos: \(err)")
                return
            }
            
            DispatchQueue.main.async {
                let saveLabel = UILabel()
                saveLabel.text = "Saved Successfully"
                saveLabel.textColor = .white
                saveLabel.font = UIFont.boldSystemFont(ofSize: 18)
                saveLabel.numberOfLines = 0
                saveLabel.textAlignment = .center
                saveLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
                saveLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
                saveLabel.center = self.center
                saveLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
                
                self.addSubview(saveLabel)
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    saveLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }, completion: { (completed) in
                    UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        saveLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                        saveLabel.alpha = 0
                    }, completion: { (_) in
                        saveLabel.removeFromSuperview()
                    })
                })
            }
        }
    }
    
    @objc fileprivate func handleCancel() {
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews(views: [previewImageView, saveButton, cancelButton])
        previewImageView.fillSuperView()
        saveButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 24, right: 0))
        cancelButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 24, left: 24, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
