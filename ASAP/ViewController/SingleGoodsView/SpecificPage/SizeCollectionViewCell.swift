//
//  SizeCollectionViewCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/26.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var btnSelectSize: UIButton!
    
    override func awakeFromNib() {
        setButtonAction()
    }
    
    func setButtonAction() {
        btnSelectSize.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
    }
    
}
