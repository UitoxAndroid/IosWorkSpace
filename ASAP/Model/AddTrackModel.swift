//
//  AddTrackModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/11/10.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

class AddTrackModel
{
    func AddTrack(smSeq:String, memGuid:String, completionHandler: (addTrackReturn: AddTrackResponse?, errorMessage: String?) -> Void ) {
        let url = DomainPath.MviewPmadmin.rawValue
        
        let data = [
            "mem_guid":memGuid,
            "sm_seq":smSeq,
            "stock_notify":"0"
        ]
        
        let request = [
            "action": "item_track_api/add_track_for_uxapi",
            "account":"01_uitoxtest",
            "password":"Aa1234%!@#",
            "platform_id":"AW000001",
            "version":"1.0.0",
            "data":data
        ]
        
        
        ApiManager.sharedInstance.postDictionary(url, params: request as? [String : AnyObject]) {
            (addTrack: AddTrackResponse?, error: String?) -> Void in
            
            if addTrack == nil {
                completionHandler(addTrackReturn: nil, errorMessage: error)
                return
            }
            
            log.debug("statusCode:\(addTrack!.status_code)")
            completionHandler(addTrackReturn: addTrack, errorMessage: nil)
        }
        
    }}