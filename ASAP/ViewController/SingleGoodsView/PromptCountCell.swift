//
//  PromptCountCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/11/5.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

class PromptCountCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblWebPrice: UILabel!
    @IBOutlet weak var lblMinusPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //設定label為多行
        lblProductName.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblProductName.numberOfLines = 2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
