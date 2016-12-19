//
//  ConcreteGetUsers.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

class ConcreteGetUsers: GetUsers {
    let totalItemPerPage = Int(30)
    let maxItemsPerReturn = Int(10)
    let maxPagesAllowed = Int(34)
    
    var currentPage: Int = 1

    var delegate: GetUsersDelegate?
    var users: [User] = []
    let getUserPlugin: GetUsersPlugin
    
    init(getUserPlugin: GetUsersPlugin) {
        self.getUserPlugin = getUserPlugin
    }

    func getUsers(_ currentCount: Int) {
        
        if loadUsersFromCache(currentCount) {
            return
        }
        
        currentPage = getPageNumber(currentCount)
        
        if maxPagesAllowed <= currentPage {
            return
        }
        
        self.getUserPlugin.getUsers(page: currentPage, completionBlock: {[weak self] (users,  error) in
            
            if error != nil {
                //fetch from db
            }
            
            if let users = users {
                self?.users.append(contentsOf: users)
                _ = self?.loadUsersFromCache(currentCount)
            }
        })
        
        delegate?.didLoadUsers(users)
    }
    
    func loadUsersFromCache(_ currentCount: Int) -> Bool {
        
        if users.count > 0 && currentCount < users.count {
            let slice = users[0..<(currentCount+maxItemsPerReturn)]
            
            if Thread.isMainThread {
                delegate?.didLoadUsers([] + slice)
            } else {
                DispatchQueue.main.sync {[weak self] in
                    if let delegate = self?.delegate {
                        delegate.didLoadUsers([] + slice)
                    }
                }
                
                return true
            }
            
            return true
        }
        
        return false
    }
    
    private func getPageNumber(_ currentCount: Int) -> Int {
        if currentCount == 0 {
            return 1
        }
        
        if currentCount > 0 && currentCount % totalItemPerPage == 0 {
            return (currentCount / totalItemPerPage) + 1
        }
        
        return currentPage
    }
}
