//
//  SignInResponse.swift
//  ASAP
//
//  Created by janet on 2015/10/20.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation
import RealmSwift

// 登入頁 Response
public class SignInResponse : Mappable
{
    public var status_code:     String?
    public var description:     String?
    public var memberData:      MemberData?
    public var errorData:       ErrorData?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        status_code     <- map["status_code"]
        description     <- map["description"]
        memberData      <- map["data"]
        errorData       <- map["data"]

    }
}

// 登入會員資料
public class MemberData : Object, Mappable
{
/*  data/MEM_GUID           GUID
    data/MEM_EMAIL          Email
    data/MEM_LOGIN_PHONE    Phone
    data/MEM_STATUS         狀態
    data/WS_SEQ             平台編號
    data/ENCODE_GUID        加密GUID
    data/MEM_INVOICE        Invoice */
    
    public dynamic var guid:        String = ""
    public dynamic var email:       String = ""
    public dynamic var phone:       String = ""
    public dynamic var status:      String = ""
    public dynamic var wsSeq:       String = ""
    public dynamic var encodeGuid:  String = ""
    public dynamic var invoice:     String = ""
    
    required public convenience init?(_ map: Map) {
        self.init()
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

// 登入錯誤資料
public class ErrorData : Mappable
{
    /*
    data/can_login_times    (302)密碼錯誤-可登入次數*/
    
    public var canLoginTimes:   Int?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        canLoginTimes   <- map["can_login_times"]
    }
}