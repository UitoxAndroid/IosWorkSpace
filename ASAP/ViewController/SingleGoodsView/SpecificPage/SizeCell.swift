//
//  SizeCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/1.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class SizeCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    var SizeList:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SizeList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let sizeCell:SizeCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("SizeCell", forIndexPath: indexPath) as! SizeCollectionViewCell
        sizeCell.btnSelectSize.setTitle(SizeList[indexPath.row], forState: .Normal)
        return sizeCell
    }

}
