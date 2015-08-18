//
//  ApiManager.swift
//  TestOrm
//
//  Created by uitox_macbook on 2015/8/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

//import Alamofire
//import AlamofireObjectMapper
//import ObjectMapper
import Foundation

public class ApiManager<T:Mappable>
{
	public static func action(urlPath:String, param:[String:AnyObject]?, completionHandler: (T?, String?, isSuccess:Bool) -> Void) {
		request(.POST, urlPath, parameters: param)
				 .responseObject { (responseEntity: T?, error: NSError?) in
					if let error = error {
						completionHandler(nil, error.localizedDescription, isSuccess: false)
					} else {
						completionHandler(responseEntity, nil, isSuccess: true)
					}
				}
	}
}
