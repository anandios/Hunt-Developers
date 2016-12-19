//
//  AppCore.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import UIKit

class AppCore {
    public let plugins: PluginsContainer
    public let useCases: UseCasesContainer
    public let configurations: Configurations
    
    init(plugins: PluginsContainer, useCases: UseCasesContainer, configurations: Configurations) {
        self.plugins = plugins
        self.useCases = useCases
        self.configurations = configurations
    }
}
