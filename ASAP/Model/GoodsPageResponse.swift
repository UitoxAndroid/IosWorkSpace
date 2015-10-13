//
//  GoodsPageResponse.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/7.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

public class GoodsPageResponse : Mappable
{
    public var status_code:String?
    public var itemInfo:GoodsPageItemInfo?
    
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        status_code <- map["status_code"]
        itemInfo <- map["item_info"]
    }
}


public class GoodsPageItemInfo : Mappable
{
    public var SmSubTitle:GoodsSubTitle?
    public var PreOrderQty:Int?
    public var SmPicSize:String?
    public var PreAvaQty:String?
    public var IsPreOrd:Bool?
    public var CpSeq:String?
    public var ItRecycle:Bool?
    public var ItInType:Int?
    public var PreDtS:String?
    public var PreDtE:String?
    public var RefEtdDt:String?
    public var ShowDt:String?
    public var SsmStDt:String?
    public var SsmEnDt:String?
    public var SmName:String?
    public var SmPic:String?
    public var SmColorPic:String?
    public var SmStatus:Bool?
    public var SmPrice:Int?
    public var OwnerNo:String?
    public var SsmLimitQty:Int?
    public var IsOrgiItem:Int?
    public var ItPayway:Int?
    public var IsCvsPay:Bool?
    public var SsmPrice:Int?
    public var SsmType:Int?
    public var SmPicMulti:[String]?
    public var Color:String?
    public var ItSize:String?
    public var ItMprice:Int?
    public var Itno:String?
    public var ItSalyqtyLimit:Int?
    public var ItSpecSeq:String?
    public var ItColorSeq:String?
    public var ItLargeVolume:Bool?
    public var SpecType:Int?
    public var Trans:Int?
    public var MarketCrossCountry:String?
    
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        SmSubTitle          <- map["SM_SUB_TITLE"]
        PreOrderQty         <- map["PRE_ORD_QTY"]
        SmPicSize           <- map["SM_PIC_SIZE"]
        PreAvaQty           <- map["PRE_AVA_QTY"]
        IsPreOrd            <- map["IS_PRE_QRD"]
        CpSeq               <- map["CP_SEQ"]
        ItRecycle           <- map["IT_RECYCLE"]
        ItInType            <- map["IT_IN_TYPE"]
        PreDtS              <- map["PRE_DT_S"]
        PreDtE              <- map["PRE_DT_E"]
        RefEtdDt            <- map["REF_ETD_DT"]
        ShowDt              <- map["SHOW_DT"]
        SsmStDt             <- map["SSM_ST_DT"]
        SsmEnDt             <- map["SSM_EN_DT"]
        SmName              <- map["SM_NAME"]
        SmPic               <- map["SM_PIC"]
        SmColorPic          <- map["SM_COLOR_PIC"]
        SmStatus            <- map["SM_STATUS"]
        SmPrice             <- map["SM_PRICE"]
        OwnerNo             <- map["OWNER_NO"]
        SsmLimitQty         <- map["SSM_LIMIT_QTY"]
        IsOrgiItem          <- map["IS_ORGI_ITEM"]
        ItPayway            <- map["IT_PAYWAY"]
        IsCvsPay            <- map["IT_CVS_PAY"]
        SsmPrice            <- map["SSM_PRICE"]
        SsmType             <- map["SSM_TYPE"]
        SmPicMulti          <- map["SM_PIC_MULTI"]
        Color               <- map["COLOR"]
        ItSize              <- map["IT_SIZE"]
        ItMprice            <- map["IT_MPRICE"]
        Itno                <- map["ITNO"]
        ItSalyqtyLimit      <- map["IT_SALYQTY_LIMIT"]
        ItSpecSeq           <- map["IT_SPEC_SEQ"]
        ItColorSeq          <- map["IT_COLOR_SEQ"]
        ItLargeVolume       <- map["IT_LARGE_VOLUME"]
        SpecType            <- map["SPEC_TYPE"]
        Trans               <- map["TRANS"]
        MarketCrossCountry  <- map["market_cross_country"]
    }


}

public class GoodsSubTitle:Mappable
{
    public var type:Int?
    public var title:String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        type <- map["type"]
        title <- map["title"]
    }
}





