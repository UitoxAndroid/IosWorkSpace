//
//  DealsOntimeResponse.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/16.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

public class DealsOntimeResponse : Mappable
{
    public var status:String?
    public var counts:String?
    public var dataList:[DealsOntimeData] = []
    public var status_code:String?

	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        status      <- map["status"]
        counts      <- map["counts"]
        status_code <- map["status_code"]
        dataList    <- map["data"]
    }
}

public class DealsOntimeData : Mappable
{
    public var wsoSeq:String?
    public var promoHour:String?
    public var promoDate:String?
    public var smSeq:String?
    public var wsoItemPic:String?
    public var wsoItemName:String?
    public var smName:String?
    public var smPic:String?
    public var calPriceDetet:String?
    public var calPrice:String?
    public var calCurrency:String?

	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        wsoSeq          <- map["WSO_SEQ"]
        promoHour       <- map["PROMO_HOUR"]
        promoDate       <- map["PROMO_DATE"]
        smSeq           <- map["SM_SEQ"]
        wsoItemPic      <- map["WSO_ITPIC"]
        wsoItemName     <- map["WSO_ITNAME"]
        smName          <- map["SM_NAME"]
        smPic           <- map["SM_PIC"]
        calPriceDetet   <- map["CAL_PRICE_DETECT"]
        calPrice        <- map["CAL_PRICE"]
        calCurrency     <- map["CAL_CURRENCY"]
        
    }
}
