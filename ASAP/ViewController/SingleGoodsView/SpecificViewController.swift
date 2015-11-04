//
//  SpecificViewController.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/5.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class SpecificViewController: UITableViewController,UIPopoverPresentationControllerDelegate {
    
    var colorInfo:ColorInfo?
    var sizeInfo:SizeInfo?
    var colorCount:Int = 0
    var sizeCount:Int = 0
    var itemInfo:GoodsPageItemInfo?
    var itemNameList:[String] = ["Item Name1","Item Name2"]
    var giftNameList:[String] = ["gift1","gift2","gift3"]
    
    
    @IBAction func btnDismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func btnCloseView(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var controllerSpec : UIAlertController?
    @IBAction func showSheetSpec(sender: UIButton) {
        self.presentViewController(controllerSpec!, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return 9
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let colors = colorInfo?.colorList {
            colorCount = colors.count
        }
        
        if let sizes = sizeInfo?.sizeList {
            sizeCount = sizes.count
        }
        
        
        
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                return 60
            case 1: //title
                return 150
            case 2: //color
                if(colorCount/5 < 1) {
                    return 35
                } else if (colorCount / 5 >= 1 && colorCount % 5 == 0) {
                    return CGFloat(35 * (colorCount/5))
                } else {
                    return CGFloat(35 * (colorCount/5 + 1))
                }
            case 3: //尺寸 title
                return 44
            case 4: //尺寸
                if(sizeCount/7 < 1) {
                    return 35
                } else if (sizeCount / 7 >= 1 && sizeCount % 7 == 0) {
                    return CGFloat(35 * (sizeCount/7))
                } else {
                    return CGFloat(35 * (sizeCount/7 + 1))
                }
            case 5: //包含內容 title
                return 44
            case 6: //內容
                return CGFloat(35 * itemNameList.count)
            case 7: //贈品 title
                return 44
            case 8: //贈品
                return CGFloat(35 * giftNameList.count)
            default:
                return 44
            }
        default:
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //自動消除選取時該列時會以灰色來顯示的效果
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                let navigationCell = tableView.dequeueReusableCellWithIdentifier("NavigationCell", forIndexPath: indexPath) as! NavigationCell
                return navigationCell
            case 1:
                let titleCell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
                if let goodsItemInfo = itemInfo {
                    titleCell.lblItemName.text = goodsItemInfo.smName
                    titleCell.lblPriceNow.text = "$\(goodsItemInfo.smPrice!)"
                    titleCell.lblPriceOrigin.text = "$\(goodsItemInfo.itMprice)"
                }
                return titleCell
            case 2:
                let colorCell = tableView.dequeueReusableCellWithIdentifier("ColorViewCell", forIndexPath: indexPath) as! ColorCell
                colorCell.colorInfo = self.colorInfo
                return colorCell
            case 3:
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell", forIndexPath: indexPath) as! SectionTitleCell
                sectionTitleCell.txtTitle.text = "尺寸"
                return sectionTitleCell
            case 4:
                let sizeCell = tableView.dequeueReusableCellWithIdentifier("SizeViewCell", forIndexPath: indexPath) as! SizeCell
                sizeCell.sizeInfo = self.sizeInfo
                return sizeCell
            case 5:
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell", forIndexPath: indexPath) as! SectionTitleCell
                sectionTitleCell.txtTitle.text = "包含內容"
                return sectionTitleCell
            case 6:
                let contentCell = tableView.dequeueReusableCellWithIdentifier("ContentViewCell", forIndexPath: indexPath) as! ContentCell
                contentCell.itemNameList = self.itemNameList
                
                var spec:[String] = ["規格1","規格2","規格3"]
                var specNum = 0
                controllerSpec = UIAlertController(title: "請選擇規格", message: nil, preferredStyle: .ActionSheet)
                for _ in spec {
                    let selectSpec = UIAlertAction(title: spec[specNum], style:UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
                        contentCell.spec = paramAction.title
                    })
                    controllerSpec?.addAction(selectSpec)
                    specNum++
                }
                
                let selectCancel = UIAlertAction(title:"取消" , style:UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
                })
                controllerSpec?.addAction(selectCancel)
                
                return contentCell
            case 7:
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell", forIndexPath: indexPath) as! SectionTitleCell
                sectionTitleCell.txtTitle.text = "贈品"
                return sectionTitleCell
            case 8:
                let giftCell = tableView.dequeueReusableCellWithIdentifier("GiftViewCell", forIndexPath: indexPath) as! GiftCell
                giftCell.giftNameList = self.giftNameList
                return giftCell
            default:
                let titleCell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
                return titleCell
            }
        default:
            let titleCell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
            return titleCell
        }
    }

    

}
