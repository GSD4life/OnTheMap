//
//  GCDBlackBox.swift
//  OnTheMap
//
//  Created by Shane Sealy on 7/20/18.
//  Copyright © 2018 Shane Sealy. All rights reserved.
//

import Foundation


func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}

