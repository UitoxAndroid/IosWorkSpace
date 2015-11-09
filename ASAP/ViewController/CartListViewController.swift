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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 10
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = cellsIdentifier[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
  
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = cellsRowHeight[indexPath.row]
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
