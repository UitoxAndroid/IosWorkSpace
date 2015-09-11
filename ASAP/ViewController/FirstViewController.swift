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
	lazy var categoryData:CategoryModel? = CategoryModel()
	lazy var campaignData:CampaignModel? = CampaignModel()

	override func viewDidLoad() {
		super.viewDidLoad()

//		apiManagerTest()
//		searchTest()
//		CategoryTest()

		var searchItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: Selector("searchButtonOnClicked:"))
		self.navigationItem.rightBarButtonItem = searchItem
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



	func GetCampaign(){
		campaignData?.getMenuData() { (campain: CampaignResponse?, errorMessage: String?) in
			if campain == nil {
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					let alert = UIAlertController(title: "警告", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
					let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
					alert.addAction(confirmAction)
					self.presentViewController(alert, animated: true, completion: nil)
				})
			} else {
				self.campaignData!.campaign = campain!
				println("statusCode:\(campain!.status_code)")

			}
		}
	}



	override func prefersStatusBarHidden() -> Bool {
		return false
	}





}

