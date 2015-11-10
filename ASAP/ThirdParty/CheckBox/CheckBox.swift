//
//  CheckBox.swift
//  ASAP
//
//  Created by janet on 2015/10/1.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class CheckBox: UIButton
{
    let checkedImage    = UIImage(named: "ic_check_box")
    let uncheckedImage  = UIImage(named: "ic_check_box_outline_blank")
    
    var isChecked: Bool = false {
        didSet{
            if isChecked {
                self.setImage(checkedImage, forState: UIControlState.Normal)
            } else {
                self.setImage(uncheckedImage, forState: UIControlState.Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }

    func buttonClicked(sender: UIButton) {
        if(sender == self) {
            self.isChecked = !self.isChecked
        }
    }
}


class BorderButton: UIButton
{
    override func awakeFromNib() {
        self.layer.backgroundColor = UIColor.whiteColor().CGColor   // 白底
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGrayColor().CGColor     // 灰框
        self.layer.masksToBounds = true
    }
}

class BorderLabel: UILabel
{
    override func awakeFromNib() {
        self.layer.backgroundColor = UIColor.whiteColor().CGColor   // 白底
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGrayColor().CGColor     // 灰框
        self.layer.masksToBounds = true
    }
}