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

                let sortedUsers = users.sorted { $0.userName.localizedCaseInsensitiveCompare($1.userName) == ComparisonResult.orderedAscending }
                self?.users.append(contentsOf: sortedUsers)
                _ = self?.loadUsersFromCache(currentCount)
            }
        })
        
        delegate?.didLoadUsers(users)
    }
    
    func loadUsersFromCache(_ currentCount: Int) -> Bool {
        
        if users.count > 0 && currentCount < users.count {
            let slice = users[0..<(currentCount+maxItemsPerReturn)]
            
            let slicedArray = [] + slice
            let sortedUsers = slicedArray.sorted { $0.userName.localizedCaseInsensitiveCompare($1.userName) == ComparisonResult.orderedAscending }
            
            if Thread.isMainThread {
                delegate?.didLoadUsers(sortedUsers)
            } else {
                DispatchQueue.main.sync {[weak self] in
                    if let delegate = self?.delegate {
                        delegate.didLoadUsers(sortedUsers)
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
