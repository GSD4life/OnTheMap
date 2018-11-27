//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/25/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

var studentFirstName = String()
var studentLastName = String()

extension UdacityClient {
    
    func getPublicUserData(_ completionHandlerForUserData: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
       // var student = UdacityUser()
    
    let _ = getUserData { (results, error) in
        
        if let error = error {
            completionHandlerForUserData(nil, error)
        } else {
            if let getUsersInfo = results?[JSONUserKey.user] as? [String:AnyObject] {
                guard let firstName = getUsersInfo["first_name"] as? String else {return}
                studentFirstName = firstName
                print(studentFirstName)
                guard let lastName = getUsersInfo["last_name"] as? String else {return}
                studentLastName = lastName
                print(studentLastName)
                
             completionHandlerForUserData(getUsersInfo, nil)
            
            } else {
       completionHandlerForUserData(nil, NSError(domain: "getPublicUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse get Pulic User  location data"]))
       }
                
      }
                
   }
            
}
    
    
}
