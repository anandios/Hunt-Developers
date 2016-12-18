//
//  UsersListViewController.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/18/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import UIKit

class UsersListViewController: UITableViewController {
    
    let model = UserListViewModel()
    @IBOutlet var noContentView: UIView!
    @IBOutlet var noContentLabel: UILabel!
    var contentTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = model.title
        
        contentTableView = self.tableView
        self.view = noContentView
        self.model.delegate = self
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { [weak self](timer) in
            if let tableView = self?.contentTableView {
                self?.view = tableView
                tableView.reloadData()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfItems
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
        cell.name.text = model.name
        cell.username.text = model.username
        cell.joinedAt.text = model.joinedAt
    
        return cell
    }
    
    override public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 10.0 {
            self.model.didReachLastItem()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "LoadDetailsSegue", sender: self)
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
