//
//  Post.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/14/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import Foundation

struct Post {
    var id: String?
    let imageUrl: String
    let user: User
    let caption: String
    let creationDate: Date
    
    var hasLiked: Bool = true
    
    init(user: User, dictionary: [String : Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
