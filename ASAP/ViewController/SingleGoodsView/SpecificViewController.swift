//
//  SpecificViewController.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/5.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class SpecificViewController: UITableViewController {
    
    var colorInfo:ColorInfo?
    var sizeInfo:SizeInfo?
    var multiProductList:[MultiProductData] = []
    var colorCount:Int = 0
    var sizeCount:Int = 0
    var itemInfo:GoodsPageItemInfo?
    var giftList:[GiftData] = []
    var controllerSpec : UIAlertController?
    var cartAction = 0
    lazy var placeholderImage: UIImage = {
        let image = UIImage(named: "PlaceholderImage")!
        return image
        }()
    
    @IBAction func showSheetSpec(sender: UIButton) {
        let tag = sender.tag
        controllerSpec = UIAlertController(title: "請選擇規格", message: nil, preferredStyle: .ActionSheet)
        for optionSpec in (multiProductList[tag].option){
            let selectSpec = UIAlertAction(title: optionSpec.name, style:UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
                let indexOfContentCell = NSIndexPath(forRow: 5, inSection: 0)
                let indexOfContentColCell = NSIndexPath(forItem: tag, inSection: 0)
                let contentCell = self.tableView.cellForRowAtIndexPath(indexOfContentCell) as? ContentCell
                let contentColCell = contentCell?.contentCollectionView.cellForItemAtIndexPath(indexOfContentColCell) as? ContentCollectionViewCell
                contentColCell?.lblSpec.text = paramAction.title!
            })
            controllerSpec?.addAction(selectSpec)
        }
   
        let selectCancel = UIAlertAction(title:"取消" , style:UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
            let indexOfContentCell = NSIndexPath(forRow: 5, inSection: 0)
            let indexOfContentColCell = NSIndexPath(forItem: tag, inSection: 0)
            let contentCell = self.tableView.cellForRowAtIndexPath(indexOfContentCell) as? ContentCell
            let contentColCell = contentCell?.contentCollectionView.cellForItemAtIndexPath(indexOfContentColCell) as? ContentCollectionViewCell
            contentColCell?.lblSpec.text = "請選擇規格"
        })
        controllerSpec?.addAction(selectCancel)
        
        self.presentViewController(controllerSpec!, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = false
        setRightItemClose()
        setUpBarButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func closeButtonOnClicked(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return 8
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
            case 0: //title
                return 150
            case 1: //color
                if(colorInfo?.colorList.count == 0 || colorInfo == nil) {
                    return 0
                } else {
                    if(colorCount/5 < 1) {
                        return 35
                    } else if (colorCount / 5 >= 1 && colorCount % 5 == 0) {
                        return CGFloat(35 * (colorCount/5))
                    } else {
                        return CGFloat(35 * (colorCount/5 + 1))
                    }
                }
            case 2: //尺寸 title
                if(sizeInfo?.sizeList.count == 0 || sizeInfo == nil) {
                    return 0
                } else {
                    return 44
                }
            case 3: //尺寸
                if(sizeInfo?.sizeList.count == 0 || sizeInfo == nil) {
                    return 0
                } else {
                    if(sizeCount/7 < 1) {
                        return 35
                    } else if (sizeCount / 7 >= 1 && sizeCount % 7 == 0) {
                        return CGFloat(35 * (sizeCount/7))
                    } else {
                        return CGFloat(35 * (sizeCount/7 + 1))
                    }
                }
            case 4: //包含內容 title
                if (multiProductList.count == 0) {
                    return 0
                } else {
                    return 44
                }
            case 5: //內容
                if (multiProductList.count == 0) {
                    return 0
                } else {
                    return CGFloat(35 * multiProductList.count)
                }
            case 6: //贈品 title
                if(giftList.count == 0) {
                    return 0
                } else {
                    return 44
                }
                
            case 7: //贈品
                if(giftList.count == 0) {
                    return 0
                } else {
                    return CGFloat(35 * giftList.count)
                }
            default:
                return 44
            }
        default:
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                let titleCell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
                if let goodsItemInfo = itemInfo {
                    titleCell.lblItemName.text = goodsItemInfo.smName
                    titleCell.lblPriceNow.text = "$\(goodsItemInfo.smPrice!)"
                    titleCell.lblPriceOrigin.text = "$\(goodsItemInfo.itMprice)"
                    drawDeleteLine(titleCell.lblPriceOrigin.text! , priceLabel: titleCell.lblPriceOrigin)
                    
                    let URL = NSURL(string: goodsItemInfo.smPic!)!
                    //使用Kingfisher以Url當key
                    titleCell.itemImg.kf_setImageWithURL(URL, placeholderImage: placeholderImage,
                        optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)],
                        progressBlock: { (receivedSize, totalSize) -> () in
                            log.debug("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
                        }) { (image, error, cacheType, imageURL) -> () in
                            if error != nil  {
                                log.debug(error?.description)
                            }
                            log.debug("\(indexPath.row + 1): Finished")
                    }
                }
                
                if(colorInfo?.colorList.count == 0 || colorInfo == nil) {
                    titleCell.lblColor.hidden = true
                }
                return titleCell
            case 1:
                let colorCell = tableView.dequeueReusableCellWithIdentifier("ColorViewCell", forIndexPath: indexPath) as! ColorCell
                colorCell.colorInfo = self.colorInfo
                if(colorInfo?.colorList.count == 0  || colorInfo == nil) {
                    colorCell.hidden = true
                }
                return colorCell
            case 2:
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell", forIndexPath: indexPath) as! SectionTitleCell
                sectionTitleCell.txtTitle.text = "尺寸"
                if(sizeInfo?.sizeList.count == 0 || sizeInfo == nil) {
                    sectionTitleCell.hidden = true
                }
                return sectionTitleCell
            case 3:
                let sizeCell = tableView.dequeueReusableCellWithIdentifier("SizeViewCell", forIndexPath: indexPath) as! SizeCell
                sizeCell.sizeInfo = self.sizeInfo
                if(sizeInfo?.sizeList.count == 0 || sizeInfo == nil) {
                    sizeCell.hidden = true
                }
                return sizeCell
            case 4:
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell", forIndexPath: indexPath) as! SectionTitleCell
                sectionTitleCell.txtTitle.text = "包含內容"
                if(multiProductList.count == 0) {
                    sectionTitleCell.hidden = true
                }
                return sectionTitleCell
            case 5:
                let contentCell = tableView.dequeueReusableCellWithIdentifier("ContentViewCell", forIndexPath: indexPath) as! ContentCell
                contentCell.multiProductList = self.multiProductList
                if(multiProductList.count == 0) {
                    contentCell.hidden = true
                }
                return contentCell
            case 6:
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell", forIndexPath: indexPath) as! SectionTitleCell
                sectionTitleCell.txtTitle.text = "贈品"
                if(giftList.count == 0) {
                    sectionTitleCell.hidden = true
                }
                return sectionTitleCell
            case 7:
                let giftCell = tableView.dequeueReusableCellWithIdentifier("GiftViewCell", forIndexPath: indexPath) as! GiftCell
                giftCell.giftList = self.giftList
                if(giftList.count == 0) {
                    giftCell.hidden = true
                }
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
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
   
    // MARK: - ToolBar 設定
    
    @IBOutlet weak var shopCart: UIBarButtonItem!
    @IBOutlet weak var addShopCart: UIBarButtonItem!
    @IBOutlet weak var buyNum: UIBarButtonItem!
    
    let addInCart = UIButton()
    let shopCartBtn = MIBadgeButton()
    let volumeView = VolumeButton()
    var buyCount = 1
    var numInCart = 0
    let comboData = CartComboData()
    
    func setUpBarButton() {
        buyNum.title = "1"
        addInCart.backgroundColor = UIColor(hue: 0.6, saturation: 0.7, brightness: 1, alpha: 1)
        addInCart.setTitle("加入購物車", forState: .Normal)
        addInCart.addTarget(self, action: "btnAddInCartPressed:", forControlEvents: .TouchUpInside)
        addInCart.frame = CGRectMake(0, 0, 170, 43)
        addShopCart.customView = addInCart
        
        shopCartBtn.setBackgroundImage(UIImage(named: "ic_shopping_cart"), forState: UIControlState.Normal)
        if(MyApp.sharedShoppingCart.goodsList.count > 0) {
            shopCartBtn.badgeString = String(MyApp.sharedShoppingCart.goodsList.count)
            numInCart = MyApp.sharedShoppingCart.goodsList.count
        } else {
            shopCartBtn.badgeString = nil
        }
        shopCartBtn.addTarget(self, action: "btnShopCartPressed:", forControlEvents: .TouchUpInside)
        shopCartBtn.frame = CGRectMake(0, 0, 30, 30)
        shopCartBtn.badgeEdgeInsets = UIEdgeInsetsMake(12, 5, 0, 10)
        shopCart.customView = shopCartBtn
    }
    
    func btnAddInCartPressed(sender :UIButton) {
        numInCart++
        if(numInCart <= 0) {
            shopCartBtn.badgeString = nil
        } else {
            shopCartBtn.badgeString = "\(numInCart)"
        }
        
        //先寫入假資料
//        let info = ShoppingCartInfo()
        comboData.itno  = "AB123000\(numInCart)"
        comboData.sno   = "CC123000\(numInCart)"
        
        MyApp.sharedShoppingCart.insertGoodsIntoCart(CartDetail())
        self.showSuccess("已加入購物車")
        self.addCartNumber()
    }
    
    func btnShopCartPressed(sender: MIBadgeButton) {
        MyApp.sharedShoppingCart.queryShoppingCart()
    }
    
    @IBAction func btnPlusPressed(sender: UIBarButtonItem) {
        buyCount++
        self.buyNum.title = "\(buyCount)"
    }
    
    @IBAction func btnMinusPressed(sender: UIBarButtonItem) {
        buyCount--
        if(buyCount <= 1) {
            buyCount = 1
            self.buyNum.title = "1"
        } else {
            self.buyNum.title = "\(buyCount)"
        }
    }
    
    func drawDeleteLine(price:String, priceLabel: UILabel) {
        let length = price.characters.count
        let attrString = NSMutableAttributedString(string: price)
        let range = NSMakeRange(0, length)
        attrString.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.PatternSolid.rawValue | NSUnderlineStyle.StyleSingle.rawValue, range: range)
        attrString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.lightGrayColor(), range: range)
        priceLabel.attributedText = attrString
    }
    

}
