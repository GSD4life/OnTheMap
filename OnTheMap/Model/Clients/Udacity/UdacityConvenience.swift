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
        
        print(self.userKey)
        if let error = error {
            
             assert(error == error, "assert error message")
             completionHandlerForUserData(nil, NSError(domain: "getPublicUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse get Pulic User  location data"]))
        } else {
            if let results = results {
                guard let firstName = results["first_name"] as? String else {return}
                guard let LastName = results["last_name"] as? String else {return}
                self.firstName = firstName
                self.lastName = LastName
                
                let loggedInUser = UdacityUser(userKey: self.userKey, firstName: self.firstName, lastName: self.lastName)
                print(loggedInUser)

            }
                /* Using the "user" key does not work as map does not populate and app stalls at login page. The user key stopped working on 11/28/18 when udacity began updating their URLs for getting public user data and login. No information provided by support. */
//                let firstName = results["first_name"] as? String ?? "Ich"
//                self.firstName = firstName
//                let lastName = results["last_name"] as? String ?? "Ni"
//                self.lastName = lastName
//                print(firstName, lastName, terminator: "")
             completionHandlerForUserData(results, nil)
                
            }
        }
    }
}
    
    


// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, mentors, apple, cocoacasts, raywenderlich.com).
