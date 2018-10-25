//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/15/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit
import CoreLocation


class InformationPostingViewController: UIViewController {

    var studentData: [StudentInformation] = [StudentInformation]()
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    @IBOutlet weak var worldIconImageView: UIImageView!
    
    @IBOutlet weak var findLocationButton: UIButton!
    
    lazy var geocoder = CLGeocoder()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationButtons()
        
    }
    
    

    func missingInfo() {
        if locationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true || URLTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            alertMessage()
        }
    }
    
    func geocodeAddress() {
        guard let location = locationTextField.text else {return}
        let address = "\(location)"
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }

    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        locationTextField.isHidden = false
        URLTextField.isHidden = false
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                print("The coordinates are Lat: \(coordinate.latitude) and Long: \(coordinate.longitude)"
            )}
            
        }
    
    }
    
    
    // Apple provided code to forward gecode an address into coordinates
    func getCoordinate(addressString: String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
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
    
    @IBAction func findLocation(_ sender: Any) {
        
        geocodeAddress()
        postingALocation()
        
        /*getCoordinate(addressString: locationTextField.text!, completionHandler: { (location, error) in
            if let error = error {
                print(error)
                self.missingInfo()
            } else {
               print(location)
                }
           
        }*/
      
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
        
    
}
