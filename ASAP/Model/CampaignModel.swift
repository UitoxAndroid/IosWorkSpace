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
    func getCampaignData( completionHandler: (campaign: SearchListResponse?, errorMessage: String?) -> Void ) {
		let url = DomainPath.MviewWww.rawValue
        let data = [
			"camp_seq":"201510A0700000001",
			"wc_seq":"AWC000001"
		]

        let request = [
			"action": "campaign_api/campaign_info_and_list_multi_for_uxapi",
			"account":"01_uitoxtest",
            "password":"Aa1234%!@#",
            "platform_id":"AW000001",
            "version":"1.0.0",
            "data":data
        ]
        
        ApiManager.sharedInstance.postDictionary(url, params: request as? [String : AnyObject]) {
            (campaign: SearchListResponse?, error: String?) -> Void in
            
            if campaign == nil {
                completionHandler(campaign: nil, errorMessage: error)
                return
            }

			log.debug("statusCode:\(campaign!.statusCode)")
            log.debug("活動詳細資料數: \(campaign!.campInfo[0].campPromote)")
            
            completionHandler(campaign: campaign, errorMessage: nil)
        }
        
    }
    
}