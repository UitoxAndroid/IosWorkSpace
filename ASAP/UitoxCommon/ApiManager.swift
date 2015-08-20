//
//  ApiManager.swift
//  TestOrm
//
//  Created by uitox_macbook on 2015/8/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class ApiManager<T:Mappable>
{
	static func postDictionary(urlPath:String, params:[String:AnyObject]?, completionHandler: (mapperObject: T?, errorMessage:String?) -> Void) {
		request(.POST, urlPath, parameters: params).responseObject {
			(responseEntity: T?, error: NSError?) in
			if responseEntity == nil || error != nil {
				completionHandler(mapperObject:nil, errorMessage:error?.localizedDescription)
			} else {
				completionHandler(mapperObject:responseEntity, errorMessage:nil)
			}
		}
	}

	static func postArray(urlPath:String, params:[String:AnyObject]?, completionHandler: (mapperObject: [T]?, errorMessage:String?) -> Void) {
		request(.POST, urlPath, parameters: params).responseArray {
			(responseEntity: [T]?, error: NSError?) in
			if responseEntity == nil || error != nil {
				completionHandler(mapperObject:nil, errorMessage:error?.localizedDescription)
			} else {
				completionHandler(mapperObject:responseEntity, errorMessage:nil)
			}
		}
	}

}
