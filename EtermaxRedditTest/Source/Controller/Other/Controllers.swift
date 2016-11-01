//
//  Controllers.swift
//  EtermaxRedditTest
//
//  Created by José Valderrama on 11/01/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import Foundation

/// Use this to instantiate any controllers programatically.
struct Controllers {
    
    private init() {}
    
    static func instantiateHomeViewController() -> HomeViewController {
        return Storyboards.home.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    }
    
    static func instantiateEntriesTableViewController() -> EntriesTableViewController {
        return Storyboards.entry.instantiateViewController(withIdentifier: "EntriesTableViewController") as! EntriesTableViewController
    }
    
    static func instantiateEntryDetailTableViewController() -> EntryDetailTableViewController {
        return Storyboards.entry.instantiateViewController(withIdentifier: "EntryDetailTableViewController") as! EntryDetailTableViewController
    }
}
