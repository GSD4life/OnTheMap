//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Shane Sealy on 8/24/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class ParseClient: NSObject {
    
    
    // Mark: Network code used to get student(s) inforamtion
    func taskForGet(completionHandlerToGetData: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask{
       
    var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
           
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerToGetData(nil, NSError(domain: "taskForGet", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            
            print(String(data: data, encoding: .utf8)!)
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerToGetData)
            
        }
        
        task.resume()
        
        return task
    
    }
    
    // Mark: Network code used to get information for a single student
    func taskForStudent(parameters: [String:AnyObject],  completionHandlerToGetLocation: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        var parameterswithKey = parameters
        
        let request = NSMutableURLRequest(url: URLFromParameters(parameterswithKey))
        
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerToGetLocation(nil, NSError(domain: "GetLocationForStudent", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            print(String(data: data, encoding: .utf8)!)
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerToGetLocation)
            
        }
        
        task.resume()
        
        return task
    
    
    }
    
    // Mark: Network code used to post info to API
    func taskForPost(completionHandlerForPost: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        let json = "{\"uniqueKey\": \"\(Constants.UniqueKeyValue)\", \"firstName\": \"\(JSONBodyKeys.firstName)\", \"lastName\": \"\(JSONBodyKeys.lastName)\",\"mapString\": \"\(JSONBodyKeys.mapString)\", \"mediaURL\": \"\(JSONBodyKeys.mediaURL)\",\"latitude\": \(JSONBodyKeys.latitude), \"longitude\": \(JSONBodyKeys.longitude)}"
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForPost(nil, NSError(domain: "completionHandlerForPost", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            
            print(String(data: data, encoding: .utf8)!)
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPost)
            
        }
        
        task.resume()
        
        return task
        
    }
    
    // Mark: Network code used so a student can update and/or put a new location on the map
    func taskForPuttingALocation(completionHandlerForPutting: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        let json = "{\"uniqueKey\": \"\(Constants.UniqueKeyValue)\", \"firstName\": \"\(JSONBodyKeys.firstName)\", \"lastName\": \"\(JSONBodyKeys.lastName)\",\"mapString\": \"\(JSONBodyKeys.mapString)\", \"mediaURL\": \"\(JSONBodyKeys.mediaURL)\",\"latitude\": \(JSONBodyKeys.latitude), \"longitude\": \(JSONBodyKeys.longitude)}"
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation/XRMN9cf016")!)
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json.data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForPutting(nil, NSError(domain: "completionHandlerForPutting", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
                
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            
            print(String(data: data, encoding: .utf8)!)
            
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPutting)
            
        }
        
        task.resume()
        
        return task
        
    }
    
    // Mark: Helper function
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    // Mark: Shared Instance
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
    // Mark: Helper function to build a URL so all items are properly escaped/allowed.
    private func URLFromParameters(_ parameters: [String:AnyObject]) -> URL {
        
    var components = URLComponents()
    components.scheme = ParseClient.Constants.scheme
    components.host = ParseClient.Constants.host
    components.path = ParseClient.Constants.path
    components.queryItems = [URLQueryItem]()
    
    
    for (key, value) in parameters {
        let queryItem = URLQueryItem(name: key, value: "\(value)")
        components.queryItems!.append(queryItem)
    }
    
    return components.url!
}
    
    
    
    
    

    

}
