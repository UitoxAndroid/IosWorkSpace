//
//  ContentCollectionViewCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/27.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblSpec: UILabel!
    @IBOutlet weak var btnSelectSpec: UIButton!
    @IBOutlet weak var lblDevideLine: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
