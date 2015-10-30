//
//  ColorCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/1.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    var colorInfo:ColorInfo?
    var colorsCount:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let colors = colorInfo?.colorList {
            colorsCount = colors.count
        }
        return colorsCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let colorCell:ColorCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ColorCell", forIndexPath: indexPath) as! ColorCollectionViewCell
        if let colors = colorInfo?.colorList {
            colorCell.btnSelectColor.setTitle(colors[indexPath.row].colorName, forState: .Normal)
        }

        
        return colorCell
    }
    
    
        
    
}
