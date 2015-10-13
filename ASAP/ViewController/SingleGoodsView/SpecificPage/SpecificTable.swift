//
//  SpecificTable.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/1.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class SpecificTable: UITableView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
//    override func numberOfSections() -> Int {
//        return 2
//    }
  
    override func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    
    override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
        let titleCell = dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
        return titleCell
    }
    
}
