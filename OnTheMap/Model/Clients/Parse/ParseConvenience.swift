//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/5/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit
import Foundation

extension ParseClient {
    
    
   // Mark: Function used to get Student(s) location to populate MapView
   func getStudentsLocation(_ completionHandlerForStudents: @escaping (_ result: [StudentInformation]?, _ error: NSError?) -> Void) {

        let _ = taskForGet { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForStudents(nil, error)
            } else {
                
                if let results = results?[ParseClient.UsersLocation.studentsLocationResults] as? [[String:AnyObject]] {
                    
                    
                    let result = StudentInformation.userDataFromResults(results)
                    completionHandlerForStudents(result, nil)
                } else {
                    completionHandlerForStudents(nil, NSError(domain: "getStudentsLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse get Students location"]))
                }
            }
        }
    }

    // Mark: Function used to get a single student location. The response/data is formatted into the model (StudentInformation Struct) for a single person.
     func getLocationForOneStudent(_ completionHandlerForOneStudent: @escaping (_ result: [StudentInformation]?, _ error: NSError?) -> Void) {
        
        let parameters = [Constants.queryName:Constants.queryValues, Constants.queryLimit: Constants.value, Constants.order:Constants.updatedAt]
        
        let _ = taskForStudent(parameters: parameters as [String:AnyObject], completionHandlerToGetLocation: { (results, error) in
    
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForOneStudent(nil, error)
            } else {
                
                 if let results = results?[ParseClient.UsersLocation.studentsLocationResults] as? [[String:AnyObject]] {
                    
                    for (_, objectId) in results.enumerated() {
                        guard let objectId = objectId["objectId"] as? String else {
                            print("Could not find objectId")
                            return
                        }
                        StudentInformation.UserInfo.objectId = objectId
                    }
                    
                   let result = StudentInformation.userDataFromResults(results)
                    completionHandlerForOneStudent(result, nil)
                    
                } else {
                    completionHandlerForOneStudent(nil, NSError(domain: "getLocationForOneStudent parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse and get the location for a single student"]))
                }
            }
        }
    )}
    
    // Mark: Function used to post a location to the server.
    func postingStudentLocation(mapString: String, mediaURL: String, latitude: Double, longitude: Double, _ completionHandlerForPostingLocation: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
        
        let _ = taskForPost(mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForPostingLocation(nil, error)
            } else {
                if let results = results {
                    guard let objectId = results["objectId"] as? String else {
                        print("Could not find objectId")
                        return
                    }
                    StudentInformation.UserInfo.objectId = objectId
                    completionHandlerForPostingLocation(results, nil)
                } else {
                    completionHandlerForPostingLocation(nil, NSError(domain: "postingStudentLocation", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postingStudentLocation"]))
                }
            }
        }
    }
    
    // Mark: Function used allow a user to put a new location to the server.
    func puttingAStudentLocation(mapString: String, mediaURL: String, latitude: Double, longitude: Double, _ completionHandlerForPuttingLocation: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
        
        let _ = taskForPuttingALocation(id: StudentInformation.UserInfo.objectId ?? "", mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForPuttingLocation(nil, error)
            } else {
                if let results = results?[JSONResponseKeys.updatedAt] as? String {
                    completionHandlerForPuttingLocation(results, nil)
                } else {
                    completionHandlerForPuttingLocation(nil, NSError(domain: "puttingStudentLocation", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse puttingStudentLocation"]))
                }
            }
        }
    }

}

// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, mentors, apple, cocoacasts, raywenderlich.com).
