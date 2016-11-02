//
//  EntryDetailImageTableViewCell.swift
//  EtermaxRedditTest
//
//  Created by José Valderrama on 11/1/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import UIKit
import Kingfisher

class EntryDetailImageTableViewCell: UITableViewCell {
    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(_ imageURL : String?){
        if let imageURL = imageURL, !imageURL.isEmpty{
            imageview.kf.setImage(with: URL(string: imageURL))
        }else{
            imageview.image = UIImage(named: "redditNoImage")
        }
    }
}
