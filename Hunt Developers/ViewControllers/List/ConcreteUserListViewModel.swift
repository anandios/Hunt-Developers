//
//  ConcreteUserListViewModel.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/19/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

class ConcreteUserListViewModel : NSObject, UserListViewModel {
    var delegate: UserListViewModelDelegate? = nil
    var title: String
    let appCore: AppCore
    var users: [UserObject] = Array()
    
    var itemSelectedCommand:((_ index: Int) -> ())?
    
    init(appCore: AppCore) {
        self.appCore = appCore
        self.appCore.useCases.getUsersUseCase?.getUsers(0)
        self.title = "Java Developers"
        super.init()
        self.appCore.useCases.getUsersUseCase?.delegate = self
        
        if let users = self.appCore.useCases.getUsersUseCase?.users {
            self.users = convertUsers(users)
            
            if self.users.count > 0 {
                delegate?.datasourceUpdate()
            } else {
                delegate?.noUpdatesLoaded()
            }
        }
    }
    
    public func didSelectItem(_ index: Int) {
        if let block = itemSelectedCommand {
            block(index)
        }
    }
    
    public func didReachLastItem() {
        self.appCore.useCases.getUsersUseCase?.getUsers(users.count)
    }
    
    func convertUsers(_ users:[User]) -> [UserObject] {
        var usersArray:[UserObject] = Array()
        
        for user in users {
            let userObj = UserObject.init(name: user.name, userName: user.userName, profileImageUrl: user.profileImageUrl, joinedAt: user.joinedAt)
            usersArray.append(userObj)
        }
        return usersArray
    }
}

extension ConcreteUserListViewModel : GetUsersDelegate {
    func didLoadUsers(_ users: [User]) {
        self.users = convertUsers(users)
        if self.users.count > 0 {
            delegate?.datasourceUpdate()
        } else {
            delegate?.noUpdatesLoaded()
        }
    }
}
