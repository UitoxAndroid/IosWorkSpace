//
//  FirstViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/13.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating
{
	@IBOutlet weak var tableView: UITableView!
	lazy var openWeather:OpenWeatherModel? = OpenWeatherModel()
	var restaurantNames = ["Cafe Deadend", "Homei", "Teakha"]
	var searchResults:[String] = []
	var searchController:UISearchController!

	override func viewDidLoad() {
		super.viewDidLoad()

		searchController = UISearchController(searchResultsController: nil)
		searchController.searchBar.sizeToFit()
		tableView.tableHeaderView = searchController.searchBar
		definesPresentationContext = true

		searchController.searchResultsUpdater = self
		searchController.dimsBackgroundDuringPresentation = false
	}

	func updateSearchResultsForSearchController(searchController: UISearchController) {
		let searchText = searchController.searchBar.text
		filterContentForSearchText(searchText)
		tableView.reloadData()
	}

	func filterContentForSearchText(searchText: String) {
		searchResults = restaurantNames.filter({ (restaurant: String) -> Bool in
			let nameMatch = restaurant.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil)

			return nameMatch != nil
		})
	}

	func apiManagerTest() {
		openWeather?.getWeatherData() { (weather: WeatherResponse?, errorMessage: String?) in
			if weather == nil {
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					let alert = UIAlertController(title: "警告", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
					let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
					alert.addAction(confirmAction)
					self.presentViewController(alert, animated: true, completion: nil)
				})
			} else {
				self.openWeather!.weather = weather!

				println("name:\(weather!.name!)")
				println("cod: \(weather!.cod!)")
				println("date: \(weather!.date!)")
				println("main.humidity: \(weather!.humidity!)")
				println("main.pressure: \(weather!.pressure!)")

				if let weather = weather?.weather {
					for wea in weather {
						println(wea.description!)
						println(wea.icon!)
					}
				}
			}
		}
	}

	override func prefersStatusBarHidden() -> Bool {
		return false
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if searchController.active {
			return searchResults.count
		}
		return restaurantNames.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier = "Cell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? UITableViewCell

		cell?.textLabel?.text = searchController.active ? searchResults[indexPath.row] : restaurantNames[indexPath.row]

		return cell!
	}




}

