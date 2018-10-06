//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/15/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class InformationPostingViewController: UIViewController {
    
    var studentData: [StudentInformation] = [StudentInformation]()
    
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    
    @IBOutlet weak var worldIconImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func navigationButtons () {
        navigationItem.title = "Add Location"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancel))
        
    }
    
    @IBAction func findLocation(_ sender: Any) {
        
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
