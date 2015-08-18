//
//  FirstViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/13.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

	lazy var openWeather:OpenWeatherModel? = OpenWeatherModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

//		openWeather = OpenWeatherModel()
		openWeather?.getWeatherData() { (weather: WeatherResponse?, errorMessage: String?) in
			if weather == nil {
				let alert = UIAlertController(title: "警告", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
				let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
				alert.addAction(confirmAction)
				self.presentViewController(alert, animated: true, completion: nil)
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

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

