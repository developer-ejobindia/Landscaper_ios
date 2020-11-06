//
//  ServiceCell.swift
//  Seazoned
//
//  Created by Apple on 22/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

class ServiceCell: UITableViewCell {

    @IBOutlet weak var ser_view: UIView!
    
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var ser_name: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let des_obj = Design()
        des_obj.view_round(my_view: self.ser_view)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
