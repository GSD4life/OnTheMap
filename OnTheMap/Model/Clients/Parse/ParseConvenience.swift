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

   func getStudentsLocation(_ completionHandler: @escaping (_ result: [StudentInformation]?, _ error: NSError?) -> Void) {

        let _ = taskForGet { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(nil, error)
            } else {
                
                if let results = results?[ParseClient.UsersLocation.studentsLocationResults] as? [[String:AnyObject]] {
                    
                    let result = StudentInformation.userDataFromResults(results)
                    completionHandler(result, nil)
                } else {
                    completionHandler(nil, NSError(domain: "getStudentsLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse get Students location"]))
                }
            }
        }
    }

    
    /* Testing function below for getting location info for one student
    
    func getLocationForOneStudent(_ completionHandler: @escaping (_ result: [StudentInformation]?, _ error: NSError?) -> Void) {
        
        let _ = taskForStudent(uniqueKey: StudentInfoKeys.uniqueKey, completionHandlerToGetLocation:  { (results,  error) in
    
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(nil, error)
            } else {
                
                if let results = results?[ParseClient.UsersLocation.studentsLocationResults] as? [[String:AnyObject]] {
                    
                    let info = StudentInformation.userDataFromResults(results)
                    completionHandler(info, nil)
                } else {
                    completionHandler(nil, NSError(domain: "getLocationForOneStudent parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse and get the location for a single student"]))
                }
            }
        }
    )} */














}