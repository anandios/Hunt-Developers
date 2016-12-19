//
//  GetUserDetails.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

class ConcreteGetUserDetails : GetUserDetails {
    
    let delegate: GetUserDetailsOutputDelegate? = nil
    
    func loadUserDetails(_ user: String) {
        if let delegate = delegate {
            delegate.didLoadUserDetails(User.init(name: "anand", userName: "abc", profileImageUrl: "", joinedAt: ""))
        }
    }
}
