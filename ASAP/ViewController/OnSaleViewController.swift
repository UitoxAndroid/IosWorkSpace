//
//  OnSaleViewController
//  ASAP
//
//  Created by uitox_macbook on 2015/8/26.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class OnSaleViewController: UITableViewController
{
    
	let saleCellIdentifier = "SaleCell"
	let saleHeaderCellIdentifier = "OnSaleHeaderCell"
	var onSaleData: [DealsOntimeData] = []
    var listItem = [ItemInfo]()
    
    lazy var goodsPageModel:GoodsPageModel?     = GoodsPageModel()

	lazy var placeholderImage: UIImage = {
		let image = UIImage(named: "PlaceholderImage")!
		return image
	}()


	// MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

		setRightItemSearch()
	}
    
    @IBAction func addCartButtonClick(sender: AnyObject) {
        let tag = (sender as? UIButton)!.tag
        self.directPage(tag)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return onSaleData.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(saleCellIdentifier) as! BasicCell

		cell.titleLabel.text = onSaleData[indexPath.row].smName
		cell.timeLabel.text = onSaleData[indexPath.row].promoHour! + ":00"

		var price = ""
        var currency = ""
        
        if let calCurrency = onSaleData[indexPath.row].calCurrency {
            currency = calCurrency
        }
        
        if let smPrice = self.onSaleData[indexPath.row].smPrice {
            price = (smPrice == "0") ? "" : currency + smPrice
        }
        
        cell.costLabel.text = price
        
        // 刪除線
        var myMutableString = NSMutableAttributedString()
        myMutableString     = NSMutableAttributedString(string: price)
        myMutableString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, myMutableString.length))
        cell.costLabel.attributedText = myMutableString
        
		if let calPrice = onSaleData[indexPath.row].calPrice {
			price = currency + calPrice
		}

		cell.priceLabel.text = price
        
        price = ""
        if let costPrice = onSaleData[indexPath.row].smPrice {
            price += costPrice
        }
		
		cell.imagedView.image = placeholderImage
		
		if let smPic = onSaleData[indexPath.row].smPic {
			if let url = NSURL(string: smPic ) {
				cell.imagedView.kf_setImageWithURL(url, placeholderImage: placeholderImage, optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)])
			}
		}

        cell.addCartButton.tag = indexPath.row

        return cell
    }

	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerCell = tableView.dequeueReusableCellWithIdentifier(saleHeaderCellIdentifier) as! OnSaleHeaderCell

		return headerCell
	}

	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.directPage(indexPath.row)
    }
    
    // 導向面頁
    func directPage(index: Int) {
        let row = self.onSaleData[index]
        
        if(row.smSeq == nil) {
            self.showError("資料有誤")
            return
        }
        
        self.pleaseWait()
        getGoodsPageData(row.smSeq!)
    }
    
    // MARK : Call Api    
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

}
