//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/25/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit


extension UdacityClient {
    
    
    // Mark: Function used to call and get public user information
    func getPublicUserData(_ completionHandlerForUserData: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
       // var student = UdacityUser()
    
    let _ = getUserData { (results, error) in
        
        if let error = error {
             assert(error == error, "assert error message")
             completionHandlerForUserData(nil, NSError(domain: "getPublicUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse get Pulic User  location data"]))
        } else {
            if let results = results?["email"] as? [String:AnyObject] {
                // Using the "user" key does not work as map does not populate and app stalls at login page. The user key stopped working on 11/28/18 when udacity began updating their URLs for getting public user data and login. No information provided by support.
                //guard let firstName = results["first_name"] as? String else {return}
                //print(firstName) - not able to retrieve first name
            
             completionHandlerForUserData(results, nil)
                
            }
        }
    }
}
    
    
}

// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, mentors, apple, cocoacasts, raywenderlich.com).
