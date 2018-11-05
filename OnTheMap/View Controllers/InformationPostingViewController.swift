//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/15/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit
import MapKit


class InformationPostingViewController: UIViewController, MKMapViewDelegate {

    var studentData: [StudentInformation] = [StudentInformation]()
    
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    @IBOutlet weak var worldIconImageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var findLocationButton: UIButton!
    
    
    lazy var geocoder = CLGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        navigationButtons()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     showOrHideButtonAndMap()
     addingViewsToLayout()

    }
    
    func addingViewsToLayout() {
        view.addSubview(topView)
        view.addSubview(middleView)
        view.addSubview(bottomView)
    }
    
    func showOrHideButtonAndMap() {
        if locationTextField.text == "" || URLTextField.text == "" {
            mapView.isHidden = true
            finishButton.isHidden = true
        } else {
          mapView.isHidden = false
          finishButton.isHidden = false
        }
    }

    func missingInfo() {
        if locationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true || URLTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            alertMessage()
        }
    }
    
    
    func forwardGeocodeAddress() {
        guard let location = locationTextField.text else {return}
        let address = "\(location)"
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
            guard let placemark = placemarks else {return}
            print(placemark)
        }
           findLocationButton.isHidden = true
    }
    
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        missingInfo()
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            
        } else {
            var location: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
                
                guard let location = location else {return}
                let lat = location.coordinate.latitude
                let long = location.coordinate.longitude
                //let initialLocation = CLLocation(latitude: lat, longitude: long)
                //centerMapOnLocation(location: initialLocation)
                var coordinate = CLLocationCoordinate2D()
                coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = locationTextField.text
                annotation.subtitle = URLTextField.text
                self.mapView.addAnnotation(annotation)
            }
            
            if let location = location {
                let coordinate = location.coordinate
                print("The coordinates are Lat: \(coordinate.latitude) and Long: \(coordinate.longitude)"
                    
            )}
            
        }
    
    }
    
    func alertMessage() {
        let ac = UIAlertController(title: "Missing a location and/or a valid URL address", message: "Please enter a valid URL using https:// and a location", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    

    
    func navigationButtons () {
        navigationItem.title = "Add Location"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancel))
        
    }
    
    func topAndMiddleViewHidden() {
        topView.isHidden = true
        middleView.isHidden = true
    }
    
    func visibleViewsForMap() {
    mapView.isHidden = false
    bottomView.isHidden = true
    }
    
    @IBAction func findLocation(_ sender: Any) {
        
        forwardGeocodeAddress()
        visibleViewsForMap()
        finishButton.isHidden = false
        topAndMiddleViewHidden()
    }
    
    
    func postingALocation() {
        ParseClient.sharedInstance().postingStudentLocation { (data, error) in
            if error != nil {
                print(error ?? "empty error")
            } else {
                if let data = data {
                    print(data)
                }
            }
        }
    }
    
    func singleStudentLocation() {
        ParseClient.sharedInstance().getLocationForOneStudent { (studentData, error) in
            if let studentData = studentData {
                self.studentData = studentData
                performUIUpdatesOnMain {
                  // ParseClient.mapsTableView.reloadData()
                }
            } else {
                print(error ?? "empty error")
            }
        }
    }
    

    @objc func cancel() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    


    
    // Mark: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("delegate one reached")
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
        print("delegate two reached")
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!)
            }
        }
    }

}
