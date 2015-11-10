//
//  ColorCollectionViewCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/26.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var btnSelectColor: UIButton!
    
    override func awakeFromNib() {
        setButtonAction()
    }
    
    func setButtonAction() {
        btnSelectColor.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
    }
    
}
