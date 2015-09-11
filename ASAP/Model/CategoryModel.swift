//
//  CategoryRequest.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/3.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class CategoryModel {
    
    var category:SearchListResponse?
    
	func getCategoryData( siSeq: String, completionHandler: (category: SearchListResponse?, errorMessage: String?) -> Void ) {
        let url = "web_search/get_app_category_list_multi"
        let data = ["si_seq":siSeq, "wc_seq":"AWC000001"]
        let request = ["account":"01_uitoxtest","password":"Aa1234%!@#", "platform_id":"AW000001","version":"1.0.0","data":data]
        
        ApiManager<SearchListResponse>.postDictionary(url, params: request as? [String : AnyObject]) {
            (responseObject: SearchListResponse?, error: String?) -> Void in
            
            if responseObject == nil {
                completionHandler(category: nil, errorMessage: error)
                return
            }

			println("statusCode:\(responseObject!.statusCode)")
			println("total:\(responseObject!.total)")

            completionHandler(category: responseObject, errorMessage: nil)
        }
        
    }
}