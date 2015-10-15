//
//  DeployResponse.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/14.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

public class DeployResponse : Mappable{
    public var status_code:String?
    public var dataList:DeployData?
    
	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        status_code <- map["status_code"]
        dataList    <- map["data"]
    }
}

public class DeployData : Mappable
{
    
    public var slideDataList:[SlideData]=[]
    public var linkDataList:[LinkData]=[]
    public var iconLinkDataList1:[IconLinkData]=[]
    public var iconLinkDataList2:[IconLinkData]=[]
    public var productDataList1:[ProductData]=[]
    public var productDataList2:[ProductData]=[]
    
	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        slideDataList       <- map["slide.045"]
        linkDataList        <- map["link.050"]
        iconLinkDataList1   <- map["iconlink.046"]
        iconLinkDataList2   <- map["iconlink.047"]
        productDataList1    <- map["product.048"]
        productDataList2    <- map["product.049"]
    }
}

public class SlideData : Mappable
{
    public var img:String?
    public var link:String?
    public var pageCode:String?
    public var seq:String?
    
	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        img         <- map["img"]
        link        <- map["link"]
        pageCode    <- map["page_code"]
        seq         <- map["seq"]
    }
}

public class LinkData : Mappable
{
    public var name:String?
    public var link:String?
    public var pageCode:String?
    public var seq:String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        name        <- map["name"]
        link        <- map["link"]
        pageCode    <- map["page_code"]
        seq         <- map["seq"]
    }
}

public class IconLinkData : Mappable
{
    public var img:String?
    public var link:String?
    public var pageCode:String?
    public var seq:String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        img         <- map["img"]
        link        <- map["link"]
        pageCode    <- map["page_code"]
        seq         <- map["seq"]
    }
}

public class ProductData : Mappable
{
    public var smSeq:String?
    public var name:String?
    public var sloganList:Slogan?
    public var smPrice:String?
    public var price:String?
    public var img:String?
    
	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        smSeq       <- map["sm_seq"]
        name        <- map["name"]
        sloganList  <- map["slogan"]
        smPrice     <- map["sm_price"]
        price       <- map["price"]
        img         <- map["img"]
    }
    
    
}

public class Slogan : Mappable
{
    public var one:String?
    public var two:String?
    public var three:String?
    
	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        one     <- map["1"]
        two     <- map["2"]
        three   <- map["3"]
    }
}