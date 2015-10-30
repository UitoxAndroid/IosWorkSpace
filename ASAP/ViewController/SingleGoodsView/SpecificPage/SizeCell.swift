//
//  SizeCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/1.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class SizeCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    var sizeInfo:SizeInfo?
    var sizesCount:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sizes = sizeInfo?.sizeList {
            sizesCount = sizes.count
        }
        return sizesCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let sizeCell:SizeCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("SizeCell", forIndexPath: indexPath) as! SizeCollectionViewCell
        
        if let sizes = sizeInfo?.sizeList {
            sizeCell.btnSelectSize.setTitle(sizes[indexPath.row].sizeName, forState: .Normal)
        }
        
        return sizeCell
    }

}
