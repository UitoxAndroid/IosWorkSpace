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
    var selectStatus:Bool = false
    
    override func awakeFromNib() {
        setButtonAction()
    }
    
    func setButtonAction() {
        btnSelectSize.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        btnSelectSize.addTarget(self, action: "changeColor:", forControlEvents: .TouchUpInside)
    }
    
    func changeColor(sender: UIButton) {
        if(selectStatus == false) {
            btnSelectSize.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            selectStatus = true
        } else {
            btnSelectSize.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            selectStatus = false
        }
    }
}
