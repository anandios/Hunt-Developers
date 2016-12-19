//
//  ConcreteGetUsers.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

class ConcreteGetUsers: GetUsers {
    var delegate: GetUsersDelegate?
    var users: [User] = []

    func getUsers() {
        let user = User.init(name: "Anand", userName: "anandios", profileImageUrl: "", joinedAt: "2012-04-06T13:51:07Z")
        users = [user]
        delegate?.didLoadUsers([])
    }
}
