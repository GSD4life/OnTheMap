//
//  StudentArrayDataSource.swift
//  OnTheMap
//
//  Created by Shane Sealy on 1/23/19.
//  Copyright © 2019 Shane Sealy. All rights reserved.
//

import UIKit

class StudentArrayDataSource: NSObject {
    
    static let sharedInstance = StudentArrayDataSource()
    
    var arrayOfStudentInfo = [StudentInformation]()

}
