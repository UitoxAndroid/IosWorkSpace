//
//  MenuResponse.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/9.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

public class MenuResponse : Mappable{
    public var status_code:String?
    public var menuList:[DataInfo] = []

	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        status_code <- map["status_code"]
        menuList <- map["menu_list"]
    }
}

public class DataInfo:Mappable{
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




