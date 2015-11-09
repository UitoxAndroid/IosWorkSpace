//
//  KindViewController.swift
//  UitoxSample1
//
//  Created by uitox_macbook on 2015/8/26.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class KindViewController: UITableViewController
{
	lazy var categoryData:CategoryModel? = CategoryModel()
	lazy var searchData:SearchModel? = SearchModel()
    lazy var goodsPageModel:GoodsPageModel? = GoodsPageModel()
	lazy var campaignData:CampaignModel? = CampaignModel()
	let basicCellIdentifier = "BasicCell"
	let headerCellIdentifier = "HeaderCell"
	var headerCell: HeaderCell?
	var searchListResponse: SearchListResponse?
	var listItem = [ItemInfo]()
	var	siSeq: String = ""
	var query: String = ""
	var	campSeq: String = ""
	var buttonDefaultColor = UIColor.blueColor()
	var currentPage = 1
	var currentSortBy = SortBy.SmSoldQty
	var currentDesc = true
	var selectedButtonInfo:StoreInfo? = nil
    var pressedBtnTag:Int?

	lazy var placeholderImage: UIImage = {
		let image = UIImage(named: "no_img")!
		return image
	}()


    override func viewDidLoad() {
        super.viewDidLoad()

		setupRefresh()
	
		setRightItemSearch()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	
	// MARK: - MJRefresh
	
	func setupRefresh() {
		self.tableView.addFooterWithTarget(self, action: Selector("footerRereshing"))
	}
	
	func footerRereshing() {
		log.debug("footerRereshing")
		currentPage++
		getCategory() { (categoryResponse) -> Void in
			if let list = categoryResponse?.storeList {
				self.searchListResponse?.storeList += list
				self.tableView.reloadData()
			}
			
			self.tableView.footerEndRefreshing()
		}
	}
		
	
	// MARK: - IBAction
	
	@IBAction func soldQtySortOnClicked(sender: UIButton) {
		self.pleaseWait()

		currentPage = 1
		currentSortBy = SortBy.SmSoldQty
		currentDesc = true
		
		sender.setTitleColor(buttonDefaultColor, forState: UIControlState.Normal)
		
		let priceButton = self.tableView.viewWithTag(20) as? UIButton
		priceButton!.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
		priceButton!.setTitle("價格", forState: UIControlState.Normal)

		getCategory() { (categoryResponse) -> Void in
			self.searchListResponse = categoryResponse
			self.tableView.reloadData()
			self.scrollToTop()
		}
	}
	
	@IBAction func priceSortOnClicked(sender: UIButton) {	
		self.pleaseWait()
		
		currentPage = 1
		currentSortBy = SortBy.UitoxPrice
		
		sender.setTitleColor(buttonDefaultColor, forState: UIControlState.Normal)
		
		let soldQtyButton = self.tableView.viewWithTag(10) as? UIButton
		soldQtyButton!.titleLabel?.textColor = UIColor.darkGrayColor()
		
		if sender.titleLabel?.text?.containsString("↓") == true {
			currentDesc = false
			sender.setTitle("價格↑", forState: UIControlState.Normal)
		} else if sender.titleLabel?.text?.containsString("↑") == true {
			currentDesc = true
			sender.setTitle("價格↓", forState: UIControlState.Normal)
		} else {
			currentDesc = true
			sender.setTitle("價格↓", forState: UIControlState.Normal)
		}
					
		getCategory() { (categoryResponse) -> Void in
			self.searchListResponse = categoryResponse
			self.tableView.reloadData()
			self.scrollToTop()
		}
	}

	func scrollToTop() {
		if self.numberOfSectionsInTableView(self.tableView) > 0 {
			let top = NSIndexPath(forRow: NSNotFound, inSection: 0)
			self.tableView.scrollToRowAtIndexPath(top, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
		}
	}
	
    @IBAction func addCartButtonClick(sender: AnyObject) {
        let tag = (sender as? UIButton)!.tag
		
		selectedButtonInfo = self.searchListResponse!.storeList[tag]
		
		if(selectedButtonInfo!.smSeq == nil) {
			selectedButtonInfo = nil
			self.showError("資料有誤")
			return
		}

		let action = self.convertCartButtonAction(selectedButtonInfo!.cartAction)
		
		switch action {
		case 0:	// "加入購物車" 點按鈕->加入購物車
			MyApp.sharedShoppingCart.insertGoodsIntoCart(ShoppingCartInfo())
			self.showSuccess("加入購物車成功!")
			self.addCartNumber()
			break
		case 1: // "買立折"
            if MyApp.sharedMember.guid == "" {
                if let signInViewController = self.showSignInViewController() {
                    signInViewController.delegate = self
                }
            } else {
                pressedBtnTag = tag
                self.signInSuccess()
            }
            break
		case 2: // "立即搶購" 點按鈕->登入->加入購物車
			if MyApp.sharedMember.guid == "" {
				if let signInViewController = self.showSignInViewController() {
					signInViewController.delegate = self
				}
			} else {
				self.signInSuccess()
			}
			break
		case 3: // "立即預訂" 點按鈕->登入->購買流程
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

//        self.directPage(tag)
    }
	
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let searchListResponse = self.searchListResponse {
			return searchListResponse.storeList.count
		}
		return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier( basicCellIdentifier) as! BasicCell

		cell.titleLabel.text =  searchListResponse!.storeList[indexPath.row].name
		
		cell.subtitleLabel.text = ""
		
		if searchListResponse!.storeList[indexPath.row].slogan.count > 0 {
			let sloganCnt = searchListResponse!.storeList[indexPath.row].slogan.count
			let cnt = sloganCnt > 2 ? 2 : sloganCnt
			for(var i = 0; i < cnt; i++) {
				cell.subtitleLabel.text = cell.subtitleLabel.text! + searchListResponse!.storeList[indexPath.row].slogan[i] + "\n"
			}
		}

		
		cell.priceLabel.text = ""
		if let finalPrice = searchListResponse!.storeList[indexPath.row].finalPrice {
			cell.priceLabel.text = "$"
			cell.priceLabel.text = cell.priceLabel.text! + String(finalPrice)
			
			cell.costLabel.text = ""
			if let showPrice = searchListResponse!.storeList[indexPath.row].showPrice {
				//show_price 需大於 final_price 才可顯示
				if showPrice > finalPrice {
					cell.costLabel.text = "$"
					cell.costLabel.text = cell.costLabel.text! + String(showPrice)	
					drawDeleteLine(cell.costLabel.text!, priceLabel: cell.costLabel)
				}
			}
		}
		
		let action = self.convertCartButtonAction(searchListResponse?.storeList[indexPath.row].cartAction)
		
		self.handleBtnAttr(action, addCartButton: cell.addCartButton)
		cell.addCartButton.tag = indexPath.row
		
		let URL = NSURL(string: searchListResponse!.storeList[indexPath.row].pic!)!

		//使用Kingfisher以Url當key
		cell.imagedView.kf_setImageWithURL(URL, placeholderImage: placeholderImage, 
			optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)], 
			progressBlock: { (receivedSize, totalSize) -> () in
				log.debug("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
			}) { (image, error, cacheType, imageURL) -> () in
				if error != nil  {
					log.debug(error?.description)
				}
				
				log.debug("\(indexPath.row + 1): Finished")
		}

		
//		使用Kingfisher以Url當key
//		let resource = Resource(downloadURL: URL)
//		cell.imagedView.kf_setImageWithResource( resource, placeholderImage: nil, optionsInfo: nil, progressBlock: { (receivedSize, totalSize) -> () in
//			log.debugln("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
//			}) { (image, error, cacheType, imageURL) -> () in
//				if error != nil  {
//					log.debugln(error?.description)
//				}
//
//				log.debugln("\(indexPath.row + 1): Finished")
//		}
		
//		自己寫非同步
//		if cell.imagedView.image == nil {
//			if let url = NSURL(string: searchListResponse!.storeList[indexPath.row].pic! ) {
//				downloadImage(url, imageView: cell.imagedView)
//			}
//			
//		}
		
        return cell
    }

	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if headerCell == nil {
			headerCell = tableView.dequeueReusableCellWithIdentifier(headerCellIdentifier) as? HeaderCell
			buttonDefaultColor = (headerCell!.soldQtyButton.titleColorForState(UIControlState.Normal))!	
		}
		
		return headerCell
	}

	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.directPage(indexPath.row)
    }
	
	// MARK - Method
	
	func getDataFromUrl(url:NSURL, completeion: ((data: NSData?) -> Void)) {
		NSURLSession.sharedSession().dataTaskWithURL(url) {
			(data, reseponse, error) in 
			completeion(data: data)
			}.resume()
	}
	
	func downloadImage(url:NSURL, imageView:UIImageView) {
		log.debug(url.URLString)
		getDataFromUrl(url) { data in
			dispatch_async(dispatch_get_main_queue()) {
				imageView.image = UIImage(data: data!)
			}
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
	
    // 導向面頁
    func directPage(index: Int) {
        let row = self.searchListResponse!.storeList[index]
        
        if(row.smSeq == nil) {
            self.showError("資料有誤")
            return
        }
		
		let action = convertCartButtonAction(row.cartAction)
		
        self.pleaseWait()
		getGoodsPageData(row.smSeq!, cartAction: action, isFromBtn: false)
    }
	
	// 將購物車判斷轉為數字代碼
	func convertCartButtonAction(cartAction: String?) -> Int {
		guard let cartAction = cartAction else {
			return 4
		}
		
		switch cartAction {
		//加入購物車
		case "btn-addcart":
			return 0
		//買立折
		case "btn-discount":
			return 1
		//限購
		case "btn-rush":
			return 2
		//預購
		case "btn-preorder":
			return 3
		//即將開賣
		case "btn-to-sale":
			return 4
		//售完補貨中
		case "btn-soldout-stock":
			return 5
		//已售完
		case "btn-soldout":
			return 6
		//已搶購一空
		case "btn-rush-finish":
			return 7
		//預購結束
		case "btn-preorder-finish":
			return 8
		default: break
		}

		return 4
	}
 
	
	// MARK - Call Api
	
	func getCategory(completionHandler: (categoryResponse: SearchListResponse?) -> Void) {
		if siSeq != "" {
			categoryData?.getCategoryData(siSeq, page: currentPage, sortBy: currentSortBy, desc: currentDesc) { (category: SearchListResponse?, errorMessage: String?) in
				self.clearAllNotice()
				self.tableView.footerEndRefreshing()

				if errorMessage != nil {
					self.showError(errorMessage!)
				} else {
					completionHandler(categoryResponse: category!)
				}
			}
		} else if campSeq != "" {
			campaignData?.getCampaignData(campSeq, page: currentPage, sortBy: currentSortBy, desc: currentDesc) { (campaign:SearchListResponse?, errorMessage: String?) in
				self.clearAllNotice()
				self.tableView.footerEndRefreshing()

				if(errorMessage != nil) {
					self.showError(errorMessage!)
				} else {
					completionHandler(categoryResponse: campaign!)
				}
			}
		} else {
			searchData?.getSearchData(query, page: currentPage, sortBy: currentSortBy, desc: currentDesc) { (search: SearchListResponse?, errorMessage: String?) in
				self.clearAllNotice()
				self.tableView.footerEndRefreshing()

				if errorMessage != nil {
					self.showError(errorMessage!)
				} else {
					completionHandler(categoryResponse: search!)
				}
			}
		}
	}
    
    // 取得單品頁資料
    func getGoodsPageData(smSeq: String, cartAction: Int, isFromBtn:Bool) {
        goodsPageModel?.getGoodsPageData(smSeq, completionHandler: { (goodsPage: GoodsPageResponse?, errorMessage:String?) -> Void in
            self.clearAllNotice()

            if (goodsPage == nil) {
                self.showAlert(errorMessage!)
            }
            else {
                if(goodsPage!.itemInfo == nil) {
                    self.showError("No Data")
                    return
                }
            
                if isFromBtn == false {
                    self.pushToGoodsViewController(goodsPage, cartAction: cartAction)
                } else {
                    self.showDiscountViewController(goodsPage)
                }
                
            }
        })
    }
    
    //顯示買立折頁
    func showDiscountViewController(goodsPage: GoodsPageResponse?) -> PromptDiscountViewController? {
        guard let goodsPage = goodsPage else {
            return nil
        }
        
        let discountViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PromptDiscountViewController")
        discountViewController?.modalPresentationStyle = .CurrentContext
        
        if let discountViewController = discountViewController as? PromptDiscountViewController {
            discountViewController.goodsResponse = goodsPage
            let nav = UINavigationController(rootViewController: discountViewController)
            self.presentViewController(nav, animated: true, completion: nil)
            return discountViewController
        }
        return nil
    }

    

}


// MARK: - SignInDelegate

extension KindViewController: SignInDelegate
{
	func signInSuccess() {
		log.debug("signInSuccess")
		let action = self.convertCartButtonAction(selectedButtonInfo!.cartAction)
		switch action {
		case 1: // "買立折"
            let smSeq = self.searchListResponse!.storeList[pressedBtnTag!].smSeq
            if(smSeq == nil) {
                self.showError("資料有誤")
                return
            }
            self.pleaseWait()
            getGoodsPageData(smSeq!, cartAction: 1, isFromBtn: true)
		break
		case 2: // "立即搶購"
			MyApp.sharedShoppingCart.insertGoodsIntoCart(ShoppingCartInfo())
			self.showSuccess("加入購物車成功!")
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