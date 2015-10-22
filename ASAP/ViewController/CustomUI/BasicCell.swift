//
//  BasicCell.swift
//  UitoxSample1
//
//  Created by uitox_macbook on 2015/8/27.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell
{

	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var subtitleLabel: UILabel!
	@IBOutlet var costLabel: UILabel!
	@IBOutlet var priceLabel: UILabel!
	@IBOutlet var imagedView:UIImageView!
	@IBOutlet var timeLabel: UILabel!
	@IBOutlet var addCartButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
