//
//  Router.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import UIKit

class Router : NSObject {
    
    let mainStoryboard: UIStoryboard
    var fromViewController: UIViewController?
    var toViewController: UIViewController?
    var rootNavigationController: UINavigationController? = nil
    let window: UIWindow
    var firstViewController: UIViewController? = nil
    var appCore : AppCore?
    
    init(storyboard: UIStoryboard, window: UIWindow, appCore: AppCore) {

        self.mainStoryboard = storyboard
        self.window = window
        self.appCore = appCore
        
        super.init()
        
        if let rootViewController = storyboard.instantiateInitialViewController() {
            window.rootViewController = rootViewController
            rootNavigationController = rootViewController as? UINavigationController
        }
        
        present("/", parameters: nil)
    }
    
    public func present(_ route: String, parameters: Dictionary<String, Any>?) {
        
        switch route {
        
            case "/":
            
                if firstViewController == nil, let appCore = self.appCore {
                    let viewModel = ConcreteUserListViewModel.init(appCore: appCore)
                    viewModel.itemSelectedCommand = { [weak self] (index) in
                        self?.present("/details", parameters: ["viewModel" : viewModel, "index" : index])
                    }
                    
                    let userListViewController = mainStoryboard.instantiateViewController(withIdentifier: "UsersListViewController") as! UsersListViewController
                    userListViewController.view.backgroundColor = appCore.configurations.backgroundColor
                    
                    firstViewController = userListViewController
                    userListViewController.model = viewModel
            
                    rootNavigationController?.viewControllers = [userListViewController]
            
                    window.makeKeyAndVisible()
                } else {
                    _ = rootNavigationController?.popToRootViewController(animated: true)
                }
                break
            
            case "/details":
                let selectedIndex = parameters?["index"]
                print("selected index : \(selectedIndex)")
            
                let detailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
            
                rootNavigationController?.pushViewController(detailsViewController, animated: true)
            
                break
            
            default: break            
        }
    }
}
