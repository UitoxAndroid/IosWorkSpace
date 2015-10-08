//
//  CampaignModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/9.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class CampaignModel
{   
    func getMenuData( completionHandler: (category: CampaignResponse?, errorMessage: String?) -> Void ) {
        let url = DomainPath.Mview.rawValue + "/web_campaign/campaign_info"
        let data = [
			"camp_seq":"201509A0300000001",
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
            (campain: CampaignResponse?, error: String?) -> Void in
            
            if campain == nil {
                completionHandler(category: nil, errorMessage: error)
                return
            }

			log.debug("statusCode:\(campain!.status_code)")

            completionHandler(category: campain, errorMessage: nil)
        }
        
    }
    
}