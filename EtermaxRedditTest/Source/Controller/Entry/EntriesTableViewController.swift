//
//  EntriesTableViewController.swift
//  EtermaxRedditTest
//
//  Created by José Valderrama on 11/1/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import UIKit
import RealmSwift

class EntriesTableViewController: UITableViewController {
    
    let cellIdentifier = "EntryTableViewCell"
    var entries : Results<RedditEntry>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
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

        cell.setData(entry: entries![indexPath.row])

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entryDetail = Controllers.instantiateEntryDetailTableViewController()
        entryDetail.entry = entries![indexPath.row]
        self.navigationController?.pushViewController(entryDetail, animated: true)
    }
}
