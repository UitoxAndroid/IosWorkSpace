//
//  CategoryRequest.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/3.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class CategoryModel {
    
    var category:CategoryResponse?
    
    func getCategoryData( completionHandler: (category: CategoryResponse?, errorMessage: String?) -> Void ) {
        let url = "https://uxapi.uitoxbeta.com/web_category/new_category_list_multi/"
        
        let data = [
            "si_seq":"AJ0001" ,
            "wc_seq":"AWC000001"]
        
        let request = [
            "client_id":"f0fa5432-ea4b-70ee-e264-d35dcdc1b831",
            "token":"74C73A27-B15F-9C34-B41B-3F26E208E120-CEF1A257490DE7C1FCDF309",
            "platform_id":"AW000001",
            "version":"1.0.0",
            "data":data]
   
        ApiManager<CategoryResponse>.postDictionary(url, params: request as? [String : AnyObject]) {
            (responseObject: CategoryResponse?, error: String?) -> Void in
            
            if responseObject == nil {
                completionHandler(category: nil, errorMessage: error)
                return
            }
            
            completionHandler(category: responseObject, errorMessage: nil)
        }
        
    }
}