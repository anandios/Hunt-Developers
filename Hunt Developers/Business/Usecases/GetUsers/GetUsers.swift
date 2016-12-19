//
//  GetUsers.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

protocol GetUsersDelegate {
    func didLoadUsers(_ users: [User])
}

protocol GetUsers {
    var delegate: GetUsersDelegate? { get set }
    var users: [User] { get set }
    func getUsers(_ currentCount: Int)
}
