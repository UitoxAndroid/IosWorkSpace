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
	lazy var searchData:SearchModel? = SearchModel()
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
		self.definesPresentationContext = true
		searchController.searchBar.delegate = self
		searchController.searchBar.sizeToFit()
		tableView.tableHeaderView = searchController.searchBar
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true)
		searchController.searchBar.hidden = false
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)
		self.searchController.active = true
		searchController.searchBar.resignFirstResponder()
	}

	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		if let searchText = searchBar.text {
			self.pleaseWait()
			searchTest(searchText)
		}

	}

	func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
		return true
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
//		self.dismissViewControllerAnimated(false, completion: nil)
//		self.navigationController!.popViewControllerAnimated(true)
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

	func searchTest( query: String) {
		searchData?.getSearchData( query) { (search: SearchListResponse?, errorMessage: String?) in
			if search == nil {
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					let alert = UIAlertController(title: "警告", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
					let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
					alert.addAction(confirmAction)
					self.presentViewController(alert, animated: true, completion: nil)
				})
			} else {
				self.searchData!.search = search!
				println("statusCode:\(search!.statusCode)")
				println("total:\(search!.total)")
				println("currentPage:\(search!.currentPage)")

				if let storeList = search?.storeList {
					for stroe in storeList {
						print("\(stroe.name!)\t")
						print("\(stroe.pic!)\t")
						//                        print("\(stroe.title!)\t")
						println()
					}
				}

				self.searchController.searchBar.hidden = true
				let kindViewController = self.storyboard?.instantiateViewControllerWithIdentifier("KindViewController") as? KindViewController
				kindViewController!.searchListResponse = search!
				self.navigationController?.pushViewController(kindViewController!, animated: true)
			}

			self.clearAllNotice()
		}
	}

}
