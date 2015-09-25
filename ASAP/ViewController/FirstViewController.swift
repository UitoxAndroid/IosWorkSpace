//
//  FirstViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/13.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet var adTableCell: ADTableViewCell!
    @IBOutlet var dealsTableCell: DealsTableViewCell!
    
    @IBOutlet var dealsCollectionView: UICollectionView!
    @IBOutlet var modelCollectionView: UICollectionView!
    
	lazy var deployModel:DeployModel?			= DeployModel()
	lazy var slideDataList:[SlideData]			= [SlideData]()
	lazy var productList:[ProductData]			= [ProductData]()
	lazy var dealsOnTimeModel:DealsOntimeModel	= DealsOntimeModel()
	lazy var dealsOnTimeData:[DealsOntimeData]	= []
	let reuseCollectionViewCellIdentifier		= "DealsCollectionCell"
	let reuseTableViewCellIdentifier			= "DealsCell"
    let reuseModelCollectionViewCellIdentifier  = "ModelCollectionCell"
    let reuseModelTableViewCellIdentifier       = "ModelCell"


	// MARK: - View

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.getDeployData()

        getDealsList()

		setRightItemSearch()
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
        self.circleView.delegate = adTableCell
        adTableCell.addSubview(self.circleView)
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
                return 200
            case 2:
                if(self.productList.count > 0) {
                    return CGFloat(225 * (self.productList.count / 2 + self.productList.count % 2))
                } else {
                    return 0
                }
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
				self.productList        = deploy!.dataList!.productDataList
                
                self.modelCollectionView.contentSize = CGSize(width: self.modelCollectionView.contentSize.width, height: CGFloat(220 * (self.productList.count / 2 + self.productList.count % 2)))
                
                self.tableView.reloadData()
                self.modelCollectionView.reloadData()
				self.pictureGallery()
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

//		return

//		let deal1 = ProductData()
//		deal1.img = "http://img02-tw1.uitoxbeta.com/A/show/2014/0709/AM0000010/201407AM090000010_047493227.png"
//		deal1.name = "Apple iPhone 5S 16GB -銀"
//		deal1.price = "21500"
//		productList.append(deal1)
//
//		let deal2 = ProductData()
//		deal2.img = "http://img02-tw1.uitoxbeta.com/A/show/2013/0925/AM0001074/201309AM250001074_417329728.jpg"
//		deal2.name = "Blue Star 折疊式老人機 A608"
//		deal2.price = "1790"
//		productList.append(deal2)
//
//		let deal3 = ProductData()
//		deal3.img = "http://img02-tw1.uitoxbeta.com/A/show/2013/0926/AM0000853/201309AM260000853_135974997.jpg"
//		deal3.name = "iNO CP99極簡風老人摺疊手機"
//		deal3.price = "1588"
//		productList.append(deal3)
//
//		let deal4 = ProductData()
//		deal4.img = "http://img02-tw1.uitoxbeta.com/A/show/2013/0926/AM0000870/201309AM260000870_400345476.jpg"
//		deal4.name = "iNO CP79摺疊式銀髮族手機"
//		deal4.price = "1490"
//		productList.append(deal4)
//
//		let deal5 = ProductData()
//		deal5.img = "http://img02-tw1.uitoxbeta.com/A/show/2013/0926/AM0000953/201309AM260000953_897866938.jpg"
//		deal5.name = "YAVi雅米 i05銀髮族極簡御守機"
//		deal5.price = "988"
//		productList.append(deal5)
	}
}


// MARK: - Collection View Data source and Delegate

extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag == 0) {
            return dealsOnTimeData.count
        } else {
            return productList.count
        }
	}

	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(collectionView.tag == 0) {
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
        } else {
            let cell: ModelCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseModelCollectionViewCellIdentifier, forIndexPath: indexPath) as! ModelCollectionViewCell
            
            if let url = NSURL(string: self.productList[indexPath.row].img!) {
                if let data = NSData(contentsOfURL: url) {
                    cell.productImage.image = UIImage(data: data)
                }
            }
            
            if let itemName = self.productList[indexPath.row].name {
                cell.productNameLabel?.text = itemName
            }
            
            var price = ""
            
            /*if let smCurrency = self.productList[indexPath.row].smPrice {
                price += smCurrency
            }*/
            
            if let sugPrice = self.productList[indexPath.row].price {
                price += sugPrice
            }
            
            cell.productPriceLabel?.text = price
            
            price = ""
            
            /*if let ssmCurrency = self.productList[indexPath.row].ssmPrice {
                price += ssmCurrency
            }*/
            
            if let smPrice = self.productList[indexPath.row].smPrice {
                price += smPrice
            }
            
            cell.productSalePriceLabel?.text = price
            
            return cell
        }
	}

	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		println("點選\(indexPath.row)")
    }

	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if(collectionView.tag == 0 ) {
            let width = (self.view.frame.width - 20) / 3
            return CGSize(width: width, height: collectionView.frame.height)
        } else {
            
            let width = (collectionView.frame.width - 20) / 2
            return CGSize(width: width, height: 230)
        }
	}
   
}
