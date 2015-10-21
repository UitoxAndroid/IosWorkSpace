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
	let basicCellIdentifier = "BasicCell"
	let headerCellIdentifier = "HeaderCell"
	var headerCell: HeaderCell?
	var searchListResponse: SearchListResponse?
	var listItem = [ItemInfo]()
	var	siSeq: String = ""
	var query: String = ""
	var buttonDefaultColor = UIColor.blueColor()
	var currentPage = 1
	var currentSortBy = SortBy.SmSoldQty
	var currentDesc = true

	lazy var placeholderImage: UIImage = {
		let image = UIImage(named: "PlaceholderImage")!
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
 
		
		let action = (searchListResponse?.storeList[indexPath.row].cartAction)
		if let action = action {
			switch action {
			case 0:
				cell.addCartButton.setTitle("加入購物車", forState: UIControlState.Normal)
				cell.addCartButton.backgroundColor = UIColor.redColor()
				break
			case 1:
				cell.addCartButton.setTitle("買立折", forState: UIControlState.Normal)
				cell.addCartButton.backgroundColor = UIColor.orangeColor()
				break
			case 2:
				cell.addCartButton.setTitle("立即搶購", forState: UIControlState.Normal)
				cell.addCartButton.backgroundColor = UIColor.redColor()
				break
			case 3:
				cell.addCartButton.setTitle("立即預訂", forState: UIControlState.Normal)
				cell.addCartButton.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.0, alpha: 1)
				break
			default: break
			}
		}
		
		
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
	
	
	// MARK - Call Api
	
	func getCategory(completionHandler: (categoryResponse: SearchListResponse?) -> Void) {
		if siSeq != "" {
			categoryData?.getCategoryData(siSeq, page: currentPage, sortBy: currentSortBy, desc: currentDesc) { (category: SearchListResponse?, errorMessage: String?) in
				self.clearAllNotice()
				if errorMessage != nil {
					self.showAlert(errorMessage!)
				} else {
					completionHandler(categoryResponse: category!)
				}
			}
		} else {
			searchData?.getSearchData(query, page: currentPage, sortBy: currentSortBy, desc: currentDesc) { (search: SearchListResponse?, errorMessage: String?) in
				self.clearAllNotice()
				if errorMessage != nil {
					self.showAlert(errorMessage!)
				} else {
					completionHandler(categoryResponse: search!)
				}
			}
		}
	}
	
}
