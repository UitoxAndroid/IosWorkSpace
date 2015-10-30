//
//  GoodsTableTableViewController.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/4.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit


class GoodsTableViewController: UITableViewController
{
    var moreToBuyGoods = ["iphone6s","Sony Z5","nexus 6","One M9","Sony Xpria C5","Asus ZenPhone2"]
    lazy var goodsPageModel:GoodsPageModel? = GoodsPageModel()
    lazy var campaignData:CampaignModel? = CampaignModel()
    var goodsResponse:GoodsPageResponse? = nil
    var goodsInfo:GoodsPageItemInfo? = nil
    var suggestGoods:SuggestedData? = nil
    var isOpenMoroToBuyCell:Bool = false
    var isCampaignBegin:Bool = true
    var colorInfo:ColorInfo?
    var sizeInfo:SizeInfo?
    
    
    var seq:String = "201510AM140000049"
    
    
    var controllerSpec : UIAlertController?
    var controllerVolume : UIAlertController?
 
    @IBAction func showSheetSpec(sender: UIButton) {
        self.presentViewController(controllerSpec!, animated: true, completion: nil)
    }
    @IBAction func showSheetVolume(sender: UIButton) {
        self.presentViewController(controllerVolume!, animated: true, completion: nil)
    }
    
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(goodsResponse == nil) {
            self.getGoodsPageData(seq)
        } else {
            goodsInfo = goodsResponse?.itemInfo
            suggestGoods = goodsResponse?.suggestedData
        }
        
