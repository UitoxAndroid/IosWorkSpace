//
//  CampaignResponse.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/9.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

public class CampaignResponse : Mappable{
    public var status_code:String?
    
    public class func newInstance(map: Map) -> Mappable? {
        return CampaignResponse()
    }
    
    public func mapping(map: Map) {
        status_code <- map["status_code"]
    }
}
