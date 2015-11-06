//
//  SearchResultViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/9/7.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
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


	// MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

		setupSearchController()
    }

	func setupSearchController() {
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


	// MARK: - UISearchBarDelegate

	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		if let searchText = searchBar.text {
			self.pleaseWait()
			getSearchData(searchText)
		}
	}

	func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
		return true
	}

	func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
		return true
	}


	// MARK: - UISearchResultsUpdating

	func updateSearchResultsForSearchController(searchController: UISearchController) {
//		let searchText = searchController.searchBar.text
//
//		searchResult = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
//			return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//		})
//
//		tableView.reloadData()
	}


	// MARK: - UISearchControllerDelegate

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


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if (searchResult != nil) {
			return searchResult.count
		}

        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")

		if cell == nil {
			cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
		}

		if searchResult != nil {
			cell!.textLabel!.text = searchResult[indexPath.row]
		}

        return cell!
    }


	// MARK: - Call Api

	func getSearchData(query: String) {
		searchData?.getSearchData(query, page: 1, sortBy: SortBy.SmSoldQty, desc: true) { (search: SearchListResponse?, errorMessage: String?) in
			if search == nil {
				self.showAlert(errorMessage!)
			} else {
				self.searchController.searchBar.hidden = true
				let kindViewController = self.storyboard?.instantiateViewControllerWithIdentifier("KindViewController") as? KindViewController
				kindViewController!.searchListResponse = search!
				kindViewController!.query = query
				kindViewController!.title = ""
				self.navigationController?.pushViewController(kindViewController!, animated: true)
			}

			self.clearAllNotice()
		}
	}

}
