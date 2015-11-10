//
//  AddTrackResponse.swift
//  ASAP
//
//  Created by HsuTony on 2015/11/10.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

public class AddTrackResponse : Mappable
{
    /*  respone/data/	加入追蹤清單response    */
    public var status_code:String?
    public var response:AddTrackReturn?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        status_code <- map["status_code"]
        response    <- map["response"]
    }
}

public class AddTrackReturn : Mappable
{
    public var data:String?
    
    required public init?(_ map: Map) {
        
    }
 
    public func mapping(map: Map) {
        data    <- map["data"]
    }
}

