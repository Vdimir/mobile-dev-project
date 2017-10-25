//
//  LFItemTableViewCell.swift
//  LostAndFound
//
//  Created by student on 18.10.17.
//  Copyright © 2017 SYN. All rights reserved.
//

import UIKit

class LFItemTableViewCell: UITableViewCell {

    var item: LFItemProtocol! {
        didSet {
            mainLabel?.text = item.title
        }
    }
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