        self.setUpBarButton()
    }
    
    // MARK: - 設定tableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(goodsResponse == nil) {
            return 0
        }
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return 6
        case 1:
            return moreToBuyGoods.count
        case 2:
            return 1
        case 3:
            return 3
        default :
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:     //Banner
                return 350
            case 1:     //規格
                return 50
            case 2:     //活動
                if(isCampaignBegin == false) {
                    return 0
                } else {
                    return 100
                }
                
            case 3:     //預購
                return 80
            case 4:     //說明
                return 120
            case 5:     //加購商品Title
                return 35
            default:
                return 70
            }
        case 1:
            //加購商品
            if(indexPath.row > 1 && isOpenMoroToBuyCell == true) {
                return 70
            } else if(indexPath.row > 1 && isOpenMoroToBuyCell == false) {
                return 0
            } else {
                return 70
            }
        case 2:
            //展開列
            if(indexPath.row == 0) {
                if(isOpenMoroToBuyCell == true) {
                    return 0
                } else {
                    return 20
                }
            } else {
                return 0      //相關商品
            }
        case 3:
            return 300      //TabCell
        default:
            return 200
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 3) {
            let headerCell = tableView.dequeueReusableCellWithIdentifier("SectionHeaderCell") as! SectionHeaderCell
            return headerCell
        } else {
            let headerCell = tableView.dequeueReusableCellWithIdentifier("SectionHeaderCell") as! SectionHeaderCell
            headerCell.hidden = true
            return headerCell
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
            case 0: //圖片&品名&售價
                let bannerCell = tableView.dequeueReusableCellWithIdentifier("BannerCell", forIndexPath: indexPath) as! BannerCell
                if(goodsInfo?.smSubTitle?.type == 0) {
                    bannerCell.lblGoodsdesc1.text = ""
                } else {
                    bannerCell.lblGoodsdesc1.text = goodsInfo?.smSubTitle?.title
                }
                bannerCell.lblGoodsName.text = self.goodsInfo?.smName
                bannerCell.imageList = self.goodsInfo?.smPicMulti
                bannerCell.lblPriceNow.text = "$\(self.goodsInfo!.smPrice)"
                bannerCell.lblPriceOrigin.text = "$\(self.goodsResponse!.itemInfo!.itMprice)"
                bannerCell.ImageBannerSetting()
                return bannerCell
            case 1://規格
                let specificationCell = tableView.dequeueReusableCellWithIdentifier("SpecificationCell", forIndexPath: indexPath) as! SpecificationCell
                return specificationCell
            case 2://活動
                let activityCell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as! ActivityCell
                
                //行銷活動時間
                activityCell.lblActTime.text = "\(goodsResponse!.itemInfo!.ssmStDt) ~ \(goodsResponse!.itemInfo!.ssmEnDt)"
                
                //優惠價?
                activityCell.lblGoodPrice.text = "$10"
               
                if(isCampaignBegin == true) {
                    activityCell.hidden = false
                } else {
                    activityCell.hidden = true
                }
                
                return activityCell
                
            case 3://預購倒數
                let preorderCell = tableView.dequeueReusableCellWithIdentifier("PreorderCell", forIndexPath: indexPath) as! PreorderCell
                
                //如果有設定預購
                if(goodsResponse?.itemInfo?.isPreOrd == true) {
                    preorderCell.lblMbrOnlyTag.hidden = true
                } else {
                    preorderCell.lblMbrOnlyTag.hidden = false
                }
                
                preorderCell.lblPreorderDeadline.text = self.goodsInfo?.preDtE
                return preorderCell
            case 4://說明
                let directionCell = tableView.dequeueReusableCellWithIdentifier("DirectionCell", forIndexPath: indexPath) as! DirectionCell
                directionCell.lblDesc.text = "會員限購\(self.goodsInfo!.ssmLimitQty)個"
                directionCell.lblOutDay.text = self.goodsInfo?.refEtdDt
                directionCell.lblLeftCount.text = self.goodsInfo?.preAvaQty
                
                //已預訂數量?
                directionCell.lblPreorderCount.text = "2"
                return directionCell
            case 5://加購Title
                let moreToBuyTitleCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyTitleCell", forIndexPath: indexPath) as! MoreToBuyTitleCell
                return moreToBuyTitleCell
            default:
                let moreToBuyCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyCell", forIndexPath: indexPath) as! MoreToBuyCell
                return moreToBuyCell
            }
       
        
        case 1://加購商品
            let moreToBuyCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyCell", forIndexPath: indexPath) as! MoreToBuyCell
            
            moreToBuyCell.lblName.text = moreToBuyGoods[indexPath.row]
            
            var spec:[String] = ["規格1","規格2","規格3"]
            var specNum = 0
            controllerSpec = UIAlertController(title: "請選擇規格", message: nil, preferredStyle: .ActionSheet)
            for _ in spec {
                let selectSpec = UIAlertAction(title: spec[specNum], style:UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
                    moreToBuyCell.lblSpec.text = paramAction.title
                })
                controllerSpec?.addAction(selectSpec)
                specNum++
            }
            
            var volume:[String] = ["1","2","3"]
            var volNum = 0
            controllerVolume = UIAlertController(title: "請選擇數量", message: nil, preferredStyle: .ActionSheet)
            for _ in spec {
                let selectVolume = UIAlertAction(title: volume[volNum], style:UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
                    moreToBuyCell.lblVolume.text = paramAction.title
                })
                controllerVolume?.addAction(selectVolume)
                volNum++
            }
            
            if(indexPath.row > 1 && isOpenMoroToBuyCell == true) {
                moreToBuyCell.hidden = false
            } else if(indexPath.row > 1 && isOpenMoroToBuyCell == false) {
                moreToBuyCell.hidden = true
            }
            return moreToBuyCell
        
        
        case 2:
            switch(indexPath.row) {
            case 0://加購商品展開按鈕
                let buttonInCell = tableView.dequeueReusableCellWithIdentifier("ButtonInCell", forIndexPath: indexPath) as! ButtonInCell
                if(isOpenMoroToBuyCell == true) {
                    buttonInCell.hidden = true
                }
                return buttonInCell
            case 1://相關商品
                let relationGoodsCell = tableView.dequeueReusableCellWithIdentifier("RelationViewCell", forIndexPath: indexPath) as! RelationViewCell
                return relationGoodsCell
            default:
                let buttonInCell = tableView.dequeueReusableCellWithIdentifier("ButtonInCell", forIndexPath: indexPath) as! ButtonInCell
                return buttonInCell
            }
        
        
        
        case 3://說明,規格,保固
            let footerCell = tableView.dequeueReusableCellWithIdentifier("FooterCell", forIndexPath: indexPath) as! FooterCell
