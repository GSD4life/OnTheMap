//
//  ManagerTabBarController.swift
//  OnTheMap
//
//  Created by Shane Sealy on 8/21/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import UIKit

class ManagerTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        
    }
    
    func setUpTabBar() {
        navigationItem.title = "On The Map"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(cancel))
        
        let refreshButton = UIButton(type: .system)
        refreshButton.setImage(#imageLiteral(resourceName: "icon_refresh"), for: .normal)
        
        let plusSignbutton = UIButton(type: .system)
        plusSignbutton.setImage(#imageLiteral(resourceName: "icon_addpin"), for: .normal)
        
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: plusSignbutton), UIBarButtonItem(customView: refreshButton)]
    
    
        
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
