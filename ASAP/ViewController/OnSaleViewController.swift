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


	// MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

		setRightItemSearch()
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

		if let calCurrency = onSaleData[indexPath.row].calCurrency {
			price += calCurrency
		}

		if let calPrice = onSaleData[indexPath.row].calPrice {
			price += calPrice
		}

		cell.priceLabel.text = price
		cell.costLabel.text = ""

//		cell.imagedView.kf_showIndicatorWhenLoading = false

//		if let smPic = onSaleData[indexPath.row].smPic {
//			let url = NSURL(string: smPic)!
////			cell.imagedView.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly], progressBlock: { (receivedSize, totalSize) -> () in
////
////				}) { (image, error, cacheType, imageURL) -> () in
////
////			}
//		}

		if let smPic = onSaleData[indexPath.row].smPic {
			if let url = NSURL(string: smPic ) {
				if let data = NSData(contentsOfURL: url) {
					cell.imagedView.image = UIImage(data: data)
				}
			}
		}


        return cell
    }

	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerCell = tableView.dequeueReusableCellWithIdentifier(saleHeaderCellIdentifier) as! OnSaleHeaderCell

		return headerCell
	}

	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}

}
