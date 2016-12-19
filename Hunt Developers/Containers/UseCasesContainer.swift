//
//  UseCasesContainer.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

class UseCasesContainer {
    var getUsersUseCase: GetUsers? = ConcreteGetUsers()
    var getUserDetailsUseCase: GetUserDetails? = ConcreteGetUserDetails()
}
