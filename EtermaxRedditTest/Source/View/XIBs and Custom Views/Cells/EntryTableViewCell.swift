//
//  EntryTableViewCell.swift
//  EtermaxRedditTest
//
//  Created by José Valderrama on 11/1/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import UIKit
import Kingfisher

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setData(entry : RedditEntry){
        if !entry.thumbnail.isEmpty{
            thumbnailImageView.kf.setImage(with: URL(string: entry.thumbnail))
        }else{
            thumbnailImageView.image = UIImage(named: "redditNoImage")
        }
        titleLabel.text = entry.title
    }
}
