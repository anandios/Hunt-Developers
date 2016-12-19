//
//  User.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

struct User {
    var identifier: Int
    var name: String
    var userName: String
    var profileImageUrl: String
    var joinedAt: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.identifier = (dictionary["id"] as! NSNumber).intValue
        self.name = ""
        self.userName = dictionary["login"] as! String
        self.profileImageUrl = dictionary["avatar_url"] as! String
        self.joinedAt = ""
    }
}
