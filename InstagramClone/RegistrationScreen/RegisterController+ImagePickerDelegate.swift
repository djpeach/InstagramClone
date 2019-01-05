//
//  RegisterController+ImagePickerDelegate.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/5/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

extension RegisterController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mainView = self.view as? RegisterView
        if let editedImage = info[.editedImage] as? UIImage {
            mainView?.updateAddPhotoButton(withImage: editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            mainView?.updateAddPhotoButton(withImage: originalImage)
            
        }
        
        dismiss(animated: true, completion: nil)
    }
}
