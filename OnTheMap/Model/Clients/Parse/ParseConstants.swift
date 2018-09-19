//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Shane Sealy on 8/24/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//
import UIKit
import MapKit

extension ParseClient {


struct StudentInfoKeys {
    static let objectId = "objectId"
    static let uniqueKey = "uniqueKey"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let mapString = "mapString"
    static let mediaURL = "mediaURL"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let createdAt = "createdAt"
    static let updatedAt = "updatedAt"
    static let ACL = "ACL"
}

struct UsersLocation {
   static let studentsLocationResults = "results"
}
    
struct Constants {
    
    static let queryName = "where"
    
    
    static let scheme = "https"
    static let host = "parse.udacity.com"
    static let path = "/parse/classes/StudentLocation"
    static let UniqueKeyValue = "1234"
    static let queryValues = "{\"uniqueKey\": \"1234\"}"
   
    
    
    }
    
    

}

