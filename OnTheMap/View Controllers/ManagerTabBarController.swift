//
//  ManagerTabBarController.swift
//  OnTheMap
//
//  Created by Shane Sealy on 8/21/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class ManagerTabBarController: UITabBarController {
    
var refresh = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarButtons()
        
    }
    
    func navigationBarButtons() {
        navigationItem.title = "On The Map"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logout))
        
        let refreshButton = UIButton(type: .system)
        refreshButton.setImage(#imageLiteral(resourceName: "icon_refresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(ManagerTabBarController.refreshViewControllers), for: .touchUpInside)
        
        let plusSignButton = UIButton(type: .system)
        plusSignButton.setImage(#imageLiteral(resourceName: "icon_addpin"), for: .normal)
        plusSignButton.addTarget(self, action: #selector(moveToInformationPostingView), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: plusSignButton), UIBarButtonItem(customView: refreshButton)]

    }
    
   @objc func refreshViewControllers() {
        
    if (self.selectedViewController?.isKind(of: MapViewController.self))! {
             let controller = self.selectedViewController as! MapViewController
            controller.getMapInfo()
        } else if (self.selectedViewController?.isKind(of: StudentsTableViewController.self))! {
            let controller = self.selectedViewController as! StudentsTableViewController
            controller.getTableInfo()
        } else {
            print("trying to refresh a view")
        }
    }
    
    @objc func moveToInformationPostingView() {
        let InfoPostingVC = self.storyboard?.instantiateViewController(withIdentifier: "InformationPostingViewController") as! InformationPostingViewController
        navigationController?.pushViewController(InfoPostingVC, animated: true)
    }
    
    
    @objc func cancel(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func logout() {
     UdacityClient.sharedInstance().logout { [unowned self] (data, error) in
        
        if error != nil {
            
            let alert = UIAlertController(title: "Logout Failed", message: "Please try again.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            
        } else {
            
            self.cancel(sender: data!)
        }
        
        
        }
    }

    

}

// Sources:
// Udacity IOS program (Network Requests & GCD), Udacity forums, mentors, apple, cocoacasts, raywenderlich.com).
