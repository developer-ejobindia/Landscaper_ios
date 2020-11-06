//
//  dashboard_tblcellTableViewCell.swift
//  Seazoned
//
//  Created by apple on 07/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

class dashboard_tblcellTableViewCell: UITableViewCell {

    @IBOutlet weak var view_decline1: UIView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var prefered_time: UILabel!
    @IBOutlet weak var service_date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var service_money: UILabel!
   
    @IBOutlet weak var btn_dec: UIButton!
    @IBOutlet weak var view_accept: UIView!
    @IBOutlet weak var lbl_service: UILabel!
    @IBOutlet weak var btn_accept: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
