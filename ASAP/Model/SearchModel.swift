//
//  SearchModel.swift
//  ASAP
//
//  Created by janet on 2015/9/2.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

// 搜尋頁 Model
class SearchModel
{
    var search: SearchListResponse?
	typealias completedHandler = (search: SearchListResponse?, errorMessage: String?) -> Void
    
	func getSearchData( query: String, completionHandler: completedHandler ) {
        let urlPath = "web_search/get_app_show_main_multi/"
        let data: Dictionary<String,String> = ["q":query]
		let version = "1.0.0"
		let requestDic: Dictionary<String, AnyObject> = ["account": "01_uitoxtest","password": "Aa1234%!@#","platform_id": "AW000001"
								,"version": version,"data": data]
        
        ApiManager<SearchListResponse>.postDictionary(urlPath, params: requestDic) {
            (responseObject: SearchListResponse?, error: String?) -> Void in
            
            if responseObject == nil {
                completionHandler(search: nil, errorMessage: error)
                return
            }
                        
            completionHandler(search: responseObject, errorMessage: nil)
        }
    }
}