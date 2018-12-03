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
   var uniqueKey: String? = "no key"
   var firstName: String? = "no first name"
   var lastName: String? = "no last name"

    
    init(dictionary: [String:AnyObject?]) {
        
        uniqueKey = dictionary["key"] as? String ?? ""
        firstName = dictionary["first_name"] as? String ?? ""
        lastName = dictionary["last_name"] as? String ?? ""
        
        
    }

}
    
struct JSONUserKey {
    static let user = "user"

}

}
