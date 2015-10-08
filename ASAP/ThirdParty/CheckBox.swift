//
//  CheckBox.swift
//  ASAP
//
//  Created by janet on 2015/10/1.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    
    let checkedImage    = UIImage(named: "checked_checkbox")
    let uncheckedImage  = UIImage(named: "unchecked_checkbox")
    
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
