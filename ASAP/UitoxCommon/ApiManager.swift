//
//  ApiManager.swift
//  TestOrm
//
//  Created by uitox_macbook on 2015/8/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

public class ApiManager<T:Mappable>
{
	public static func action(urlPath:String, param:[String:AnyObject]?, completionHandler: (T?, NSError?,isSuccess:Bool) -> Void) -> (isSuccess:Bool, entity:T?, error:String?) {
		var returnValue:T? = nil

		Alamofire.request(.POST, urlPath, parameters: param)
			.responseObject { (response: T?, error: NSError?) -> Void in

				completionHandler(response, error, isSuccess: true)

				println()
				returnValue = response
		}

		return (true, returnValue, nil)


	}
}
