//
//  CategoryRequest.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/3.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class CategoryModel
{    
	func getCategoryData( siSeq: String, completionHandler: (category: SearchListResponse?, errorMessage: String?) -> Void ) {
        let url = DomainPath.Mview.rawValue + "/web_search/get_app_category_list_multi"
        let data = [
			"si_seq":siSeq,
			"wc_seq":"AWC000001"
		]

        let request = [
			"account":"01_uitoxtest",
			"password":"Aa1234%!@#",
			"platform_id":"AW000001",
			"version":"1.0.0",
			"data":data
		]
        
        ApiManager.sharedInstance.postDictionary(url, params: request as? [String : AnyObject]) {
            (responseObject: SearchListResponse?, error: String?) -> Void in
            
            if responseObject == nil || responseObject?.storeList == nil || responseObject?.storeList.count == 0 {
				if error == nil || error == "" {
					completionHandler(category: nil, errorMessage: "no data")
				} else {
					completionHandler(category: nil, errorMessage: error)
				}
                return
            }

			log.debug("statusCode:\(responseObject!.statusCode)")
			log.debug("total:\(responseObject!.total)")

            completionHandler(category: responseObject, errorMessage: nil)
        }
        
    }
}