//
//  RegisterResponse.swift
//  ASAP
//
//  Created by janet on 2015/10/6.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 註冊頁 Response
public class RegisterResponse : Mappable
{
    public var status_code: String?
    public var description: String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        status_code  <- map["status_code"]
        description <- map["description"]
    }
}