//
//  ResetPasswordResponse.swift
//  ASAP
//
//  Created by janet on 2015/10/27.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 手機重設密碼頁 Response
public class ResetPasswordResponse : Mappable
{
    public var status_code: String?
    public var description: String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        status_code <- map["status_code"]
        description <- map["description"]
    }
    
}