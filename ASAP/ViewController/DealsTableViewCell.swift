//
//  DealsTableViewCell.swift
//  ASAP
//
//  Created by janet on 2015/9/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class DealsCollectionView: UICollectionView
{
    var indexPath: NSIndexPath!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

class DealsTableViewCell: UITableViewCell
{

    @IBOutlet var countDownLabel: UILabel!
    
    @IBOutlet var dealsCollectionView: DealsCollectionView!
    
    @IBAction func dealsMoreButtonClick(sender: AnyObject) {
        println("Click Button")
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
