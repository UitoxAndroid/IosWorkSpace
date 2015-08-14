//
//  FirstViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/13.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
//		let log = Logger()

		//hello
		
		let url = "http://api.openweathermap.org/data/2.5/weather?lat=37.785834&lon=-122.406417&units=imperial"

		ApiManager<TestDataModel>.action(url, param: nil) { (response: TestDataModel?, error: NSError?, isSuccess:Bool) -> Void in
			println("name:\(response!.name!)")
			println("cod: \(response!.cod!)")
			println("date: \(response!.date!)")
			println("main.humidity: \(response!.humidity!)")
			println("main.pressure: \(response!.pressure!)")

			if let weather = response?.weather {
				for wea in weather {
					println(wea.description!)
					println(wea.icon!)
				}
			}
		}

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

