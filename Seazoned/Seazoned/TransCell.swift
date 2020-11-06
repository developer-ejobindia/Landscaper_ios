//
//  TransCell.swift
//  Seazoned
//
//  Created by Apple on 24/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

class TransCell: UITableViewCell {
 @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var order_no: UILabel!
    
    @IBOutlet weak var ser_date: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var btn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.status.clipsToBounds=true
        self.status.layer.cornerRadius=3
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
