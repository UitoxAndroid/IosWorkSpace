//
//  TitleCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/1.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPriceNow: UILabel!
    @IBOutlet weak var lblPriceOrigin: UILabel!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var lblColor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //設定label為多行
        lblItemName.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblItemName.numberOfLines = 2

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
