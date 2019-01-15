//
//  File.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/14/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var lastUrlToLoadImage: String?
    
    func loadImage(urlString: String) {
        
        lastUrlToLoadImage = urlString
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image with error: \(err)")
                return
            }
            
            // prevent duplicates loading ?? (bc async cannto guarentee order)
            if url.absoluteString != self.lastUrlToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
}
