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

	// MARK: - View

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.getDeployData()

        self.getDealsList()

		self.setRightItemSearch()
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
    
    func clickCurrentImage(currentIndxe: Int) {
        if let page_code = self.slideDataList[currentIndxe].pageCode {
            switch (page_code) {
            case "market":
                log.debug("\(self.slideDataList[currentIndxe].link!) \(self.slideDataList[currentIndxe].seq!)")
            case "category":
                log.debug("\(self.slideDataList[currentIndxe].link!) \(self.slideDataList[currentIndxe].seq!)")
            case "edm":
                log.debug("\(self.slideDataList[currentIndxe].link!) \(self.slideDataList[currentIndxe].seq!)")
            default:
                log.debug(self.slideDataList[currentIndxe].pageCode)
            }
        }
    }

    // MARK: -  首頁－圖片一大二小
    
    func set046Image() {
        var index = 0
        for iconLink:IconLinkData in self.iconDataList1 {
            if let url = NSURL(string: iconLink.img!) {
                if let data = NSData(contentsOfURL: url) {
                    switch index {
                    case 0:
                        self.m046Image1.image = UIImage(data: data)
                        index++
                    case 1:
                        self.m046Image2.image = UIImage(data: data)
                        index++
                    case 2:
                        self.m046Image3.image = UIImage(data: data)
                        index++
                    default:
                        index++
                    }
                }
            }
        }
    }
    
    // MARK: -  首頁－圖片二大二小
    
    func set047Image() {
        var index = 0
        for iconLink:IconLinkData in self.iconDataList2 {
            if let url = NSURL(string: iconLink.img!) {
                if let data = NSData(contentsOfURL: url) {
                    switch index {
                    case 0:
                        self.m047Image1.image = UIImage(data: data)
                        index++
                    case 1:
                        self.m047Image2.image = UIImage(data: data)
                        index++
                    case 2:
                        self.m047Image3.image = UIImage(data: data)
                        index++
                    case 3:
                        self.m047Image4.image = UIImage(data: data)
                        index++
                    default:
                        index++
                    }
                }
            }
        }
    }
    
	// MARK: -  首頁－整點特賣

	/*override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return 2
        default:
            return 1
        }
	}*/

	/*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            if(indexPath.row == 0)
            {
                return UITableViewCell()
            }
            
            var cell: DealsTableViewCell? = tableView.dequeueReusableCellWithIdentifier(reuseTableViewCellIdentifier, forIndexPath: indexPath) as? DealsTableViewCell
            //DealsTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseTableViewCellIdentifier) as? DealsTableViewCell
            if (cell == nil) {
                cell = DealsTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseTableViewCellIdentifier) as DealsTableViewCell
            }
            
            cell!.detailTextLabel?.text = "10:20:05"
            
            if (self.dealsView == nil) {
                self.dealsView = cell!.dealsCollectionView
            }
            return cell!
        default:
            //var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("ModelCell", forIndexPath: indexPath) as! UITableViewCell
            let cell = UITableViewCell()
            cell.textLabel?.text = "ModelCell"
            cell.accessoryType = UITableViewCellAccessoryType.DetailButton
            return cell
        }
        
	}*/

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
		if(indexPath.section == 0) {
            switch (indexPath.row) {
            case 0:
                return 120
            case 1:
                return self.linkDataList.count == 0 ? 0 : 40
            case 2:
                self.dealsTableCell.hidden = (self.dealsOnTimeData.count == 0)
                return self.dealsOnTimeData.count == 0 ? 0 : 176
            case 3:
                self.titleLabel1.hidden = (self.iconDataList1.count == 0)
                return self.iconDataList1.count == 0 ? 0 : 330
            case 4:
                self.titleLabel2.hidden = (self.productList1.count == 0)
                return self.productList1.count == 0 ? 0 : 176
            case 5:
                self.titleLabel3.hidden = (self.iconDataList2.count == 0)
                return self.iconDataList2.count == 0 ? 0 : 330
            case 6:
                self.titleLabel4.hidden = (self.productList2.count == 0)
                return self.productList2.count == 0 ? 0 : CGFloat(265 * (self.productList2.count / 2 + self.productList2.count % 2))
            default:
                return 0
            }
        }
        return 0
	}
    
    // MARK: - Call Api

	func getDeployData() {
		deployModel?.getDeployData("", completionHandler: { (deploy: DeployResponse?, errorMessage: String?) -> Void in
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

	func getDealsList() {
		dealsOnTimeModel.getDealsOntimeData { (dealsOntime, errorMessage) in
			if (dealsOntime == nil) {
				self.showAlert(errorMessage!)
			} else {
				self.dealsOnTimeData = dealsOntime!.dataList
                //self.dealsTableCell.countDownLabel.text = "04:10:05"
                self.dealsCollectionView.reloadData()
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
            
            if let pic = self.dealsOnTimeData[indexPath.row].smPic {
                if let url = NSURL(string: pic) {
                    if let data = NSData(contentsOfURL: url) {
                        cell.productImage.image = UIImage(data: data)
                    }
                }
            }
            
            if let itemName = self.dealsOnTimeData[indexPath.row].smName {
                cell.productNameLabel?.text = itemName
            }
            
            var price = ""
            
            if let calCurrency = self.dealsOnTimeData[indexPath.row].calCurrency {
                price += calCurrency
            }
            
            if let calPrice = self.dealsOnTimeData[indexPath.row].calPrice {
                price += calPrice
            }
            
            cell.productPriceLabel?.text = price
            
            return cell
        case 1:
            let cell: ModelCollectionViewCell1 = collectionView.dequeueReusableCellWithReuseIdentifier(reuseModelCollectionViewCellIdentifier1, forIndexPath: indexPath) as! ModelCollectionViewCell1
            
            if let pic = self.productList1[indexPath.row].img {
                if let url = NSURL(string: pic) {
                    if let data = NSData(contentsOfURL: url) {
                        cell.productImage.image = UIImage(data: data)
                    }
                }
            }
            
            if let itemName = self.productList1[indexPath.row].name {
                cell.productNameLabel?.text = itemName
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
                if let data = NSData(contentsOfURL: url) {
                    cell.productImage.image = UIImage(data: data)
                }
            }
            
            if let itemName = self.productList2[indexPath.row].name {
                cell.productNameLabel?.text = itemName
            }
            
            var price = ""
            
            /*if let smCurrency = self.productList[indexPath.row].smPrice {
            price += smCurrency
            }*/
            
            if let sugPrice = self.productList2[indexPath.row].price {
                price += sugPrice
            }
            
            
            cell.productPriceLabel?.text = price
            
            price = ""
            
            /*if let ssmCurrency = self.productList[indexPath.row].ssmPrice {
            price += ssmCurrency
            }*/
            
            if let smPrice = self.productList2[indexPath.row].smPrice {
                price += smPrice
            }
            
            cell.productSalePriceLabel?.text = price
            
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
            log.debug("點選\(indexPath.row)")
        case 1:
            let row = self.productList1[indexPath.row]
            log.debug("\(indexPath.row)-\(row.name)")
        case 2:
            let row = self.productList2[indexPath.row]
            log.debug("\(indexPath.row)-\(row.name)")
        case 3:
            let row = self.linkDataList[indexPath.row]
            log.debug("\(indexPath.row)-\(row.pageCode)")
        default:
            log.debug("點選\(indexPath.row)")
        }
    }

	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch collectionView.tag {
        case 0, 1:
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
