//
//  CategoryResponse.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/3.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

public class CategoryResponse : Mappable
{
    public var status_code:String?
    public var total:String?
    public var range:String?
    public var nextIndex:String?
    public var attrValueList:[AttrValueList] = []
    
    
    public class func newInstance(map: Map) -> Mappable? {
        return CategoryResponse()
    }
    
    public func mapping(map: Map) {
        status_code     <- map["status_code"]
        total           <- map["total"]
        range           <- map["range"]
        nextIndex       <- map["next_index"]
        attrValueList   <- map["attr_value_list"]
    }
}

public class AttrValueList:Mappable
{
    public var avSeq:String?
    public var avName:String?
    public var total:String?
    
    public class func newInstance(map: Map) -> Mappable? {
        return AttrValueList()
    }
    
    public func mapping(map: Map) {
        avSeq   <- map["av_seq"]
        avName  <- map["av_Name"]
        total   <- map["total"]
    }
}