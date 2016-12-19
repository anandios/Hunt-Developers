//
//  UsersListViewController.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import UIKit

class UsersListViewController: UITableViewController {
    
    @IBOutlet var noContentView: UIView!
    @IBOutlet var noContentLabel: UILabel!
    var contentTableView: UITableView?
    var model: UserListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = model?.title ?? ""
        
        contentTableView = self.tableView
        self.view = noContentView
        self.model?.delegate = self
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { [weak self](timer) in
            if let tableView = self?.contentTableView {
                self?.view = tableView
                tableView.reloadData()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if let users = model?.users {
            return users.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
        
        if let userObject = model?.users[indexPath.row] {
            cell.name.text = userObject.name 
            cell.username.text = userObject.userName
            cell.joinedAt.text = userObject.joinedAt
        } else {
            cell.name.text = "-"
            cell.username.text = "-"
            cell.joinedAt.text = "-"
        }
        
        return cell
    }
    
    override public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 10.0 {
            self.model?.didReachLastItem()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model?.didSelectItem(indexPath.row)
    }
}

// MARK: UserListViewModelDelegate

extension UsersListViewController : UserListViewModelDelegate {
    
    func datasourceUpdate() {
        tableView.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
    }
    
    func noUpdatesLoaded() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
    }
}
