//
//  Checkbox.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/16.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class Checkbox: UIButton
{
    let checkedImage = UIImage(named: "ic_check_box") as UIImage?
    let uncheckedImage = UIImage(named: "ic_check_box_outline_blank") as UIImage?
    
    var isChecked:Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, forState: .Normal)
            } else {
                self.setImage(uncheckedImage, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender:UIButton) {
        if(sender == self) {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
    
    
    
}
