//
//  RegisterDelegate.swift
//  InstagramClone
//
//  Created by Daniel Peach on 1/5/19.
//  Copyright © 2019 Daniel Peach. All rights reserved.
//

import Foundation

protocol RegisterDelegate {
    func signUpNewUser(email: String, username: String, password: String)
    func getPhoto()
}
