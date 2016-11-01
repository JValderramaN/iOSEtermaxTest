//
//  EntriesTableViewController.swift
//  EtermaxRedditTest
//
//  Created by José Valderrama on 11/1/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import UIKit
import RealmSwift

let cellIdentifier = "EntryTableViewCell"

class EntriesTableViewController: UITableViewController {
    
    var entries : Results<RedditEntry>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(UINib(nibName: "EntryTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        entries = loadEntries()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func loadEntries() -> Results<RedditEntry>{
        let realm = try! Realm()
        return realm.objects(RedditEntry.self).sorted(byProperty: "created_utc", ascending: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EntryTableViewCell

        cell.loadData(entry: entries![indexPath.row])

        return cell
    }
}
