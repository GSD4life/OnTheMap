//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/25/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

extension UdacityClient {
    
    
    
    
    func getPublicUserData(_ completionHandlerForUserData: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
       // var student = UdacityUser()
    
    let _ = getUserData { (results, error) in
        
        if let error = error {
            completionHandlerForUserData(nil, error)
        } else {
            if let results = results?[UdacityClient.JSONUserKey.user] as? [String:AnyObject] {
                
               // student.firstName = results["first_Name"] as? String
               // student.lastName = results["last_name"] as? String
               // student.uniqueKey = results["key"] as? String "key" identifier is used numerous times within the user dictionary?
                
            
            // guard case did not work and blocked being able to log in
            //guard case student.firstName = results["first_name"] as? String else {return}
            //guard case student.lastName = results["last_name"] as? String else {return}
            //guard case student.uniqueKey = results["ninpo"] as? String else {return}
            
             completionHandlerForUserData(results, nil)
            
            } else {
       completionHandlerForUserData(nil, NSError(domain: "getPublicUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse get Pulic User  location data"]))
       }
                
      }
                
   }
            
}
    
    
}
