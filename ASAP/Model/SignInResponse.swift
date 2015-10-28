//
//  SignInResponse.swift
//  ASAP
//
//  Created by janet on 2015/10/20.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 登入頁 Response
public class SignInResponse : Mappable
{
    public var status_code: String?
    public var description: String?
    public var memberData: MemberData?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        status_code <- map["status_code"]
        description <- map["description"]
        memberData  <- map["data"]
    }
}

// 登入會員資料
public class MemberData : Mappable
{
/*  data/MEM_GUID           GUID
    data/MEM_EMAIL          Email
    data/MEM_LOGIN_PHONE    Phone
    data/MEM_STATUS         狀態
    data/WS_SEQ             平台編號
    data/ENCODE_GUID        加密GUID
    data/MEM_INVOICE        Invoice */
    
    public var guid:        String?
    public var email:       String?
    public var phone:       String?
    public var status:      String?
    public var wsSeq:       String?
    public var encodeGuid:  String?
    public var invoice:     String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        guid        <- map["MEM_GUID"]
        email       <- map["MEM_EMAIL"]
        phone       <- map["MEM_LOGIN_PHONE"]
        status      <- map["MEM_STATUS"]
        wsSeq       <- map["WS_SEQ"]
        encodeGuid  <- map["ENCODE_GUID"]
        invoice     <- map["MEM_INVOICE"]
    }
}