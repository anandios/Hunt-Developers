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
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                    let allUserData = parsedData["items"]
                    if let allUserData = allUserData {
                        print(allUserData)
                    }
                    
                    if let completionBlock = completionBlock {
                        completionBlock([], nil)
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
                
            })
            
            task.resume()
        }
    }
}
