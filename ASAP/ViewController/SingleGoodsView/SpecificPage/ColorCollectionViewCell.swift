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
    var selectStatus:Bool = false
    
    override func awakeFromNib() {
        setButtonAction()
    }
    
    func setButtonAction() {
        btnSelectColor.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        btnSelectColor.addTarget(self, action: "changeColor:", forControlEvents: .TouchUpInside)
    }
    
    func changeColor(sender: UIButton) {
        if(selectStatus == false) {
            btnSelectColor.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            selectStatus = true
        } else {
            btnSelectColor.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            selectStatus = false
        }
    }
}
