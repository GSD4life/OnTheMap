//
//  StudentsTableViewController.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/5/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController {
    
    var studentData = [StudentInformation]()

    @IBOutlet weak var mapsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

       
    }

    override func viewWillAppear(_ animated: Bool) {
        ParseClient.sharedInstance().getStudentsLocation{ (studentData, error) in
            if let studentData = studentData {
                self.studentData = studentData
                    performUIUpdatesOnMain {
                        self.mapsTableView.reloadData()
                    }
                } else {
                    print(error ?? "empty error")
                }
            }
        }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinCell", for: indexPath)
        let item = self.studentData[indexPath.row]
        guard let firstName = item.firstName else {return cell}
        guard let lastName = item.lastName else {return cell}
        cell.imageView?.image = #imageLiteral(resourceName: "icon_pin")
        cell.textLabel?.text = "\(firstName) \(lastName)"
        cell.detailTextLabel?.text = item.mediaURL
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
       return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ManagerTabBarController") as! ManagerTabBarController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
 
}
