//
//  ViewController.swift
//  OnTheMap
//
//  Created by Shane Sealy on 8/20/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // Mark: Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var uniqueData: [StudentInformation] = [StudentInformation]()
    
        
override func viewDidLoad() {
    super.viewDidLoad()
    self.mapView.delegate = self
    getMapInfo()
    
    }

    func getMapInfo() {
        
        ParseClient.sharedInstance().getStudentsLocation { (uniqueData, error) in
            if let uniqueData = uniqueData {
                self.uniqueData = uniqueData
                
                var annotations = [MKPointAnnotation]()
                
                performUIUpdatesOnMain {
                    for students in self.uniqueData {
                        
                        let lat = CLLocationDegrees(students.latitude!)
                        let long = CLLocationDegrees(students.longitude!)
                        
                        // The lat and long are used to create a CLLocationCoordinates2D instance.
                        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        
                        //let first = students["firstName"] as! String
                        let first = students.firstName
                        let last = students.lastName
                        let mediaURL = students.mediaURL
                        
                        // Here we create the annotation and set its coordiate, title, and subtitle properties
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = "\(String(describing: first)) \(String(describing: last))"
                        annotation.subtitle = mediaURL
                        print(annotation.title)
                        // Finally we place the annotation in an array of annotations.
                        annotations.append(annotation)
                    }
                    self.mapView.addAnnotations(annotations)
                }
            }
        }
    } 
 
}
