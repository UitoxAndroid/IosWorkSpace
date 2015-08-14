//
//  TestDataModel.swift
//  TestOrm
//
//  Created by uitox_macbook on 2015/8/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

//import Foundation
import ObjectMapper

public class TestDataModel:Mappable
{
	public var name:String?
	public var date:NSDate?
	public var cod:Int?
//	var main:MainModel?
	public var weather:[Weather] = []
	public var humidity:String?
	public var pressure:String?

//	init() { }
//	required init?(_ map:Map) {
//		mapping(map)
//	}

	public class func newInstance(map: Map) -> Mappable? {
		return TestDataModel()
	}

	public func mapping(map: Map) {
		name <- map["name"]
		date <- (map["dt"], DateTransform())
		cod <- map["cod"]
//		main <- map["main"]
//		humidity <- map["main.humidity"]
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

//		id <- (map["id"], TransformOf<Int, String>(fromJSON: { $0?.toInt() }, toJSON: { $0.map { String($0) } }))
	}

}


public class MainModel: Mappable
{
	public var humidity:Int?
	public var pressure:Int?

	public static func newInstance(map: Map) -> Mappable? {
		return MainModel()
	}

	public func mapping(map: Map) {
		humidity <- map["humidity"]
		pressure <- map["pressure"]
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