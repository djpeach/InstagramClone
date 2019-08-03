//
//  Comment.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/20/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import Foundation

struct Comment {
    let text: String
    let uid: String
    let user: User
    
    init(user: User, dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.user = user
    }
}
