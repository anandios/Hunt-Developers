//
//  UseCasesContainer.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

class UseCasesContainer {
    let plugins: PluginsContainer
    
    var getUsersUseCase: GetUsers?
    var getUserDetailsUseCase: GetUserDetails?
    
    init(plugins: PluginsContainer) {
        self.plugins = plugins
        self.getUsersUseCase = ConcreteGetUsers.init(getUserPlugin: plugins.getUsersPlugin)
        self.getUserDetailsUseCase = ConcreteGetUserDetails()
    }
}
