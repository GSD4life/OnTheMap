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


struct JSONResponseKeys {
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
    
    struct JSONBodyKeys {
        static var objectId = JSONResponseKeys.objectId
        static var uniqueKey = Constants.uniqueKeyValue
        static var firstName = JSONResponseKeys.firstName
        static var lastName = JSONResponseKeys.lastName
        static var mapString = JSONResponseKeys.mapString
        static var mediaURL = JSONResponseKeys.mediaURL
        static var latitude: Double = 0.00
        static var longitude: Double = 0.00
    }
    
struct Constants {
    
    static let queryName = "where"
    static let queryLimit = "limit"
    static let value = "1"
    static let order = "order"
    static let updatedAt = "-updatedAt"
    static let scheme = "https"
    static let host = "parse.udacity.com"
    static let path = "/parse/classes/StudentLocation"
    static let uniqueKeyValue = UdacityClient.sharedInstance().userKey
//    11138462743 - actual user key
    static let queryValues = "{\"uniqueKey\": \"\(uniqueKeyValue)\"}"
}
    
    

}

// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, and mentors
