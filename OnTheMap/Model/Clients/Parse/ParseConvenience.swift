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
        
        let _ = taskForStudent(parameters: parameters as [String:AnyObject], completionHandlerToGetLocation:  { (results, error) in
    
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForOneStudent(nil, error)
            } else {
                
                 if let results = results?[ParseClient.UsersLocation.studentsLocationResults] as? [[String:AnyObject]] {
                    
                    /*Code below gets the object id out of the array of dicitionaries titled results
                    for (_, studentDictionary) in results.enumerated() {
                        guard let individualObjectId = studentDictionary["objectId"] as? String else {return}
                        let studentObjectId = individualObjectId
                        print(studentObjectId)
                        
                    }*/
                    
                   let result = StudentInformation.userDataFromResults(results)
                    completionHandlerForOneStudent(result, nil)
                    
                } else {
                    completionHandlerForOneStudent(nil, NSError(domain: "getLocationForOneStudent parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse and get the location for a single student"]))
                }
            }
        }
    )}
    
    // Mark: Function used to post a location to the server.
    func postingStudentLocation(_ completionHandlerForPostingLocation: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
        
        let _ = taskForPost { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForPostingLocation(nil, error)
            } else {
                if let results = results?[JSONResponseKeys.objectId] as? String {
                    //let studentObjectId = results
                    completionHandlerForPostingLocation(results, nil)
                } else {
                    completionHandlerForPostingLocation(nil, NSError(domain: "postingStudentLocation", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postingStudentLocation"]))
                }
            }
        }
    }
    
    // Mark: Function used allow a user to put a new location to the server.
    func puttingAStudentLocation(_ completionHandlerForPuttingLocation: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
        
        let _ = taskForPuttingALocation { (results, error) in
            
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
