//
//  CategoryRequest.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/3.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

// 館頁 Model
class CategoryModel
{    
	/**
	呼叫館頁列表
	- parameter siSeq:				館頁編號
	- parameter page:				頁
	- parameter sortBy:				排序方式
	- parameter desc:				升冪降冪
	- parameter completionHandler:  回呼之後的處理
	
	- returns: 
	*/
	func getCategoryData(siSeq: String, page: Int, sortBy: SortBy, desc: Bool, completionHandler: (category: SearchListResponse?, errorMessage: String?) -> Void ) {
		let url = DomainPath.Mview.rawValue
		let sort = [
			[sortBy.rawValue, (desc ? "desc" : "asc")]
		]
		
        let data = [
			"si_seq":siSeq,
			"wc_seq":"AWC000001",
			"page":page,
			"sort":sort
		]

        let request = [
			"action": "category_api/new_category_list_multi",
			"account":"01_uitoxtest",
			"password":"Aa1234%!@#",
			"platform_id":"AW000001",
			"version":"1.0.0",
			"data":data
		]
        
        ApiManager.sharedInstance.postDictionary(url, params: request) {
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
			log.debug("currentPage:\(responseObject!.currentPage)")
			log.debug("maxPage:\(responseObject!.maxPage)")

            completionHandler(category: responseObject, errorMessage: nil)
        }
        
    }
}