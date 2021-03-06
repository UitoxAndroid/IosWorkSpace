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
	let basicCellIdentifier = "BasicCell"
	let headerCellIdentifier = "HeaderCell"
	var searchListResponse: SearchListResponse?
	var listItem = [ItemInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()

		let info = ItemInfo()
		info.title = "得意連續抽取式花紋衛生紙得意得意得意得意得意得意得意得意"
		info.subtitle = "紙張加厚 更吸水更吸水更吸水更吸水更吸水更吸水"
		info.cost = 930
		info.price = 599
		listItem.append(info)

		setRightItemSearch()

	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
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

//		cell.titleLabel.text =  listItem[indexPath.row].title
//		cell.subtitleLabel.text = listItem[indexPath.row].subtitle
//		cell.costLabel.text = "$" + String(listItem[indexPath.row].cost)
//		cell.priceLabel.text = "$" + String(listItem[indexPath.row].price)

		cell.titleLabel.text =  searchListResponse!.storeList[indexPath.row].name

//		if let slogan = searchListResponse!.storeList[indexPath.row].marketInfo?.slogan {
//			if slogan.count > 0 {
//				cell.subtitleLabel.text = searchListResponse!.storeList[indexPath.row].marketInfo?.slogan[0]
//			}
//		}

//		let showPrice = searchListResponse!.storeList[indexPath.row].marketInfo?.showPrice!

		cell.priceLabel.text = "$"
		if let finalPrice = searchListResponse!.storeList[indexPath.row].finalPrice {
			cell.priceLabel.text = cell.priceLabel.text! + String(finalPrice)
		}

		cell.costLabel.text = "$1999"
//		cell.costLabel.text = "$" + String(showPrice!)


//		cell.imagedView.kf_showIndicatorWhenLoading = false

//		let URL = NSURL(string: searchListResponse!.storeList[indexPath.row].pic!)!
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

//		log.debugln("\(searchListResponse!.storeList[indexPath.row].name)")
//		log.debugln("\(indexPath.row + 1): URL: \(URL)")

//		cell.imagedView.kf_setImageWithURL(URL, placeholderImage: nil, optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly], progressBlock: { (receivedSize, totalSize) -> () in
////			log.debugln("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
//		}) { (image, error, cacheType, imageURL) -> () in
////			if error != nil  {
////				log.debugln(error?.description)
////			}
//
////			log.debugln("\(indexPath.row + 1): Finished")
//		}

//		log.debugln()

		if cell.imagedView.image == nil {
			if let url = NSURL(string: searchListResponse!.storeList[indexPath.row].pic! ) {
				downloadImage(url, imageView: cell.imagedView)
				//			if let data = NSData(contentsOfURL: url) {
				//				cell.imagedView.image = UIImage(data: data)
				//			}
			}
			
		}

        return cell
    }
	
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

	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerCell = tableView.dequeueReusableCellWithIdentifier(headerCellIdentifier) as! HeaderCell

		return headerCell
	}

	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
