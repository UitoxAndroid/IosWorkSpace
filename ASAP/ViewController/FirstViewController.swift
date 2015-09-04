//
//  FirstViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/13.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController
{
	@IBOutlet weak var tableView: UITableView!
	lazy var openWeather:OpenWeatherModel? = OpenWeatherModel()
	lazy var searchData:SearchModel? = SearchModel()
	lazy var categoryData:CategoryModel? = CategoryModel()

	override func viewDidLoad() {
		super.viewDidLoad()

//		apiManagerTest()
//		searchTest()
//		CategoryTest()

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

	func searchTest() {
		searchData?.getSearchData() { (search: SearchListResponse?, errorMessage: String?) in
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

				//                if let searchList = search?.searchList {
				//                    for searchItem in searchList {
				//                        print("\(searchItem.seq!)\\t")
				//                        print("\(searchItem.name!)\\t")
				//                        print("\(searchItem.pic!)\\t")
				//                        println()
				//                    }
				//                }
			}
		}
	}

	func CategoryTest(){
		categoryData?.getCategoryData() { (category: CategoryResponse?, errorMessage: String?) in
			if category == nil {
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					let alert = UIAlertController(title: "警告", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
					let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
					alert.addAction(confirmAction)
					self.presentViewController(alert, animated: true, completion: nil)
				})
			} else {
				self.categoryData!.category = category!
				println("statusCode:\(category!.status_code)")
				println("total:\(category!.total)")
				println("range:\(category!.range)")

				if let attList = category?.attrValueList{
					for attr in attList {
						print("avName:\(attr.avName)")
						print("avseq:\(attr.avSeq)")
						print("avSort:\(attr.avSort)")
					}
				}

			}
		}
	}


	override func prefersStatusBarHidden() -> Bool {
		return false
	}





}

