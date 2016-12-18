//
//  UserListViewModel.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

protocol UserListViewModelDelegate {
    func datasourceUpdate()
    func noUpdatesLoaded()
}

class UserListViewModel {
    var delegate: UserListViewModelDelegate? = nil
    let name = "Thomas"
    let username = "tmos"
    let imageUrl = "https://avatars.githubusercontent.com/u/1618732?v=3"
    let joinedAt = "2012-04-06T13:51:07Z"
    let title = "Java Developers (github)"
    
    public var numberOfItems = 10
    
    public func didReachLastItem() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: {[weak self](timer) in
            if (self?.numberOfItems)! < 30 {
                self?.numberOfItems += 10
                self?.delegate?.datasourceUpdate()
            } else {
                self?.delegate?.noUpdatesLoaded()
            }
        })
    }
}
