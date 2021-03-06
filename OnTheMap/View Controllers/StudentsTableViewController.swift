//
//  StudentsTableViewController.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/5/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController {
    
    
    
    @IBOutlet weak var mapsTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        getTableInfo()
    }
    
    func getTableInfo() {
        ParseClient.sharedInstance().getStudentsLocation{ [unowned self] (studentData, error) in
            if let studentData = studentData {
                StudentArrayDataSource.sharedInstance.arrayOfStudentInfo = studentData
                performUIUpdatesOnMain {
                    self.mapsTableView.reloadData()
                }
            } else {
                if let error = error {
                    self.alert(error: error)
                }
            }
        }
    }
    
    func alert(error: NSError) {
        let alert = UIAlertController(title: "\(error.localizedDescription)", message: "The request failed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return StudentArrayDataSource.sharedInstance.arrayOfStudentInfo.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinCell", for: indexPath)
        let item = StudentArrayDataSource.sharedInstance.arrayOfStudentInfo[indexPath.row]
        guard let firstName = item.firstName else {return cell}
        guard let lastName = item.lastName else {return cell}
        guard let mediaURL = item.mediaURL else {return cell}
        cell.imageView?.image = #imageLiteral(resourceName: "icon_pin")
        cell.textLabel?.text = "\(firstName) \(lastName)"
        cell.detailTextLabel?.text = mediaURL
        cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let web = StudentArrayDataSource.sharedInstance.arrayOfStudentInfo[indexPath.row]
        guard let webAddress = web.mediaURL else {return}
        let app = UIApplication.shared
        app.open(URL(string: webAddress)!)
    }
}

// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, and mentors
