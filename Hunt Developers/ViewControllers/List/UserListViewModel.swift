//
//  UserListViewModel.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

struct UserObject {
    var name: String
    var userName: String
    var profileImageUrl: String
    var joinedAt: String
}

protocol UserListViewModelDelegate {
    func datasourceUpdate()
    func noUpdatesLoaded()
}

protocol UserListViewModel  {
    
    var delegate: UserListViewModelDelegate? { get set }
    var title: String { get }
    var itemSelectedCommand:((_ index: Int) -> ())? { set get }
    var users: [UserObject] { get }

    func didReachLastItem()
    func didSelectItem(_ index: Int)
    
}
