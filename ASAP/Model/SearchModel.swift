//
//  SearchModel.swift
//  ASAP
//
//  Created by janet on 2015/9/2.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

enum SortBy: String {
	case SmSoldQty = "SM_SOLDQTY"	//銷量排序
	case UitoxPrice = "UITOX_PRICE"	//價格排序
}

// 搜尋頁 Model
class SearchModel
{
	typealias completedHandler = (search: SearchListResponse?, errorMessage: String?) -> Void
    
	/**
	呼叫館頁列表
	- parameter query:				搜尋關鍵字
	- parameter page:				頁
	- parameter sortBy:				排序方式
	- parameter desc:				升冪降冪
	- parameter completionHandler:  回呼之後的處理
	
	- returns: 
	*/
	func getSearchData(query: String, page: Int, sortBy: SortBy, desc: Bool, completionHandler: completedHandler ) {
        let urlPath = DomainPath.Uxapi.rawValue + "/web_search/get_app_show_main_multi/"
		let sort = [
			[sortBy.rawValue, (desc ? "desc" : "asc")]
		]
		
        let data = [
			"q":query,
			"page":page,
			"sort":sort
		]

		let version = "1.0.0"
		let requestDic = [
			"account": "01_uitoxtest",
			"password": "Aa1234%!@#",
			"platform_id": "AW000001",
			"version": version,
			"data": data
		]
        
        ApiManager.sharedInstance.postDictionary(urlPath, params: requestDic) {
            (search: SearchListResponse?, error: String?) -> Void in
            
            if search == nil {
                completionHandler(search: nil, errorMessage: error)
                return
            }

			log.debug("statusCode:\(search!.statusCode)")
			log.debug("total:\(search!.total)")
			log.debug("currentPage:\(search!.currentPage)")
			log.debug("maxPage:\(search!.maxPage)")

			if let storeList = search?.storeList {
				for store in storeList {
					log.debug("\(store.name!)\t")
					log.debug("\(store.pic!)\t")
					log.debug("\(store.finalPrice!)\t")
                    log.debug("\n")				}
			}

            completionHandler(search: search, errorMessage: nil)
        }
    }
}