//
//  CartListViewController.swift
//  ASAP
//
//  Created by janet on 2015/11/3.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

// 購物車清單
class CartListViewController: UITableViewController {

    let cellsIdentifier: [String]   = ["General","Discount" ,"OnSale"   ,"Combo","Addition" ,"Campaign" ,"CartDiscount" ,"CartTotal","CartAddition" ,"CartConfirm"]
    let cellsRowHeight: [CGFloat]   = [160      ,110        ,110        ,240    ,110        ,170        ,180            ,55         ,220            ,44]
    
    var shoppingCartResponse: ShoppingCartResponse?
  
    var smCount: Int = 0
    
    lazy var placeholderImage: UIImage = {
        let image = UIImage(named: "no_img")!
        return image
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
	
	override func viewWillAppear(animated: Bool) {
		self.confirmShoppingCart() { (shoppingCartResponse: ShoppingCartResponse?) in
            self.shoppingCartResponse = shoppingCartResponse
            self.tableView.reloadData()
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(self.shoppingCartResponse == nil || (self.shoppingCartResponse?.smList)! == nil) {
            return 0
        }
        
        if let count = self.shoppingCartResponse?.smList.count {
            self.smCount = count
            return count + 4
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseIdentifier: String = ""
      
        if (self.smCount > indexPath.row) {
            let smInfo = self.shoppingCartResponse?.smList[indexPath.row]
            if let itemType = smInfo?.itemType {
                switch itemType {
                case "1":
                    reuseIdentifier = cellsIdentifier[0]
                    let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GeneralTableViewCell
                    cell.productName!.text = smInfo?.smName
                    cell.productPrice!.text = smInfo?.price

                    /*if let url = NSURL(string: (smInfo?.pic)!) {
                        cell.productImage.kf_setImageWithURL(url, placeholderImage: placeholderImage, options: [.Options: KingfisherOptions.CacheMemoryOnly, .Transistion: ImageTransition.Fade(0.1)])
                        cell.productImage.userInteractionEnabled = true
                    }*/
                    // 要另外組出資料...
                    //cell.gift!.text = ""
                    //cell.addGift!.text = "加贈品"

                    return cell
                case "2":
                    reuseIdentifier = cellsIdentifier[1]
                    let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DiscountTableViewCell
                    cell.productName!.text = smInfo?.smName
                    cell.productPrice!.text = smInfo?.price
                    cell.discount!.text = "1223"
                    return cell
                case "3":
                    reuseIdentifier = cellsIdentifier[2]
                    let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
                    return cell
                case "4":
                    reuseIdentifier = cellsIdentifier[3]
                    let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
                    return cell
                default: break
                }
            }
        }

        let cellIndex = indexPath.row - self.smCount + 6
        reuseIdentifier = cellsIdentifier[cellIndex]
        switch cellIndex {
        case 6:
            let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CartDiscountTableViewCell
            cell.deliveryCharge!.text = self.shoppingCartResponse?.deliveryCharges
            
            cell.shoppingCredits!.text = "0"
            if let shoppingCredit = self.shoppingCartResponse?.shoppingCredits {
                if( shoppingCredit > 0) {
                    cell.shoppingCredits.text = "\(shoppingCredit)"
                    cell.shoppingCredits!.hidden = false
                    cell.useShoppingCredits!.hidden = false
                }
            }
            return cell
        case 7:
            let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CartTotalTableViewCell
            if let cartTotal = self.shoppingCartResponse?.cartTotal {
                cell.cartTotal!.text = "訂單總計 NT$\(cartTotal)"
            }
            return cell
        case 8:
            let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CartAdditionTableViewCell
            return cell
        case 9:
            let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
  
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cellIndex = indexPath.row
        if (self.smCount > indexPath.row) {
            let smInfo = self.shoppingCartResponse?.smList[0]
            if let itemType = smInfo?.itemType {
                switch itemType {
                case "1":
                    cellIndex = 0
                case "2":
                    cellIndex = 1
                case "3":
                    cellIndex = 2
                case "4":
                    cellIndex = 3
                default: break
                }
            }
        } else {
            cellIndex = indexPath.row - self.smCount + 6
        }
        
        let height = cellsRowHeight[cellIndex]
        return height
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	
	// MARK - Call Api
	
	func confirmShoppingCart(completionHandler: (shoppingCartResponse: ShoppingCartResponse?) -> Void) {
		self.showBusy("請稍候...")
		MyApp.sharedShoppingCart.queryShoppingCart()
		MyApp.sharedShoppingCart.callApiGetShoppingCart { (resp: ShoppingCartResponse?, errorMessage: String?) -> Void in
			self.clearAllNotice()
			if errorMessage != nil {
				self.showError(errorMessage)
			} else {
				completionHandler(shoppingCartResponse: resp!)
			}
		}
	}

    // 宅配
    @IBAction func deliveryServiceButtonClick(sender: AnyObject) {
        
    }
}

extension CartListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        switch (collectionView.tag) {
        case 0:
           cell = collectionView.dequeueReusableCellWithReuseIdentifier("ComboDetailCell", forIndexPath: indexPath) as! ComboDetailCollectionViewCell
        case 1:
           cell = collectionView.dequeueReusableCellWithReuseIdentifier("CartDiscountCell", forIndexPath: indexPath) as! CartDiscountCollectionViewCell
        case 2:
           cell = collectionView.dequeueReusableCellWithReuseIdentifier("CartAdditionCell", forIndexPath: indexPath) as! CartAdditionCollectionViewCell
        default:
           cell = UICollectionViewCell()
        }
        return cell
    }

    /*func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        <#code#>
    }*/
}
