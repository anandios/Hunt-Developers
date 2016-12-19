//
//  User.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let userName: String
    let profileImageUrl: String
    let joinedAt: String
    
    init(name: String, userName: String, profileImageUrl: String, joinedAt: String) {
        self.name = name
        self.userName = userName
        self.profileImageUrl = profileImageUrl
        self.joinedAt = joinedAt
    }
}
