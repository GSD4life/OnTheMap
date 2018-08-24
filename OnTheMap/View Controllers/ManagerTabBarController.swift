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
        
        let plusSignbutton = UIButton(type: .system)
        plusSignbutton.setImage(#imageLiteral(resourceName: "icon_addpin"), for: .normal)
        
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: plusSignbutton), UIBarButtonItem(customView: refreshButton)]

        
    }
    
    @objc func cancel(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func logout() {
     UdacityClient.sharedInstance().logout(completionHandlerToLogout: { (data, error) in
        
        if error != nil {
            
            let alert = UIAlertController(title: "Logout Failed", message: "Please try again.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            
        } else {
            
            self.cancel(sender: data!)
        }
        
        
        }
    )}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
