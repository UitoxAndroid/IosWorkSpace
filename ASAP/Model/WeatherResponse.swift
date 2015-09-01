//
//  WeatherResponse.swift
//
//
//  Created by uitox_macbook on 2015/8/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

//import ObjectMapper

import Foundation

public class WeatherResponse:Mappable
{
	public var name:String?
	public var date:NSDate?
	public var cod:Int?
	public var weather:[Weather] = []
	public var humidity:String?
	public var pressure:String?

	public class func newInstance(map: Map) -> Mappable? {
		return WeatherResponse()
	}

	public func mapping(map: Map) {
		name <- map["name"]
		date <- (map["dt"], DateTransform())
		cod <- map["cod"]
		humidity <- (map["main.humidity"], TransformOf<String, Int>(fromJSON: {(value:Int?) -> String? in
			if let value = value {
				return String(value)
			}
			return nil
			}, toJSON: {(value: String?) -> Int? in
				return value?.toInt()
		}))

		pressure <- (map["main.pressure"], TransformOf<String, Int>(fromJSON: {$0.map { String($0) } }, toJSON: {$0?.toInt()}))
		weather <- map["weather"]
	}

}

public class Weather: Mappable
{
	public var description:String?
	public var icon:String?

	public static func newInstance(map: Map) -> Mappable? {
		return Weather()
	}

	public func mapping(map: Map) {
		description <- map["description"]
		icon <- map["icon"]
	}
}