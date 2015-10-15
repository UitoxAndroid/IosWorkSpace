//
//  MenuResponse.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/9.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

public class MenuResponse : Mappable
{
    public var status_code:String?
    public var menuList:[DataInfo] = []

	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        status_code <- map["status_code"]
        menuList <- map["menu_list"]
    }
}

public class DataInfo:Mappable
{
    /*
    respone/menu_list/SID       選單編號	String
    respone/menu_list/NAME      選單名稱	String
    respone/menu_list/LINK      選單連結	String			"如果SI_TYPE =7 會有選單連結,其他SI_TYPE 則該欄位為空值"
    respone/menu_list/TYPE      選單類型	String			"market //區頁 category //館頁 other //其它"
    respone/menu_list/SI_TYPE	選單類型	String			"0~7  0,2,6 : 館頁 1,5 :區頁 7:連結"
    */
    public var sid:String?
    public var name:String?
    public var link:String?
    public var type:String?
    public var siType:String?
    
	required public init?(_ map: Map) {

	}

	public init?() {
		
	}

    public func mapping(map: Map) {
        sid <- map["SID"]
        name <- map["NAME"]
        link <- map["LINK"]
        type <- map["TYPE"]
        siType <- map["SI_TYPE"]
    }
}




