//
//  MapViewController.swift
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
    
    //var uniqueData: [StudentInformation] = [StudentInformation]()
    
        
override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
}
    
override func viewWillAppear(_ animated: Bool) {
    getMapInfo()
}

    func getMapInfo() {
    
        
        ParseClient.sharedInstance().getStudentsLocation() { [unowned self] (uniqueData, error) in
            if let error = error {
                self.alertIssueForMap(error: error)
            } else {
            
            if let uniqueData = uniqueData {
                StudentArrayDataSource.sharedInstance.arrayOfStudentInfo = uniqueData
                
                var annotations = [MKPointAnnotation]()
                
                
                performUIUpdatesOnMain {
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    
                    for students in StudentArrayDataSource.sharedInstance.arrayOfStudentInfo {
                        
                        let lat = CLLocationDegrees(students.latitude ?? 0)
                        let long = CLLocationDegrees(students.longitude ?? 0)
                        
                        // The lat and long are used to create a CLLocationCoordinates2D instance.
                        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        
                        //let first = students["firstName"] as! String
                        guard let first = students.firstName else {return}
                        guard let last = students.lastName else {return}
                        guard let mediaURL = students.mediaURL else {return}
                        
                        // Here we create the annotation and set its coordinate, title, and subtitle properties
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = "\(first) \(last)"
                        annotation.subtitle = mediaURL
    
                        //print(String(describing:annotation.title ?? ""))
                        // Finally we place the annotation in an array of annotations.
                        annotations.append(annotation)
                    
                    }
                    // When the array is complete, we add the annotations to the map.
                    self.mapView.addAnnotations(annotations)
                    
                }
            }
        }
    }
    
}
    func alertIssueForMap(error: NSError) {
        
        let ac = UIAlertController(title: "\(error.localizedDescription)", message: "The request failed", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
        
    }
    
// Mark: - MKMapViewDelegate

// Here we create a view with a "right callout accessory view". You might choose to look into other
// decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
// method in TableViewDataSource.

func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    let reuseId = "pin"
    
     var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
    
    if pinView == nil {
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView!.canShowCallout = true
        pinView!.pinTintColor = .red
        pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    
    }
    else {
        pinView!.annotation = annotation
    }
    
    return pinView
}


// This delegate method is implemented to respond to taps. It opens the system browser
// to the URL specified in the annotationViews subtitle property.
func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
    if control == view.rightCalloutAccessoryView {
        let app = UIApplication.shared
        if let toOpen = view.annotation?.subtitle! {
            app.open(URL(string: toOpen)!)
        }
    }
}

}

// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, and mentors
