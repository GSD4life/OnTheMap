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

    
     //Testing function below for getting location info for one student
    
     func getLocationForOneStudent(_ completionHandlerForOneStudent: @escaping (_ result: [StudentInformation]?, _ error: NSError?) -> Void) {
        
        let parameters = [Constants.queryName:Constants.queryValues]
        
        let _ = taskForStudent(parameters: parameters as [String:AnyObject], completionHandlerToGetLocation:  { (results, error) in
    
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForOneStudent(nil, error)
            } else {
                
                 if let results = results?[ParseClient.UsersLocation.studentsLocationResults] as? [[String:AnyObject]] {
                    
                   let result = StudentInformation.userDataFromResults(results)
                    completionHandlerForOneStudent(result, nil)
                    
                } else {
                    completionHandlerForOneStudent(nil, NSError(domain: "getLocationForOneStudent parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse and get the location for a single student"]))
                }
            }
        }
    )}
    
    
    
    func postingStudentLocation( completionHandlerForPostingLocation: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
        
        
        let jsonbody = "{\"uniqueKey\": \"\(ParseClient.Constants.UniqueKeyValue)\", \"firstName\": \"\(ParseClient.JSONBodyKeys.firstName)\", \"lastName\": \"\(ParseClient.JSONBodyKeys.lastName)\",\"mapString\": \"\(ParseClient.JSONBodyKeys.mapString)\", \"mediaURL\": \"\(ParseClient.JSONBodyKeys.mediaURL)\",\"latitude\": \"\(ParseClient.JSONBodyKeys.latitude)\", \"longitude\": \"\(ParseClient.JSONBodyKeys.longitude)\"}"
        
        let _ = taskForPost(jsonBody: jsonbody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForPostingLocation(nil, error)
            } else {
                if let results = results?[ParseClient.JSONResponseKeys.objectId] as? String {
                    completionHandlerForPostingLocation(results, nil)
                } else {
                    completionHandlerForPostingLocation(nil, NSError(domain: "postingStudentLocation", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postingStudentLocation"]))
                }
            }
        }
    }

















}
