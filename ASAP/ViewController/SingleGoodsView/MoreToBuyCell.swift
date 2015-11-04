//
//  MoreToBuyCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/18.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class MoreToBuyCell: UITableViewCell {
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var ckboxIsbuy:Checkbox!
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSpec: UILabel!
    @IBOutlet weak var lblVolume: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
