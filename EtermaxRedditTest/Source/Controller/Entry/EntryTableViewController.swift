//
//  EntryDetailTableViewController.swift
//  EtermaxRedditTest
//
//  Created by José Valderrama on 11/1/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import UIKit

class EntryDetailTableViewController: UITableViewController {
    
    let detailCellIdentifier = "EntryDetailInfoTableViewCell"
    let imageCellIdentifier = "EntryDetailImageTableViewCell"
    let cellOptions = ["Title:", "Author:", "ID:", "Number of comments:", "Subreddit:", "Created:", "Link:"]
    
    var entry : RedditEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.register(UINib(nibName: detailCellIdentifier, bundle: nil), forCellReuseIdentifier: detailCellIdentifier)
        self.tableView.register(UINib(nibName: imageCellIdentifier, bundle: nil), forCellReuseIdentifier: imageCellIdentifier)
        
        navigationItem.title = "Entry Detail"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        let row = indexPath.row
        
        if row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: imageCellIdentifier, for: indexPath) as! EntryDetailImageTableViewCell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as! EntryDetailInfoTableViewCell
        }
        
        switch row {
        case 0:
            (cell as! EntryDetailImageTableViewCell).setData(entry.thumbnail)
        case 1:
            (cell as! EntryDetailInfoTableViewCell).setData(cellOptions[row-1], detailInfoLabel: entry.title)
        case 2:
            (cell as! EntryDetailInfoTableViewCell).setData(cellOptions[row-1], detailInfoLabel: entry.author)
        case 3:
            (cell as! EntryDetailInfoTableViewCell).setData(cellOptions[row-1], detailInfoLabel: entry.id)
        case 4:
            (cell as! EntryDetailInfoTableViewCell).setData(cellOptions[row-1], detailInfoLabel: "\(entry.num_comments)")
        case 5:
            (cell as! EntryDetailInfoTableViewCell).setData(cellOptions[row-1], detailInfoLabel: entry.subreddit)
        case 6:
            if let date = entry.created_utc{
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = DateFormatter.Style.long
                let dateString = dateFormatter.string(from: date)
                (cell as! EntryDetailInfoTableViewCell).setData(cellOptions[row-1], detailInfoLabel: dateString)
            }
        case 7:
            (cell as! EntryDetailInfoTableViewCell).setData(cellOptions[row-1], detailInfoLabel: entry.link, moreInfoEnable: true)
        default:
            break
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 7{
            let url = entry.link
            if let url = URL(string: url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row == 7
    }
}
