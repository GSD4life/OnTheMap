//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Shane Sealy on 8/4/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit


// Mark: StudentInformation
    struct StudentInformation {
        
        static var firstName: String? = ""
        static var lastName: String? = ""
        static var mediaURL: String? = ""
        static var latitude: Double? = 0.0
        static var longitude: Double? = 0.0
     
        init(results: [String: Any]) {
            StudentInformation.firstName = results["firstName"] as? String
            StudentInformation.lastName = results["LastName"] as? String
            StudentInformation.mediaURL = results["mediaURL"] as? String
            StudentInformation.latitude = results["latitude"] as? Double
            StudentInformation.longitude = results["longitude"] as? Double
            
        }

        

    
    
}