//            log.debug("cellIndex \(indexPath)")
//            log.debug("y = \(footerCell.frame.origin.y)")
//            log.debug("x = \(footerCell.frame.origin.x)")
            
            SectionHeaderCell().OnTableViewScrolling(AnimateBarXPosition: 20.0)
            return footerCell
        default:
            let moreToBuyCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyCell", forIndexPath: indexPath) as! MoreToBuyCell
            return moreToBuyCell
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "ShowCampaignViewController" {
//            if let campaignViewController = segue.destinationViewController as? CampaignViewController {
//                self.GetCampaign {
//                    (campaignResponse:SearchListResponse?) in
//                    if campaignResponse?.total > 0 {
//                        campaignViewController.campaignData = campaignResponse
//                    }
//                    self.clearAllNotice()
//                }
//            }
//        }
//    }
    
    
    //點擊展開按鈕來展開加購商品
    @IBAction func btnOpenCellClick(sender: UIButton) {
        isOpenMoroToBuyCell = true
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }
    
    
    // MARK: - ToolBar 設定
    
    @IBOutlet weak var shopCart: UIBarButtonItem!
    @IBOutlet weak var buyNum: UIBarButtonItem!
    @IBOutlet weak var addShopCart: UIBarButtonItem!
    let addInCart = UIButton()
    let shopCartBtn = MIBadgeButton()
    let volumeView = VolumeButton()
    var buyCount = 1
    var numInCart = 0
    var sqliteCtl = SqlCartList()
    let comboData = CartComboData()
    
    func setUpBarButton() {
        buyNum.title = "1"
        addInCart.backgroundColor = UIColor(hue: 0.6, saturation: 0.7, brightness: 1, alpha: 1)
        addInCart.setTitle("加入購物車", forState: .Normal)
        addInCart.addTarget(self, action: "btnAddInCartPressed:", forControlEvents: .TouchUpInside)
        addInCart.frame = CGRectMake(0, 0, 170, 43)
        addShopCart.customView = addInCart
        
        shopCartBtn.setBackgroundImage(UIImage(named: "ic_shopping_cart"), forState: UIControlState.Normal)
        shopCartBtn.badgeString = nil
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
        comboData.itno  = "AB123000\(numInCart)"
        comboData.sno   = "CC123000\(numInCart)"
        sqliteCtl.datas = comboData
        sqliteCtl.sqliteInsert()
        showSuccess("已加入購物車")
    }
    
    func btnShopCartPressed(sender: MIBadgeButton) {
        sqliteCtl.sqliteQuery()
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

    // MARK: - 呼叫api
    
    func getGoodsPageData(smSeq:String) {
        goodsPageModel?.getGoodsPageData(smSeq,completionHandler: { (goodsPage: GoodsPageResponse?, errorMessage:String?) -> Void in
            if (goodsPage == nil) {
                self.showAlert(errorMessage!)
            }
            else {
                self.goodsResponse = goodsPage!
                self.goodsInfo = self.goodsResponse!.itemInfo
                self.suggestGoods = self.goodsResponse!.suggestedData
                self.colorInfo = self.goodsResponse!.productInfo?.colorInfo
                self.sizeInfo = self.goodsResponse!.productInfo?.sizeInfo
                self.tableView.reloadData()
            }
        })
    }
    
//    func GetCampaign(completionHandler: (campaignResponse :SearchListResponse?) -> Void) {
//        campaignData?.getCampaignData{ (campaign:SearchListResponse?, errorMessage: String?) in
//            if(errorMessage != nil) {
//                self.showAlert(errorMessage!)
//            } else {
//                completionHandler(campaignResponse: campaign!)
//            }
//        }
//    }
    
}
