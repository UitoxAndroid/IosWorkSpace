//
//  FirstViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/13.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController, CirCleViewDelegate
{

    @IBOutlet var adTableCell: ADTableViewCell!
    @IBOutlet var dealsTableCell: DealsTableViewCell!
    
    @IBOutlet var linkCollectionView: UICollectionView!
    @IBOutlet var dealsCollectionView: UICollectionView!
    @IBOutlet var modelCollectionView1: UICollectionView!
    @IBOutlet var modelCollectionView2: UICollectionView!
    
    @IBOutlet var titleLabel1: UILabel!
    @IBOutlet var titleLabel2: UILabel!
    @IBOutlet var titleLabel3: UILabel!
    @IBOutlet var titleLabel4: UILabel!
    
    @IBOutlet var m046Image1: UIImageView!
    @IBOutlet var m046Image2: UIImageView!
    @IBOutlet var m046Image3: UIImageView!
    
    @IBOutlet var m047Image1: UIImageView!
    @IBOutlet var m047Image2: UIImageView!
    @IBOutlet var m047Image3: UIImageView!
    @IBOutlet var m047Image4: UIImageView!
    
    lazy var deployModel:DeployModel?			= DeployModel()
    lazy var goodsPageModel:GoodsPageModel?     = GoodsPageModel()
    lazy var categoryData:CategoryModel?        = CategoryModel()
    lazy var searchData:SearchModel?            = SearchModel()
    
    lazy var slideDataList:[SlideData]			= [SlideData]()
    lazy var linkDataList:[LinkData]            = [LinkData]()
    lazy var iconDataList1:[IconLinkData]       = [IconLinkData]()
    lazy var iconDataList2:[IconLinkData]       = [IconLinkData]()
    lazy var productList1:[ProductData]			= [ProductData]()
	lazy var productList2:[ProductData]			= [ProductData]()
    
	lazy var dealsOnTimeModel:DealsOntimeModel	= DealsOntimeModel()
	lazy var dealsOnTimeData:[DealsOntimeData]	= []
    
    let reuseLinkCollectionViewCellIdentifier   = "LinkCollectionCell"
	let reuseCollectionViewCellIdentifier		= "DealsCollectionCell"
    let reuseTableViewCellIdentifier			= "DealsCell"
    let reuseModelCollectionViewCellIdentifier1 = "ModelCollectionCell1"
    let reuseModelCollectionViewCellIdentifier2 = "ModelCollectionCell2"
    
    lazy var placeholderImage: UIImage = {
        let image = UIImage(named: "PlaceholderImage")!
        return image
        }()
    
    // MARK: - View

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

	}

	override func viewDidLoad() {
		super.viewDidLoad()
        
        self.setImageTapAction()
        
		self.getDeployData()

        self.getDealsList()

		self.setRightItemSearch()
	}
    
    // 圖片Click事件
    func setImageTapAction() {
        let imageTap046_1 = UITapGestureRecognizer(target: self, action: Selector("imageTapAction046:"))
        m046Image1.addGestureRecognizer(imageTap046_1)
        let imageTap046_2 = UITapGestureRecognizer(target: self, action: Selector("imageTapAction046:"))
        m046Image2.addGestureRecognizer(imageTap046_2)
        let imageTap046_3 = UITapGestureRecognizer(target: self, action: Selector("imageTapAction046:"))
        m046Image3.addGestureRecognizer(imageTap046_3)
        
        let imageTap047_1 = UITapGestureRecognizer(target: self, action: Selector("imageTapAction047:"))
        m047Image1.addGestureRecognizer(imageTap047_1)
        let imageTap047_2 = UITapGestureRecognizer(target: self, action: Selector("imageTapAction047:"))
        m047Image2.addGestureRecognizer(imageTap047_2)
        let imageTap047_3 = UITapGestureRecognizer(target: self, action: Selector("imageTapAction047:"))
        m047Image3.addGestureRecognizer(imageTap047_3)
        let imageTap047_4 = UITapGestureRecognizer(target: self, action: Selector("imageTapAction047:"))
        m047Image4.addGestureRecognizer(imageTap047_4)
    }
    
	override func prefersStatusBarHidden() -> Bool {
		return false
	}

	override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
		if dealsOnTimeData.count > 0 {
			return true
		}
		return false
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ShowOnSaleViewController" {

			if let onSaleViewController = segue.destinationViewController as? OnSaleViewController {
				if dealsOnTimeData.count > 0 {
					onSaleViewController.onSaleData = dealsOnTimeData
				}
			}
		}
	}


	// MARK: -  首頁－輪播廣告

	var circleView: CirCleView!
	var imageArray: [UIImage!] = []

	func pictureGallery() {
		for slideData:SlideData in self.slideDataList {
			if let url = NSURL(string: slideData.img!) {
				if let data = NSData(contentsOfURL: url) {
					self.imageArray.append(UIImage(data: data))                }
			}
		}

		self.circleView = CirCleView(frame: CGRectMake(0, 0, self.view.frame.size.width, 120), imageArray: self.imageArray)
        self.circleView.delegate = self
        self.view.addSubview(self.circleView)
	}
    
    // 廣告輸播-點選
    func clickCurrentImage(currentIndxe: Int) {
        let row = self.slideDataList[currentIndxe]
        self.directPage(row.pageCode, seq: row.seq)
    }
    
    // 整點特賣-搶購-點選
    @IBAction func buyButtonClick(sender: AnyObject) {
        let tag = (sender as? UIButton)!.tag
        let row = self.dealsOnTimeData[tag]
        self.directPage("item", seq: row.smSeq)
    }
    
    // 商品2-搶購
    @IBAction func buyProduct2ButtonClick(sender: AnyObject) {
        let tag = (sender as? UIButton)!.tag
        let row = self.productList2[tag]
        self.directPage("item", seq: row.smSeq)
    }
    // MARK: -  首頁－圖片一大二小
    
    func set046Image() {
        var index = 0
        for iconLink:IconLinkData in self.iconDataList1 {
            if let url = NSURL(string: iconLink.img!) {
                    switch index {
                    case 0:
                        self.m046Image1.kf_setImageWithURL(url, placeholderImage: placeholderImage,
                            optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
                        self.m046Image1.userInteractionEnabled = true
                        index++
                    case 1:
                        self.m046Image2.kf_setImageWithURL(url, placeholderImage: placeholderImage,
                            optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
                        self.m046Image2.userInteractionEnabled = true
                        index++
                    case 2:
                        self.m046Image3.kf_setImageWithURL(url, placeholderImage: placeholderImage,
                            optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
                        self.m046Image3.userInteractionEnabled = true
                        index++
                    default:
                        index++
                    }
            }
        }
    }
    
    func imageTapAction046(tap: UITapGestureRecognizer) {
        if let imageView = tap.view as? UIImageView {
            let row = self.iconDataList1[imageView.tag]
            self.directPage(row.pageCode, seq: row.seq)
        }
    }
    
    // MARK: -  首頁－圖片二大二小
    
    func set047Image() {
        var index = 0
        for iconLink:IconLinkData in self.iconDataList2 {
            if let url = NSURL(string: iconLink.img!) {
                    switch index {
                    case 0:
                        self.m047Image1.kf_setImageWithURL(url, placeholderImage: placeholderImage,
                            optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
                        self.m047Image1.userInteractionEnabled = true
                        index++
                    case 1:
                        self.m047Image2.kf_setImageWithURL(url, placeholderImage: placeholderImage,
                            optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
                        self.m047Image2.userInteractionEnabled = true
                        index++
                    case 2:
                        self.m047Image3.kf_setImageWithURL(url, placeholderImage: placeholderImage,
                            optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
                        self.m047Image3.userInteractionEnabled = true
                        index++
                    case 3:
                        self.m047Image4.kf_setImageWithURL(url, placeholderImage: placeholderImage,
                            optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
                        self.m047Image4.userInteractionEnabled = true
                        index++
                    default:
                        index++
                    }
            }
        }
    }
    
    func imageTapAction047(tap: UITapGestureRecognizer) {
        if let imageView = tap.view as? UIImageView {
            let row = self.iconDataList2[imageView.tag]
            self.directPage(row.pageCode, seq: row.seq)
        }
    }

    // MARK : tableView
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
		if(indexPath.section == 0) {
            switch (indexPath.row) {
            case 0:
                return 120
            case 1:
                return self.linkDataList.count == 0 ? 0 : 40
            case 2:
                self.dealsTableCell.hidden = (self.dealsOnTimeData.count == 0)
                return self.dealsOnTimeData.count == 0 ? 0 : 170
            case 3:
                self.titleLabel1.hidden = (self.iconDataList1.count == 0)
                return self.iconDataList1.count == 0 ? 0 : 280
            case 4:
                self.titleLabel2.hidden = (self.productList1.count == 0)
                return self.productList1.count == 0 ? 0 : 176
            case 5:
                self.titleLabel3.hidden = (self.iconDataList2.count == 0)
                return self.iconDataList2.count == 0 ? 0 : 280
            case 6:
                self.titleLabel4.hidden = (self.productList2.count == 0)
                return self.productList2.count == 0 ? 0 : CGFloat(245 * (self.productList2.count / 2 + self.productList2.count % 2))
            default:
                return 0
            }
        }
        return 0
	}
    
    // 導向對應頁面
    func directPage(pageCode: String?, seq: String?) {
        if(pageCode == nil || seq == nil) {
            self.showError("資料有誤")
            return
        }
        
        self.pleaseWait()

        switch pageCode! {
        case "item":
            self.getGoodsPageData(seq!)
        case "market","category":
            self.getCategoryData(seq!)
        case "search":
            self.getSearchData(seq!)
        default:
            self.showAlert("No Data")
            self.clearAllNotice()
        }
    }
    
    // MARK: - Call Api
    // 取得首頁輪播+佈置清單
	func getDeployData() {
        self.pleaseWait()
		deployModel?.getDeployData("", completionHandler: { (deploy: DeployResponse?, errorMessage: String?) -> Void in
            self.clearAllNotice()
			if (deploy == nil) {
				self.showAlert(errorMessage!)
			} else {
				self.deployModel?.deploy = deploy!
				self.slideDataList      = deploy!.dataList!.slideDataList
                self.linkDataList       = deploy!.dataList!.linkDataList
                self.iconDataList1      = deploy!.dataList!.iconLinkDataList1
                self.iconDataList2      = deploy!.dataList!.iconLinkDataList2
				self.productList1       = deploy!.dataList!.productDataList1
   				self.productList2       = deploy!.dataList!.productDataList2

                self.modelCollectionView2.contentSize = CGSize(width: self.modelCollectionView2.contentSize.width, height: CGFloat(220 * (self.productList2.count / 2 + self.productList2.count % 2)))
                
                self.tableView.reloadData()
                self.linkCollectionView.reloadData()
                self.modelCollectionView1.reloadData()
                self.modelCollectionView2.reloadData()
				self.pictureGallery()
                
                self.set046Image()
                self.set047Image()
			}
		})
	}
    
    // 取得整點特賣清單
	func getDealsList() {
		dealsOnTimeModel.getDealsOntimeData { (dealsOntime, errorMessage) in
			if (dealsOntime == nil) {
				self.showAlert(errorMessage!)
			} else {
				self.dealsOnTimeData = dealsOntime!.dataList
                
                self.tableView.reloadData()
                self.dealsCollectionView.reloadData()
            }
		}
	}
    
    // 取得單品頁資料
    func getGoodsPageData(smSeq: String) {
        goodsPageModel?.getGoodsPageData( smSeq, completionHandler: { (goodsPage: GoodsPageResponse?, errorMessage:String?) -> Void in
            self.clearAllNotice()
            if (goodsPage == nil) {
                self.showAlert(errorMessage!)
            }
            else {
                if(goodsPage!.itemInfo == nil) {
                    self.showError("No Data")
                    return
                }
                
                let goodsView = self.storyboard?.instantiateViewControllerWithIdentifier("GoodsTableViewController") as! GoodsTableViewController
                goodsView.goodsResponse = goodsPage!
                self.navigationController?.pushViewController(goodsView, animated: true)
            }
        })
    }

    // 取得館頁資料
    func getCategoryData(siSeq: String){
        categoryData?.getCategoryData(siSeq, page: 1, sortBy: SortBy.SmSoldQty, desc: true) { (category: SearchListResponse?, errorMessage: String?) in
            self.clearAllNotice()
            if errorMessage != nil {
                self.showAlert(errorMessage!)
            } else {
                let kindViewController = self.storyboard?.instantiateViewControllerWithIdentifier("KindViewController") as? KindViewController
                kindViewController!.searchListResponse  = category!
                
                kindViewController!.siSeq               = siSeq
                self.navigationController?.pushViewController(kindViewController!, animated: true)
            }
        }
    }
    
    // 取得搜尋頁資料
    func getSearchData(query: String) {
        searchData?.getSearchData(query, page: 1, sortBy: SortBy.SmSoldQty, desc: true) { (search: SearchListResponse?, errorMessage: String?) in
            self.clearAllNotice()
            if search == nil {
                self.showAlert(errorMessage!)
            } else {
                let kindViewController = self.storyboard?.instantiateViewControllerWithIdentifier("KindViewController") as? KindViewController
                kindViewController!.searchListResponse = search!
                kindViewController!.query = query
                self.navigationController?.pushViewController(kindViewController!, animated: true)
            }
        }
    }
}


// MARK: - Collection View Data source and Delegate

extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return self.dealsOnTimeData.count
        case 1:
            return self.productList1.count
        case 2:
            return self.productList2.count
        case 3:
            return self.linkDataList.count
        default:
            return 0
        }
	}

	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell: DealsCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseCollectionViewCellIdentifier, forIndexPath: indexPath) as! DealsCollectionViewCell
            
            if var startHour = self.dealsOnTimeData[indexPath.row].promoHour {
                startHour += ":00:00"
                self.dealsTableCell.countDownLabel.text = startHour
            }
            
            if let pic = self.dealsOnTimeData[indexPath.row].smPic {
                if let url = NSURL(string: pic) {
                    cell.productImage.kf_setImageWithURL(url, placeholderImage: placeholderImage,
                        optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
                }
            } else {
                cell.productImage.image = placeholderImage
            }
            
            
            if let itemName = self.dealsOnTimeData[indexPath.row].smName {
                cell.productNameLabel?.text = itemName
                cell.productNameLabel.sizeToFit() // 文字置頂
            } else {
                cell.productNameLabel?.text = ""
            }
            
            var price = ""
            
            if let smCurrency = self.dealsOnTimeData[indexPath.row].calCurrency {
                price += smCurrency
            }
            
            if let sugPrice = self.dealsOnTimeData[indexPath.row].smPrice {
                price = (sugPrice == "0") ? "" : price + sugPrice
            }
            
            // 刪除線
            var myMutableString = NSMutableAttributedString()
            myMutableString     = NSMutableAttributedString(string: price)
            myMutableString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, myMutableString.length))
            cell.productPriceLabel.attributedText = myMutableString
            
            price = ""
            
            if let ssmCurrency = dealsOnTimeData[indexPath.row].calCurrency {
                price += ssmCurrency
            }
            
            if let smPrice = self.dealsOnTimeData[indexPath.row].calPrice {
                price += smPrice
            }
            
            cell.productSalePriceLabel?.text = price
            
            cell.addCartButton.tag = indexPath.row
            
            return cell
        case 1:
            let cell: ModelCollectionViewCell1 = collectionView.dequeueReusableCellWithReuseIdentifier(reuseModelCollectionViewCellIdentifier1, forIndexPath: indexPath) as! ModelCollectionViewCell1
            
            if let pic = self.productList1[indexPath.row].img {
                if let url = NSURL(string: pic) {
                    cell.productImage.kf_setImageWithURL(url, placeholderImage: placeholderImage,
                        optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
                }
            } else {
                cell.productImage.image = placeholderImage
            }
            
            if let itemName = self.productList1[indexPath.row].name {
                cell.productNameLabel?.text = itemName
                cell.productNameLabel?.sizeToFit()
            }
            
            var price = ""
            
            /*if let smCurrency = self.productList[indexPath.row].smPrice {
            price += smCurrency
            }*/
            
            if let sugPrice = self.productList1[indexPath.row].price {
                price += sugPrice
            }
            
            cell.productPriceLabel?.text = price
            
            return cell
        case 2:
            let cell: ModelCollectionViewCell2 = collectionView.dequeueReusableCellWithReuseIdentifier(reuseModelCollectionViewCellIdentifier2, forIndexPath: indexPath) as! ModelCollectionViewCell2
            
            if let url = NSURL(string: self.productList2[indexPath.row].img!) {
                cell.productImage.kf_setImageWithURL(url, placeholderImage: placeholderImage,
                    optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
            } else {
                cell.productImage.image = placeholderImage
            }

        
            if let itemName = self.productList2[indexPath.row].name {
                cell.productNameLabel?.text = itemName
            }
            
            var price = ""
            
            /*if let smCurrency = self.productList[indexPath.row].smPrice {
            price += smCurrency
            }*/
            
            if let sugPrice = self.productList2[indexPath.row].price {
                price = (sugPrice == "0") ? "" : price + sugPrice
            }
            
            // 刪除線
            var myMutableString = NSMutableAttributedString()
            myMutableString     = NSMutableAttributedString(string: price)
            myMutableString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, myMutableString.length))
            cell.productPriceLabel.attributedText = myMutableString
            
            price = ""
            
            /*if let ssmCurrency = self.productList[indexPath.row].ssmPrice {
            price += ssmCurrency
            }*/
            
            if let smPrice = self.productList2[indexPath.row].smPrice {
                price += smPrice
            }
            
            cell.productSalePriceLabel?.text = price
            
            cell.addCartButton.tag = indexPath.row

            return cell
        case 3:
            let cell: LinkCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseLinkCollectionViewCellIdentifier, forIndexPath: indexPath) as! LinkCollectionViewCell
            
            cell.verticalBarLabel.hidden = (indexPath.row == 0)
            if let linkName = self.linkDataList[indexPath.row].name {
                //cell.linkButton?.setTitle("", forState: UIControlState.Normal)
                cell.linkLabel?.text = linkName
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
	}

	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch collectionView.tag {
        case 0:
            let row = self.dealsOnTimeData[indexPath.row]
            self.directPage("item", seq: row.smSeq)
        case 1:
            let row = self.productList1[indexPath.row]
            self.directPage("item", seq: row.smSeq)
        case 2:
            let row = self.productList2[indexPath.row]
            self.directPage("item", seq: row.smSeq)
        case 3:
            let row = self.linkDataList[indexPath.row]
            self.directPage(row.pageCode, seq: row.seq)
        default:
            log.debug("點選\(indexPath.row)")
        }
    }

	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case 1:
            let width = (self.view.frame.width - 16 - 8) / 3
            return CGSize(width: width, height: collectionView.frame.height)
        case 2:
            let width = (collectionView.frame.width - 20) / 2
            return CGSize(width: width, height: 230)
        case 3:
            let width = (self.view.frame.width - 16 - 8) / 3
            return CGSize(width: width, height: 33 )
        default:
            return CGSize(width: 0.0, height: 0.0)
        }
	}
   
}
