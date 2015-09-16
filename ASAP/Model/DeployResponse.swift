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
    
    public class func newInstance(map: Map) -> Mappable? {
        return DeployResponse()
    }
    
    public func mapping(map: Map) {
        status_code <- map["status_code"]
        dataList    <- map["data"]
    }
}

public class DeployData : Mappable
{
    
    public var slideDataList:[SlideData]=[]
    public var productDataList:[ProductData]=[]
    
    public class func newInstance(map: Map) -> Mappable? {
        return DeployData()
    }
    
    public func mapping(map: Map) {
        slideDataList   <- map["slide_data"]
        productDataList <- map["product_data"]
    }
}

public class SlideData : Mappable
{
    public var img:String?
    public var link:String?
    public var startDate:String?
    public var endDate:String?
    public var pageCode:String?
    public var seq:String?
    
    public class func newInstance(map: Map) -> Mappable? {
        return SlideData()
    }
    
    public func mapping(map: Map) {
        img         <- map["img"]
        link        <- map["link"]
        startDate   <- map["st_dt"]
        endDate     <- map["end_dt"]
        pageCode    <- map["page_code"]
        seq         <- map["seq"]
    }

}

public class ProductData : Mappable
{
    public var name:String?
    public var desc:String?
    public var sloganList:Slogan?
    public var smPrice:String?
    public var ssmPrice:String?
    public var ssmType:String?
    public var price:String?
    public var img:String?
    public var link:String?
    public var startDate:String?
    public var endDate:String?
    public var smSeq:String?
    public var isCross:String?
    public var country:String?
    public var area:String?
    public var orderStatus:String?
    
    public class func newInstance(map: Map) -> Mappable? {
        return ProductData()
    }
    
    public func mapping(map: Map) {
        name        <- map["name"]
        desc        <- map["desc"]
        sloganList  <- map["slogan"]
        smPrice     <- map["sm_price"]
        ssmPrice    <- map["ssm_price"]
        ssmType     <- map["ssm_type"]
        price       <- map["price"]
        img         <- map["img"]
        link        <- map["link"]
        startDate   <- map["st_dt"]
        endDate     <- map["end_dt"]
        smSeq       <- map["sm_seq"]
        isCross     <- map["is_cross"]
        country     <- map["country"]
        area        <- map["area"]
        orderStatus <- map["order_status"]
    }
    
    
}

public class Slogan : Mappable
{
    public var one:String?
    public var two:String?
    public var three:String?
    
    public class func newInstance(map: Map) -> Mappable? {
        return Slogan()
    }

    public func mapping(map: Map) {
        one     <- map["1"]
        two     <- map["2"]
        three   <- map["3"]
    }
}