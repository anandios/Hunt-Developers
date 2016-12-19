//
//  GetUserPlugin.swift
//  Hunt Developers
//
//  Created by Anand Rahul Singh on 12/19/16.
//  Copyright © 2016 NoOrg. All rights reserved.
//

import Foundation

typealias CompletionBlock = (([User]?, Error?) -> Void)


protocol GetUsersPlugin {
    func getUsers(page: Int, completionBlock: CompletionBlock?)
}

class ConcreteGetUsersPlugin: GetUsersPlugin {
    let relativeUrlString = "/search/users?q=language:java&type=user&page="
    let baseUrlString: String
    let urlSession: URLSession
    
    init(baseUrlString: String, session: URLSession) {
        self.baseUrlString = baseUrlString
        self.urlSession = session
    }
    
    func getUsers(page: Int, completionBlock: CompletionBlock?) {
        let fullUrl = baseUrlString.appending(relativeUrlString).appending("\(page)")
        if let absoluteUrl = URL.init(string: fullUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            let request = URLRequest(url: absoluteUrl)
            let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                
                guard error == nil else { return }
                guard let data = data else { return }
                var usersArray: [User] = Array()
                
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                    let allUserData = parsedData["items"]
                    
                    if let allUserData = allUserData {
                        
                        _ = (allUserData as! Array).flatMap({ (dictionary: Dictionary<String, Any>) -> [User] in
                            let user = User.init(dictionary: dictionary)
                            usersArray.append(user)
                            return usersArray
                            })
                    }
                    
                    if let completionBlock = completionBlock {
                        completionBlock(usersArray, nil)
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            })
            
            task.resume()
        }
    }
}
