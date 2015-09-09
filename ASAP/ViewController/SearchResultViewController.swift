//
//  SearchResultViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/9/7.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class SearchResultViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate
{
	var searchController: UISearchController!
	var kindViewController: KindViewController!
	var searchResult: [String]!
	let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
		"Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
		"Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
		"Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
		"Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    override func viewDidLoad() {
        super.viewDidLoad()

		self.searchController = UISearchController(searchResultsController: nil)
		self.searchController.searchResultsUpdater = self
		self.searchController.delegate = self
		self.searchController.hidesNavigationBarDuringPresentation = false
		self.searchController.dimsBackgroundDuringPresentation = false
		self.definesPresentationContext = false
		searchController.searchBar.sizeToFit()
		searchController.searchBar.delegate = self
		tableView.tableHeaderView = searchController.searchBar
    }

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)
		searchController.searchBar.hidden = false
		self.searchController.active = true
	}

	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		searchController.searchBar.hidden = true
		let kindViewController = storyboard?.instantiateViewControllerWithIdentifier("KindViewController") as? KindViewController
		self.navigationController?.pushViewController(kindViewController!, animated: true)
//		self.showViewController(kindViewController!, sender: self)
//		self.showDetailViewController(kindViewController!, sender: self)
	}

	func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
		return true
	}

	func updateSearchResultsForSearchController(searchController: UISearchController) {
//		let searchText = searchController.searchBar.text
//
//		searchResult = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
//			return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//		})
//
//		tableView.reloadData()
	}

	func willPresentSearchController(searchController: UISearchController) {

	}

	func didPresentSearchController(searchController: UISearchController) {
		searchController.searchBar.becomeFirstResponder()
	}

	func willDismissSearchController(searchController: UISearchController) {

	}

	func didDismissSearchController(searchController: UISearchController) {
		self.dismissViewControllerAnimated(false, completion: nil)
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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
		if (searchResult != nil) {
			return searchResult.count
		}

        return 0
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? UITableViewCell

		if (cell == nil) {
			cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
		}

		if searchResult != nil {
			cell?.textLabel!.text = searchResult[indexPath.row]
		}

        return cell!
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
