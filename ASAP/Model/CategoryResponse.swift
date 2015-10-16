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
    public var total:Int?
    public var range:String?
    public var nextIndex:Int?
    public var attrValueList:[AttrValueList] = []
    public var goodsList:[goodsInfo] = []
    public var categoryList:[CategoryList] = []

	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        status_code     <- map["status_code"]
        total           <- map["total"]
        range           <- map["range"]
        nextIndex       <- map["next_index"]
        attrValueList   <- map["attr_value_list"]
        goodsList       <- map["list"]
        categoryList    <- map["category_list"]
    }
}

public class AttrValueList:Mappable
{
    public var avSeq:String?
    public var avName:String?
    public var avSort:String?
    public var total:String?
    
	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        avSeq   <- map["av_seq"]
        avName  <- map["av_name"]
        avSort  <- map["av_sort"]
        total   <- map["total"]
    }
}


public class goodsInfo:Mappable
{
    public var smName:String?
    public var smPic:String?
    public var smSeq:String?
    
	required public init?(_ map: Map) {

	}

    public  func mapping(map: Map) {
        smName  <- map["SM_NAME"]
        smPic   <- map["SM_PIC"]
        smSeq   <- map["SM_SEQ"]
    }

}


public class CategoryList:Mappable
{
    public var cpSeq:String?
    public var cpName:String?
    public var total:String?
    
	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        cpSeq   <- map["cp_seq"]
        cpName  <- map["cp_name"]
        total   <- map["total"]
    }
}

