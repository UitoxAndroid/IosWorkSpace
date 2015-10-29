//
//  ColorCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/1.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    var colorList:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let colorCell:ColorCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ColorCell", forIndexPath: indexPath) as! ColorCollectionViewCell
        colorCell.btnSelectColor.setTitle(colorList[indexPath.row], forState: .Normal)
        return colorCell
    }
    
    
        
    
}
