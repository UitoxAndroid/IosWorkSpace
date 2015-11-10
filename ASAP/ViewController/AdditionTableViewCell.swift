//
//  TableViewCell.swift
//  ASAP
//
//  Created by janet on 2015/11/3.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

// 購物車清單-購物車加購品
class AdditionTableViewCell: UITableViewCell {
    
    @IBOutlet var productName: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var qty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
