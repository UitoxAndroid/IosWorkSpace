//
//  RelationViewCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/22.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class RelationViewCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var tableName:[String] = ["Lumix","SonyZx","ZenPhone","iPhone"]
    var tablePrice:[String] = ["$3100","$2546","$1029","$2038"]
    var tableImage:[String] = ["goodsA","goodsB","goodsC","goodsD"]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableName.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:RelationGoodsCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! RelationGoodsCell
        cell.lblNameCell.text = tableName[indexPath.row]
        cell.lblPriceCell.text = tablePrice[indexPath.row]
        cell.imgCell.image = UIImage(named: tableImage[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Cell \(indexPath.row) selected")
    }


}
