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
    var tempTag:Int?
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
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
            colorCell.btnSelectColor.tag = indexPath.row
        }
        return colorCell
    }
    
    @IBAction func onColorBtnPressed(sender: UIButton) {
        let tag = sender.tag
        
        let indexOfSelectedBtn = NSIndexPath(forItem: tag, inSection: 0)
        let colorCellOnPress = self.colorCollectionView.cellForItemAtIndexPath(indexOfSelectedBtn) as? ColorCollectionViewCell
        colorCellOnPress?.btnSelectColor.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        if let tempTag = tempTag {
            let indexOfExSelected = NSIndexPath(forItem: tempTag, inSection: 0)
            let exColorCell = self.colorCollectionView.cellForItemAtIndexPath(indexOfExSelected) as? ColorCollectionViewCell
            exColorCell?.btnSelectColor.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }
        
        tempTag = tag
    }
    
        
    
}
