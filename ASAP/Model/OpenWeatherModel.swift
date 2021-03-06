//
//  Weather.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/17.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

class OpenWeatherModel
{
	func getWeatherData( completionHandler: (weather: WeatherResponse?, errorMessage: String?) -> Void ) {
		let url = "http://api.openweathermap.org/data/2.5/weather?lat=37.785834&lon=-122.406417&units=imperial"

		ApiManager.sharedInstance.postDictionary(url, params: nil) {
			(responseObject: WeatherResponse?, error: String?) -> Void in

				if responseObject == nil {
					completionHandler(weather: nil, errorMessage: error)
					return
				}

				if let weather = responseObject?.weather {
					for _ in weather {

					}
				}

				completionHandler(weather: responseObject, errorMessage: nil)
		}

	}
}