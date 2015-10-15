//
//  ActCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/14.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

class ActCell: UITableViewCell {
    @IBOutlet weak var lblActStatus: UILabel!
    @IBOutlet weak var lblActName: UILabel!
    @IBOutlet weak var lblActTime: UILabel!
    @IBOutlet weak var lblActDescrib: UILabel!
    @IBOutlet weak var lblActDetail: UILabel!
    var actStatus:Bool? = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if actStatus == true{
            lblActStatus.text = "限時特賣中"
        }else{
            lblActStatus.text = "特賣即將開始"
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
