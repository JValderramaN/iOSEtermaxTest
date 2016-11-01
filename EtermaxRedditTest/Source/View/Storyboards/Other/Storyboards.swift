//
//  Storyboards.swift
//  iOSRappiTest
//
//  Created by José Valderrama on 9/24/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import UIKit

/// Stores the names of the project's storyboards
struct Storyboards {
    
    private init() {}
    
    static var home: UIStoryboard { return UIStoryboard(name: "Home", bundle: nil) }
    static var entry: UIStoryboard { return UIStoryboard(name: "Entry", bundle: nil) }
}
