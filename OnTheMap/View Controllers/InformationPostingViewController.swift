//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Shane Sealy on 9/15/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class InformationPostingViewController: UIViewController {
    
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(ninpo))
        
    }
    
    @IBAction func findLocation(_ sender: Any) {
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func ninpo() {
     print("Hello")
    }
}
