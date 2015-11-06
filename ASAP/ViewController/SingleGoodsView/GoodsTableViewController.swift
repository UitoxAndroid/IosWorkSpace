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
    lazy var goodsPageModel:GoodsPageModel? = GoodsPageModel()
    lazy var campaignData:CampaignModel? = CampaignModel()
    var goodsResponse:GoodsPageResponse? = nil
    var isOpenMoreToBuyCell:Bool = false
    var isCampaignBegin:Bool = false
    lazy var placeholderImage: UIImage = {
        let image = UIImage(named: "no_img")!
        return image
	}()
	
	var cartAction = 0
    var seq:String = "201510AM140000041"
    
    
    var controllerSpec : UIAlertController?
    var controllerVolume : UIAlertController?
 
    @IBAction func showSheetSpec(sender: UIButton) {
        let tag = sender.tag
        
        if let suggest = goodsResponse?.suggestedData {
            controllerSpec = UIAlertController(title: "請選擇規格", message: nil, preferredStyle: .ActionSheet)
            for optionSpec in (suggest.suggestDetail[tag].option){
                let selectSpec = UIAlertAction(title: optionSpec.name, style:UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
                    let index = NSIndexPath(forRow: tag, inSection: 1)
                    let moretobuy = self.tableView.cellForRowAtIndexPath(index) as? MoreToBuyCell
                    moretobuy?.lblSpec.text = paramAction.title
                })
                controllerSpec?.addAction(selectSpec)
            }
            let selectCancel = UIAlertAction(title:"取消" , style:UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
            })
            controllerSpec?.addAction(selectCancel)
        }
        self.presentViewController(controllerSpec!, animated: true, completion: nil)
    }
    
    @IBAction func showSheetVolume(sender: UIButton) {
        let tag = sender.tag
        var volume:[String] = ["1","2","3","4","5"]
        var volNum = 0
        controllerVolume = UIAlertController(title: "請選擇數量", message: nil, preferredStyle: .ActionSheet)
        for _ in volume {
            let selectVolume = UIAlertAction(title: volume[volNum], style:UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
                let index = NSIndexPath(forRow: tag, inSection: 1)
                let moretobuy = self.tableView.cellForRowAtIndexPath(index) as? MoreToBuyCell
                moretobuy?.lblVolume.text = paramAction.title
            })
            controllerVolume?.addAction(selectVolume)
            volNum++
        }
        
        let selectCancel = UIAlertAction(title:"取消" , style:UIAlertActionStyle.Default, handler: {(paramAction:UIAlertAction!) in
        })
        controllerVolume?.addAction(selectCancel)
        
        self.presentViewController(controllerVolume!, animated: true, completion: nil)
    }
    
    @IBAction func showSpecPage(sender: AnyObject) {
        showSpecificViewController()
    }
    
    
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.toolbarHidden = false
        
        if(goodsResponse == nil) {
            self.getGoodsPageData(seq)
        }
        self.setUpBarButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.toolbarHidden = false
        setUpBarButton()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.toolbarHidden = true
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
            return (goodsResponse?.suggestedData?.suggestDetail.count)!
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
                if let goodsInfos = goodsResponse {
                    if( goodsInfos.itemInfo?.specType == 0 &&
                        goodsInfos.productInfo?.multiProductList.count == 0 &&
                        goodsInfos.giftInfo?.giftList.count == 0) {
                        return 0
                    } else {
                        return 50
                    }
                } else {
                    return 50
                }
            case 2:     //活動
                isCampaignBegin = (goodsResponse?.campData?.check!)!
                if(isCampaignBegin == false) {
                    return 0
                } else {
                    return 100
                }
                
            case 3:     //預購
                if let goodsInfos = goodsResponse?.itemInfo {
                    if(goodsInfos.isPreOrd == "0") {
                        return 0
                    } else {
                        return 80
                    }
                } else {
                    return 80
                }
                
            case 4:     //說明
                if let goodsInfos = goodsResponse?.itemInfo {
                    if(goodsInfos.isPreOrd == "0") {
                        return 0
                    } else {
                        return 120
                    }
                } else {
                    return 120
                }
            case 5:     //加購商品Title
                if(goodsResponse?.suggestedData?.show == true) {
                    return 35
                } else {
                    return 0
                }

            default:
                return 70
            }
        case 1:
            //加購商品
            if(goodsResponse?.suggestedData?.show == true) {
               if(indexPath.row > 1 && isOpenMoreToBuyCell == true) {
                    return 70
                } else if(indexPath.row > 1 && isOpenMoreToBuyCell == false) {
                    return 0
                } else {
                    return 70
                }
            } else {
                return 0
            }
            
        case 2:
            //展開列
            if(goodsResponse?.suggestedData?.show == true) {
                if(indexPath.row == 0) {
                    if(isOpenMoreToBuyCell == true) {
                        return 0
                    } else {
                        return 20
                    }
                } else {
                    return 0      //相關商品
                }
            } else {
                return 0
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: //圖片&品名&售價
                let bannerCell = tableView.dequeueReusableCellWithIdentifier("BannerCell", forIndexPath: indexPath) as! BannerCell
                
                if let goodsInfos = goodsResponse?.itemInfo {
                    if(goodsInfos.smSubTitle!.type == 0) {
                        bannerCell.lblGoodsdesc1.text = ""
                    } else {
                        bannerCell.lblGoodsdesc1.text = goodsInfos.smSubTitle?.title
                    }
                    bannerCell.lblGoodsName.text = goodsInfos.smName
                    bannerCell.imageList = goodsInfos.smPicMulti
                    bannerCell.lblPriceNow.text = "$\(goodsInfos.smPrice!)"
                    bannerCell.lblPriceOrigin.text = "$\(goodsInfos.itMprice)"
                    drawDeleteLine(bannerCell.lblPriceOrigin.text!,priceLabel: bannerCell.lblPriceOrigin)
                    bannerCell.ImageBannerSetting()
                }
         
                return bannerCell
            case 1://規格
                let specificationCell = tableView.dequeueReusableCellWithIdentifier("SpecificationCell", forIndexPath: indexPath) as! SpecificationCell
                if let goodsInfos = goodsResponse {
                    if( goodsInfos.itemInfo?.specType == 0 &&
                        goodsInfos.giftInfo?.giftList.count == 0 &&
                        goodsInfos.productInfo?.multiProductList.count == 0) {
                        specificationCell.hidden = true
                    }
                }
                return specificationCell
            case 2://活動
                let activityCell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as! ActivityCell
                
                if let campInfo = goodsResponse?.campData {
                    //行銷活動時間
                    if (campInfo.campDetail.count != 0){
                        activityCell.lblActTime.text = "\(campInfo.campDetail[0].startDate) ~ \(campInfo.campDetail[0].endDate)"
                    }
                    //優惠價
                    activityCell.lblGoodPrice.text = "$\(goodsResponse!.itemInfo!.ssmPrice)"
                    
                    isCampaignBegin = campInfo.check!
                    if(isCampaignBegin == true) {
                        activityCell.hidden = false
                    } else {
                        activityCell.hidden = true
                    }
                }
                return activityCell
                
            case 3://預購倒數
                let preorderCell = tableView.dequeueReusableCellWithIdentifier("PreorderCell", forIndexPath: indexPath) as! PreorderCell
                
                if let goodsInfos = goodsResponse?.itemInfo {
                    //如果有設定預購
                    if(goodsInfos.isPreOrd == "1") {
                        preorderCell.lblMbrOnlyTag.hidden = true
                    } else {
                        preorderCell.lblMbrOnlyTag.hidden = false
                    }
                    
                    let formatter = NSDateFormatter();
                    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                    
                    if(goodsInfos.preDtE == nil || goodsInfos.preDtE == "") {
                        preorderCell.lblPreorderDeadline.text = "00:00:00"
                    } else {
                        let preDateEnd:NSDate = formatter.dateFromString(goodsInfos.preDtE!)!
                        let now = NSDate()
                        let deadline = preDateEnd.timeIntervalSinceDate(now)
                        if (deadline < 0) {
                            preorderCell.lblPreorderDeadline.text = "00:00:00"
                        } else {
                            preorderCell.lblPreorderDeadline.text = String(stringFromTimeInterval(deadline))
                        }
                    }
                    
                    if let ispreorder = goodsInfos.isPreOrd{
                        if(ispreorder == "0") {
                            preorderCell.hidden = true
                        } else {
                            preorderCell.hidden = false
                        }
                    }
                }
                return preorderCell
                
            case 4://說明
                let directionCell = tableView.dequeueReusableCellWithIdentifier("DirectionCell", forIndexPath: indexPath) as! DirectionCell
                
                if let goodsInfos = goodsResponse?.itemInfo {
                    let limitQty = goodsInfos.ssmLimitQty
                    if(limitQty == nil)
                    {
                        directionCell.lblDesc.text = "會員限購 個"
                    } else {
                        directionCell.lblDesc.text = "會員限購\(goodsInfos.ssmLimitQty)個"
                    }
                    
                    directionCell.lblOutDay.text = goodsInfos.refEtdDt
                    
                    directionCell.lblLeftCount.text = goodsInfos.preAvaQty
                    
                    //已預訂數量
                    directionCell.lblPreorderCount.text = "\(goodsInfos.preOrderQty)"
                    
                    if let ispreorder = goodsInfos.isPreOrd{
                        if(ispreorder == "0") {
                            directionCell.hidden = true
                        } else {
                            directionCell.hidden = false
                        }
                    }
                }
                return directionCell
            case 5://加購Title
                let moreToBuyTitleCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyTitleCell", forIndexPath: indexPath) as! MoreToBuyTitleCell
                if(goodsResponse?.suggestedData?.show == false) {
                    moreToBuyTitleCell.hidden = true
                }
                return moreToBuyTitleCell
            default:
                let moreToBuyCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyCell", forIndexPath: indexPath) as! MoreToBuyCell
                return moreToBuyCell
            }
       
        
        case 1://加購商品
            let moreToBuyCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyCell", forIndexPath: indexPath) as! MoreToBuyCell
            
            if let suggest = goodsResponse?.suggestedData {
                moreToBuyCell.lblName.text = suggest.suggestDetail[indexPath.row].productName
                moreToBuyCell.lblPrice.text = suggest.suggestDetail[indexPath.row].showPrice
                moreToBuyCell.btnSelectSpec.tag = indexPath.row
                moreToBuyCell.btnSelectVolume.tag = indexPath.row
                
                let URL = NSURL(string: suggest.suggestDetail[indexPath.row].photo!)!
                //使用Kingfisher以Url當key
                moreToBuyCell.img.kf_setImageWithURL(URL, placeholderImage: placeholderImage,
                    optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)],
                    progressBlock: { (receivedSize, totalSize) -> () in
                        log.debug("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
                    }) { (image, error, cacheType, imageURL) -> () in
                        if error != nil  {
                        }
                }
            }
            
            if(indexPath.row > 1 && isOpenMoreToBuyCell == true) {
                moreToBuyCell.hidden = false
            } else if(indexPath.row > 1 && isOpenMoreToBuyCell == false) {
                moreToBuyCell.hidden = true
            }
            
            if(goodsResponse?.suggestedData?.show == false) {
                moreToBuyCell.hidden = false
            }
            return moreToBuyCell
            
        case 2:
            switch(indexPath.row) {
            case 0://加購商品展開按鈕
                let buttonInCell = tableView.dequeueReusableCellWithIdentifier("ButtonInCell", forIndexPath: indexPath) as! ButtonInCell
                if(isOpenMoreToBuyCell == true) {
                    buttonInCell.hidden = true
                }
                
                if(goodsResponse?.suggestedData?.show == false) {
                    buttonInCell.hidden = false
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
            SectionHeaderCell().OnTableViewScrolling(AnimateBarXPosition: 20.0)
            return footerCell
        default:
            let moreToBuyCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyCell", forIndexPath: indexPath) as! MoreToBuyCell
            return moreToBuyCell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSpec" {
            if let specificViewController = segue.destinationViewController as? SpecificViewController {
                specificViewController.colorInfo = goodsResponse?.productInfo?.colorInfo
                specificViewController.sizeInfo = goodsResponse?.productInfo?.sizeInfo
                specificViewController.multiProductList = (goodsResponse?.productInfo?.multiProductList)!
                specificViewController.giftList = (goodsResponse?.giftInfo?.giftList)!
                specificViewController.itemInfo = goodsResponse?.itemInfo
            }
        }
        
        if segue.identifier == "ShowCampaignViewController" {
            if let campaignViewController = segue.destinationViewController as? CampaignViewController {
                campaignViewController.campSeq = "201511A0200000002"
            }
        }

    }
	
    
    //點擊展開按鈕來展開加購商品
    @IBAction func btnOpenCellClick(sender: UIButton) {
        isOpenMoreToBuyCell = true
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }
    
    
    //時間差總秒數轉換為 HH:mm:ss
    func stringFromTimeInterval(interval:NSTimeInterval) -> NSString {
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
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
    let comboData = CartComboData()
    
    func setUpBarButton() {
		
        buyNum.title = "1"
        addInCart.backgroundColor = UIColor(hue: 0.6, saturation: 0.7, brightness: 1, alpha: 1)
        addInCart.setTitle("加入購物車", forState: .Normal)
        addInCart.addTarget(self, action: "btnAddInCartPressed:", forControlEvents: .TouchUpInside)
        addInCart.frame = CGRectMake(0, 0, 170, 43)
        addShopCart.customView = addInCart
		
		self.handleBtnAttr(cartAction, addCartButton:addInCart)

		
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
	
	// 加入購物車按鈕外觀
	func handleBtnAttr(action:Int, addCartButton:UIButton) {
		switch action {
		case 0:
			addCartButton.setTitle("加入購物車", forState: UIControlState.Normal)
			addCartButton.backgroundColor = UIColor.redColor()
			addCartButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
			break
		case 1:
			addCartButton.setTitle("買立折", forState: UIControlState.Normal)
			addCartButton.backgroundColor = UIColor.orangeColor()
			addCartButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
			break
		case 2:
			addCartButton.setTitle("立即搶購", forState: UIControlState.Normal)
			addCartButton.backgroundColor = UIColor.redColor()
			addCartButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
			break
		case 3:
			addCartButton.setTitle("立即預訂", forState: UIControlState.Normal)
			addCartButton.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.0, alpha: 1)
			addCartButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
			break
		case 4:
			addCartButton.setTitle("即將開賣", forState: UIControlState.Normal)
			addCartButton.backgroundColor = UIColor.clearColor()
			addCartButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
			break;
		case 5:
			addCartButton.setTitle("預購結束", forState: UIControlState.Normal)
			addCartButton.backgroundColor = UIColor.clearColor()
			addCartButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
			break;
		case 6:
			addCartButton.setTitle("已售完", forState: UIControlState.Normal)
			addCartButton.backgroundColor = UIColor.clearColor()
			addCartButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
			break;
		case 7:
			addCartButton.setTitle("售完補貨中", forState: UIControlState.Normal)
			addCartButton.backgroundColor = UIColor.clearColor()
			addCartButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
			break;
		case 8:
			addCartButton.setTitle("搶購一空", forState: UIControlState.Normal)
			addCartButton.backgroundColor = UIColor.clearColor()
			addCartButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
			break;
			
		default: break
		}
		
	}

    
    func btnAddInCartPressed(sender :UIButton) {
		switch cartAction {
		case 0:	// "加入購物車" 
			// 點擊->加入購物車
//			numInCart++
//			if(numInCart <= 0) {
//				shopCartBtn.badgeString = nil
//			} else {
//				shopCartBtn.badgeString = String(MyApp.sharedShoppingCart.goodsList.count)
//			}
//			
//			//先寫入假資料
//			let info = ShoppingCartInfo()
//			comboData.itno  = "AB123000\(numInCart)"
//			comboData.sno   = "CC123000\(numInCart)"
			MyApp.sharedShoppingCart.insertGoodsIntoCart(ShoppingCartInfo())
			self.showSuccess("加入購物車成功!")
			shopCartBtn.badgeString = String(MyApp.sharedShoppingCart.goodsList.count)
			self.addCartNumber()
			break
		case 1: // "買立折"
			// 未登入：點擊 -> 登入 -> 滑出買立折 -> 選擇數量 -> 加入購物車
			// 登 入：點擊 -> 滑出買立折 -> 選擇數量 -> 加入購物車
			break
		case 2: // "立即搶購" 
			// 未登入：點擊 -> 登入 -> 選擇數量 -> 加入購物車
			// 登 入：點擊 -> 選擇數量 -> 加入購物車
			if MyApp.sharedMember.guid == "" {
				if let signInViewController = self.showSignInViewController() {
					signInViewController.delegate = self
				}
			} else {
				self.signInSuccess()
			}
			break
		case 3: // "立即預訂"
			// 未登入：點擊 -> 登入 -> 購物流程
			// 登 入：點擊 -> 購物流程
			if MyApp.sharedMember.guid == "" {
				if let signInViewController = self.showSignInViewController() {
					signInViewController.delegate = self
				}
			} else {
				MyApp.sharedShoppingCart.insertGoodsIntoCart(ShoppingCartInfo())
				self.jumpToShoppingCartTab()
			}
			break
		default: break
		}
		
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
    
    //畫刪除線
    func drawDeleteLine(price:String, priceLabel: UILabel) {
        let length = price.characters.count
        let attrString = NSMutableAttributedString(string: price)
        let range = NSMakeRange(0, length)
        attrString.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.PatternSolid.rawValue | NSUnderlineStyle.StyleSingle.rawValue, range: range)
        attrString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.lightGrayColor(), range: range)
        priceLabel.attributedText = attrString
    }
    
    //顯示規格頁
    func showSpecificViewController() -> SpecificViewController? {
        let specificViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SpecificViewController")
        specificViewController?.modalPresentationStyle = .CurrentContext
        
        if let specificViewController = specificViewController as? SpecificViewController {
            specificViewController.colorInfo = goodsResponse?.productInfo?.colorInfo
            specificViewController.sizeInfo = goodsResponse?.productInfo?.sizeInfo
            specificViewController.multiProductList = (goodsResponse?.productInfo?.multiProductList)!
            specificViewController.giftList = (goodsResponse?.giftInfo?.giftList)!
            specificViewController.itemInfo = goodsResponse?.itemInfo
            let nav = UINavigationController(rootViewController: specificViewController)
            self.presentViewController(nav, animated: true, completion: nil)
            return specificViewController
        }
        return nil
    }

    // MARK: - 呼叫api
    
    func getGoodsPageData(smSeq:String) {
        goodsPageModel?.getGoodsPageData(smSeq,completionHandler: { (goodsPage: GoodsPageResponse?, errorMessage:String?) -> Void in
            if (goodsPage == nil) {
                self.showAlert(errorMessage!)
            }
            else {
                self.goodsResponse = goodsPage!
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

// MARK: - SignInDelegate

extension GoodsTableViewController: SignInDelegate
{
	func signInSuccess() {
		log.debug("signInSuccess")

		switch cartAction {
//						case 1: // "買立折"
//			
//							break
		case 2: // "立即搶購"
			MyApp.sharedShoppingCart.insertGoodsIntoCart(ShoppingCartInfo())
			self.showSuccess("加入購物車成功!")
			shopCartBtn.badgeString = String(MyApp.sharedShoppingCart.goodsList.count)
			self.addCartNumber()
			break
		case 3: // "立即預訂"
			MyApp.sharedShoppingCart.insertGoodsIntoCart(ShoppingCartInfo())
			self.jumpToShoppingCartTab()
			self.addCartNumber()
			break
		default: break
		}
		
	}
	
	func signInCancel() {
		log.debug("signInCancel")
	}


}