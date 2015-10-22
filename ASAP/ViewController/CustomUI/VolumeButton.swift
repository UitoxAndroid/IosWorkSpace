//
//  VolumeButton.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/21.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

class VolumeButton: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let buttonAdd = UIButton()
    let buttonMinus = UIButton()
    let labelNumber = UILabel()
    var count = 1
    var btnAddFrameX:         CGFloat = 3
    var btnAddFrameY:         CGFloat = 3
    var btnAddFrameWidth:     CGFloat = 30
    var btnAddFrameHeight:    CGFloat = 30
    
    var btnMinusFrameX:       CGFloat = 73
    var btnMinusFrameY:       CGFloat = 3
    var btnMinusFrameWidth:   CGFloat = 30
    var btnMinusFrameHeight:  CGFloat = 30
    
    var lblNumberFrameX:       CGFloat = 33
    var lblNumberFrameY:       CGFloat = 3
    var lblNumberFrameWidth:   CGFloat = 40
    var lblNumberFrameHeight:  CGFloat = 30
    
    internal func setBtnAddFrame(X:CGFloat,Y:CGFloat,width:CGFloat,height:CGFloat) {
        btnAddFrameX = X
        btnAddFrameY = Y
        btnAddFrameWidth = width
        btnAddFrameHeight = height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setButton()
    }
    
    func setButton() {
        self.buttonAdd.setTitle("+", forState: .Normal)
        self.buttonAdd.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.buttonAdd.backgroundColor = UIColor.whiteColor()
        self.buttonAdd.addTarget(self, action: "btnAddPressed:", forControlEvents: .TouchUpInside)
        self.buttonAdd.frame = CGRectMake(btnAddFrameX, btnAddFrameY, btnAddFrameWidth, btnAddFrameHeight)
        self.addSubview(buttonAdd)
        
        self.labelNumber.text = "1"
        self.labelNumber.textAlignment = .Center
        self.labelNumber.backgroundColor = UIColor.grayColor()
        self.labelNumber.frame = CGRectMake(lblNumberFrameX, lblNumberFrameY, lblNumberFrameWidth, lblNumberFrameHeight)
        self.addSubview(labelNumber)
        
        self.buttonMinus.setTitle("-", forState: .Normal)
        self.buttonMinus.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.buttonMinus.backgroundColor = UIColor.whiteColor()
        self.buttonMinus.addTarget(self, action: "btnMinusPressed:", forControlEvents: .TouchUpInside)
        self.buttonMinus.frame = CGRectMake(btnMinusFrameX, btnMinusFrameY, btnMinusFrameWidth, btnMinusFrameHeight)
        self.addSubview(buttonMinus)
    }
    
    func btnAddPressed(sender:UIButton) {
        count++
        labelNumber.text = "\(count)"
    }
    
    func btnMinusPressed(sender:UIButton) {
        if(count <= 1) {
            labelNumber.text = "1"
        } else {
            count--
            labelNumber.text = "\(count)"
        }
        
    }

}
