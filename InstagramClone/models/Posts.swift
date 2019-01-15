//
//  Post.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/14/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    
    init(dictionary: [String : Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
