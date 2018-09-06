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


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

       
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
        cell.textLabel?.text = item.firstName
        cell.detailTextLabel?.text = item.lastName

        return cell
    }
    

 

}
