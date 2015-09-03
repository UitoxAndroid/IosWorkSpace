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
    
    func getSearchData( completionHandler: (search: SearchListResponse?, errorMessage: String?) -> Void ) {
        let url = "https://uxapi.uitoxbeta.com/web_search/new_search_list_multi/"
        
        
        let version = "1.0.0"
        let data: Dictionary<String,String> = ["q":"iphone"]
        let requestDic: Dictionary<String, AnyObject> = ["client_id": "f0fa5432-ea4b-70ee-e264-d35dcdc1b831","token": "74C73A27-B15F-9C34-B41B-3F26E208E120-CEF1A257490DE7C1FCDF309","platform_id": "AW000001","version": version,"data": data]
        
        ApiManager<SearchListResponse>.postDictionary(url, params: requestDic) {
            (responseObject: SearchListResponse?, error: String?) -> Void in
            
            if responseObject == nil {
                completionHandler(search: nil, errorMessage: error)
                return
            }
                        
            completionHandler(search: responseObject, errorMessage: nil)
        }
    }
}