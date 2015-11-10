//
//  CartTotalTableViewCell.swift
//  ASAP
//
//  Created by janet on 2015/11/3.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

// 購物車清單-購物車總計
class CartTotalTableViewCell: UITableViewCell {

    @IBOutlet var cartTotal: UILabel!
    @IBOutlet var deliveryCharges: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}