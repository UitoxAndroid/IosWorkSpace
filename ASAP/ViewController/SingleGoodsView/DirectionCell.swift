//
//  DirectionCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/22.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class DirectionCell: UITableViewCell {
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblOutDay: UILabel!
    @IBOutlet weak var lblPreorderCount: UILabel!
    @IBOutlet weak var lblLeftCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
