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
public class MemberData : Object, Mappable
{
/*    "data":{"MEM_GUID":"C1F22E37-8C74-250A-9F8D-A9E562B76E36","MEM_EMAIL":"shengeih@uitox.com","MEM_LOGIN_PHONE":"_","MEM_STATUS":"_","WS_SEQ":"AW000001","ENCODE_GUID":"GpnW2+5UtovCHgUxDtHrUndPPhnFJXRtOICmRPEs6aqGjQY88NlE\/A==","MEM_INVOICE":null}}*/
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