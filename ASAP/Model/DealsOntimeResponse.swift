//
//  DealsOntimeResponse.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/16.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

// 整點特賣
public class DealsOntimeResponse : Mappable
{
/*  respone/status	結果      0=OFF, 1=ON
    respone/count	總筆數                 */
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
/*  respone/data/[num]/WSO_SEQ          整點特賣流水號
    respone/data/[num]/PROMO_HOUR       特賣時間
    respone/data/[num]/PROMO_DATE       特賣日期
    respone/data/[num]/SM_SEQ           賣場編號
    respone/data/[num]/WSO_ITPIC        自訂特賣圖片
    respone/data/[num]/WSO_ITNAME       自訂特賣名稱
    respone/data/[num]/SM_NAME          賣場名稱
    respone/data/[num]/SM_PIC           賣場圖片
    respone/data/[num]/CAL_PRICE_DETECT	特賣上稿模式
    respone/data/[num]/CAL_PRICE        特賣價格
    respone/data/[num]/CAL_CURRENCY     特賣價格符號
    respone/data/[num]/SM_PRICE         建議售價    */
    
    public var wsoSeq:String?
    public var promoHour:String?
    public var promoDate:String?
    public var smSeq:String?
    public var wsoItemPic:String?
    public var wsoItemName:String?
    public var smName:String?
    public var smPic:String?
    public var calPriceDetect:String?
    public var calPrice:String?
    public var calCurrency:String?
    public var smPrice:String?

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
        calPriceDetect  <- map["CAL_PRICE_DETECT"]
        calPrice        <- map["CAL_PRICE"]
        calCurrency     <- map["CAL_CURRENCY"]
        smPrice         <- map["SM_PRICE"]
    }
}
