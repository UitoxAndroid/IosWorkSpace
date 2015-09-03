//
//  SearchListResponse.swift
//  ASAP
//
//  Created by janet on 2015/9/2.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

public class SearchListResponse: Mappable
{
    public var statusCode:  String?
    public var searchList:  [SearchItem] = []
    public var total:       Int?
    public var ws_Seq:      String?
    
    public class func newInstance(map: Map) -> Mappable? {
        return WeatherResponse()
    }
    
    public func mapping(map: Map) {
        statusCode  <- map["status_code"]
        searchList  <- map["list"]
        total       <- map["total"]
        ws_Seq      <- map["ws_seq"]
    }
    
}

// 賣場清單
public class SearchItem: Mappable
{
    public var seq:     String?
    public var name:    String?
    public var pic:     String?
    
    public static func newInstance(map: Map) -> Mappable? {
        return SearchItem()
    }
    
    public func mapping(map: Map) {
        seq     <- map["SM_SEQ"]
        name    <- map["SM_NAME"]
        pic     <- map["SM_PIC"]
    }
}