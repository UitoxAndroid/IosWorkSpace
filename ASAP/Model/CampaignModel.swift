//
//  CampaignModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/9.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class CampaignModel{
    var campaign:CampaignResponse?
    
    func getMenuData( completionHandler: (category: CampaignResponse?, errorMessage: String?) -> Void ) {
        let url = "https://uxapi.uitoxbeta.com/web_campaign/campaign_info"
        let data = ["camp_seq":"201509A0300000001", "wc_seq":"AWC000001"]
        let request =
        ["account":"01_uitoxtest","password":"Aa1234%!@#", "platform_id":"AW000001","version":"1.0.0","data":data]
        
        ApiManager<CampaignResponse>.postDictionary(url, params: request as? [String : AnyObject]) {
            (responseObject: CampaignResponse?, error: String?) -> Void in
            
            if responseObject == nil {
                completionHandler(category: nil, errorMessage: error)
                return
            }
            
            completionHandler(category: responseObject, errorMessage: nil)
        }
        
    }
    
}