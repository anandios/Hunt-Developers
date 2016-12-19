//
//  UserDetailsViewController.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/17/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    let profileSectionIndex = 0
    let numberOfRowsInProfileSection = 1
    let profileRowHeight = CGFloat(92)
    let totalSections = 2
    let numberOfRowsInDetailsSection = 5
    let detailRowHeight = CGFloat(44)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
    }
}

extension UserDetailsViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == profileSectionIndex) {
            return numberOfRowsInProfileSection
        }
        
        return numberOfRowsInDetailsSection
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == profileSectionIndex) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTitleCellIdentifier") as! ProfileTitleCell
            
            cell.fullName.text = "Bazinga Bla bla bla"
            cell.jobTitle.text = "iOS Developer"
            
            return cell
        }
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreInfoCellIdentifier") as! MoreInfoCell
        cell.titleLabel.text = "email"
        cell.detailLabel.text = "aa@bb.cc"
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return totalSections
    }
}

extension UserDetailsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == profileSectionIndex {
            return profileRowHeight
        }
        
        return detailRowHeight
    }
}
