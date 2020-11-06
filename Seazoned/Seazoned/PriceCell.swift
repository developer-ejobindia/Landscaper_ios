//
//  PriceCell.swift
//  Seazoned
//
//  Created by Apple on 23/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

class PriceCell: UITableViewCell {

    @IBOutlet weak var points: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var grass_size: UILabel!
    
    @IBOutlet weak var service_type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
