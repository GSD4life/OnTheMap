//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Shane Sealy on 8/4/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import Foundation

// Mark: - UdacityClient : NSObject
class UdacityClient : NSObject {
    
// Mark: Properties

// shared session
   var session = URLSession.shared
    
    
// Mark: Initializers
   override init() {
     super.init()
    }
    
    

// given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: [String:AnyObject]?, _ error: NSError?) -> Void) {
    
        var parsedResult: [String:AnyObject]! = nil
    do {
        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
    } catch {
        let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
        completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
    }
    
        completionHandlerForConvertData(parsedResult, nil)
}

// create a URL from parameters
private func URLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
    
    var components = URLComponents()
    components.scheme = Constants.URL.ApiScheme
    components.host = Constants.URL.ApiHost
    components.path = Constants.URL.ApiPath + (withPathExtension ?? "")
    components.queryItems = [URLQueryItem]()
    
    for (key, value) in parameters {
        let queryItem = URLQueryItem(name: key, value: "\(value)")
        components.queryItems!.append(queryItem)
    }
    
    return components.url!
}

// MARK: Shared Instance

class func sharedInstance() -> UdacityClient {
    struct Singleton {
        static var sharedInstance = UdacityClient()
    }
    return Singleton.sharedInstance
}
    
}
