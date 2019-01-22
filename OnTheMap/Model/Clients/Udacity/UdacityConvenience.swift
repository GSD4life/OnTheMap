//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/25/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit


extension UdacityClient {
    
    func authenticateUser(email: String, password: String, CompletionHandlerToAuthenticate: @escaping (_ result: Any?, _ error: Error?) -> Void) {
        
        
        login(email: email, password: password) { [unowned self] (result, error) in
            if let result = result {
                guard let accountKey = result["account"] as? [String:AnyObject] else {return}
                guard let userKey = accountKey["key"] as? String else {return}
                self.userKey = userKey
                CompletionHandlerToAuthenticate(accountKey, nil)
            } else {
                if let error = error {
             CompletionHandlerToAuthenticate(nil, error)
                    
                }
            }
        }
        
    }
    
    
    // Mark: Function used to call and get public user information
    func getPublicUserData(_ completionHandlerForUserData: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
      
        let _ = getUserData(key: self.userKey) { [unowned self] (results, error) in
        
        //print(self.userKey)
        if let error = error {
            
             completionHandlerForUserData(nil, error)
            
        } else {
            if let results = results {
                guard let firstName = results["first_name"] as? String else {return}
                guard let LastName = results["last_name"] as? String else {return}
                self.firstName = firstName
                self.lastName = LastName
                
                let _ = UdacityUser(userKey: self.userKey, firstName: self.firstName, lastName: self.lastName)
                
                completionHandlerForUserData(results, nil)

            } else {
              
                completionHandlerForUserData(nil, NSError(domain: "getPublicUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse get Pulic User  location data"]))
            
            }
        }
     }
  }


}
// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, and mentors
