//
//  AppDelegate.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/17/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let storyboardName = "Main"
    var appCore: AppCore?
    var window: UIWindow?
    var router: Router?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupContainers()
        
        return true
    }

    func setupContainers() {
        
        let configurations: Configurations
        
        #if COLOR
            configurations = Configurations.init(backgroundColor: .black)
        #else
            configurations = Configurations.init(backgroundColor: .blue)
        #endif
        
        let plugins = PluginsContainer.init(configuration: configurations)
        let useCases = UseCasesContainer.init(plugins: plugins)
        
        self.appCore = AppCore.init(plugins: plugins, useCases: useCases)
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        
        router = Router.init(storyboard: storyboard, window: window!, appCore: self.appCore!)        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        if let appCore = self.appCore {
            appCore.plugins.persistenceManager.saveContext()
        }
    }
}
