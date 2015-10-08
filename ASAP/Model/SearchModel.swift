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
	typealias completedHandler = (search: SearchListResponse?, errorMessage: String?) -> Void
    
	func getSearchData( query: String, completionHandler: completedHandler ) {
        let urlPath = DomainPath.Mview.rawValue + "/web_search/get_app_show_main_multi/"
        let data = ["q":query]
		let version = "1.0.0"
		let requestDic = [
			"account": "01_uitoxtest",
			"password": "Aa1234%!@#",
			"platform_id": "AW000001",
			"version": version,
			"data": data
		]
        
        ApiManager.sharedInstance.postDictionary(urlPath, params: requestDic as? [String : AnyObject]) {
            (search: SearchListResponse?, error: String?) -> Void in
            
            if search == nil {
                completionHandler(search: nil, errorMessage: error)
                return
            }

			log.debug("statusCode:\(search!.statusCode)")
			log.debug("total:\(search!.total)")
			log.debug("currentPage:\(search!.currentPage)")

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