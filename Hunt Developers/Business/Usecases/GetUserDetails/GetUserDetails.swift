//
//  GetUserDetails.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

protocol GetUserDetailsOutputDelegate {
    func didLoadUserDetails(_ user: User)
}

protocol GetUserDetails {
    func loadUserDetails(_ user: String)
}
