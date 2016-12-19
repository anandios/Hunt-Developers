//
//  PluginsContainer.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

class PluginsContainer {
    
    public let persistenceManager: PersistenceManager
    public let getUsersPlugin: GetUsersPlugin
    
    init(configuration: Configurations) {
        persistenceManager = PersistenceManager()
        getUsersPlugin = ConcreteGetUsersPlugin.init(baseUrlString:configuration.apiBaseUrl, session: URLSession.shared)
    }
}
