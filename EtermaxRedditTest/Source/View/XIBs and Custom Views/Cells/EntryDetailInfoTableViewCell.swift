//
//  EntryDetailInfoTableViewCell.swift
//  EtermaxRedditTest
//
//  Created by José Valderrama on 11/1/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import UIKit

class EntryDetailInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var detailInfoLabel: UILabel!
    @IBOutlet weak var moreInfoLabel: UILabel!
    
    func setData(_ infoLabel : String, detailInfoLabel : String?, moreInfoEnable : Bool = false){
        self.infoLabel.text = infoLabel
        self.detailInfoLabel.text = detailInfoLabel
        self.moreInfoLabel.isHidden = !moreInfoEnable
    }
}
