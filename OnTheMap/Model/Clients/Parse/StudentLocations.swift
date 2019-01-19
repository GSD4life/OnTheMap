//
//  StudentLocations.swift
//  OnTheMap
//
//  Created by Shane Sealy on 8/27/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import Foundation

// Mark: StudentInformation Struct (model)


struct StudentInformation {
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    let createdAt: String?
    let updatedAt: String?
    let ACL: String?
    
// Mark: Initializers

// Construct a StudentInformation dictionary

init(dictionary: [String:AnyObject?]) {
    objectId = dictionary[ParseClient.JSONResponseKeys.objectId] as? String ?? ""
    uniqueKey = dictionary[ParseClient.JSONResponseKeys.uniqueKey] as? String ?? ""
    firstName = dictionary[ParseClient.JSONResponseKeys.firstName] as? String ?? ""
    lastName = dictionary[ParseClient.JSONResponseKeys.lastName] as? String ?? ""
    mapString = dictionary[ParseClient.JSONResponseKeys.mapString] as? String ?? ""
    mediaURL = dictionary[ParseClient.JSONResponseKeys.mediaURL] as? String ?? ""
    latitude = dictionary[ParseClient.JSONResponseKeys.latitude] as? Double ?? 0.0
    longitude = dictionary[ParseClient.JSONResponseKeys.longitude] as? Double ?? 0.0
    createdAt = dictionary[ParseClient.JSONResponseKeys.createdAt] as? String ?? ""
    updatedAt = dictionary[ParseClient.JSONResponseKeys.updatedAt] as? String ?? ""
    ACL = dictionary[ParseClient.JSONResponseKeys.ACL] as? String ?? ""
    
  }
    
static func userDataFromResults(_ results: [[String:AnyObject]]) -> [StudentInformation] {
    
    var student = [StudentInformation]()
    
    // iterate through array of dictionaries
    for result in results {
        student.append(StudentInformation(dictionary: result))
    }
    
    return student
  }
    
}
    struct UserInfo {
    static var objectId: String?
    static var uniqueKey: String?
    static var firstName: String?
    static var lastName: String?
    static var mapString: String?
    static var latitude: Double? = 0.0
    static var longitude: Double? = 0.0
        
        
    init(dictionary: [String: AnyObject?]){
    UserInfo.objectId = dictionary[ParseClient.JSONResponseKeys.objectId] as? String ?? ""
    UserInfo.uniqueKey = dictionary[UdacityClient.sharedInstance().userKey] as? String ?? ""
    UserInfo.firstName = dictionary[UdacityClient.sharedInstance().firstName] as? String ?? ""
    UserInfo.lastName = dictionary[UdacityClient.sharedInstance().lastName] as? String ?? ""
    UserInfo.mapString = dictionary[ParseClient.JSONResponseKeys.mapString] as? String ?? ""
    UserInfo.latitude = dictionary[ParseClient.JSONResponseKeys.latitude] as? Double ?? 0.0
    UserInfo.longitude = dictionary[ParseClient.JSONResponseKeys.longitude] as? Double ?? 0.0
   }
        
    static func postUserInfo(_ results: [[String: AnyObject]]) -> [StudentInformation] {
       
        var student = [StudentInformation]()
        
        for result in results {
            student.append(StudentInformation(dictionary: result))
        }
        
        return student
    }

   
}
    


// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, mentors, apple, cocoacasts, raywenderlich.com).

   
