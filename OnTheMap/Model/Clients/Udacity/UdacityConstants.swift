//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Shane Sealy on 8/4/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

extension UdacityClient {

struct UdacityUser {
   var uniqueKey: String?
   var firstName: String?
   var lastName: String?

    
    init(dictionary: [String:AnyObject?]) {
        
        uniqueKey = dictionary["key"] as? String ?? "1234"
        firstName = dictionary["first_name"] as? String ?? "Ich"
        lastName = dictionary["last_name"] as? String ?? "Ni"
        
        
    }

}
    
struct JSONUserKey {
    static let user = "user"

}

}

// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, mentors, apple, cocoacasts, raywenderlich.com).
