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
    /*  smSubTitle      賣場副標題
        preOrderQty     預購量
        smPicSize       賣場圖檔尺寸
        preAvaQty       可被預購量
        isPreOrd        預購旗標
        preDtS          預購開始時間
        preDtE          預購結束時間
        refEtdDt        參考出貨時間
        showDt          單品曝光時間
        ssmStDt         活動開始時間
        ssmEnDt         活動結束時間
        smName          賣場名稱
        smPic           賣場大圖
        smColorPic      賣場色圖(小)
        smStatus        賣場狀態         0:不顯示, 1:顯示
        smPrice         賣場售價
        ssmLimitQty     限購數量
        ssmPrice        特賣變價售價
        ssmType         特賣變價型態      1:特賣變價, 2:折扣   若為 1 或 2 時，價格拿  SSM_PRICE
        smPicMulti      賣場多主圖
        color           顏色
        itSize          商品尺寸
        itMprice        商品市價
        itno            商品流水號
        itSalyqtyLimit  商品最低可賣量
        itSpecSeq       商品規格群組
        itColorSeq      商品顏色群組
        specType        商品規格         0:無COLOR, 1:無IT_SIZE, 2:有IT_SIZE
    */
    
    public var smSubTitle:GoodsSubTitle?
    public var preOrderQty:Int?
    public var smPicSize:String?
    public var preAvaQty:String?
    public var isPreOrd:Bool?
    public var preDtS:String?
    public var preDtE:String?
    public var refEtdDt:String?
    public var showDt:String?
    public var ssmStDt:String?
    public var ssmEnDt:String?
    public var smName:String?
    public var smPic:String?
    public var smColorPic:String?
    public var smStatus:Bool?
    public var smPrice:Int?
    public var ssmLimitQty:Int?
    public var ssmPrice:Int?
    public var ssmType:Int?
    public var smPicMulti:[String]?
    public var color:String?
    public var itSize:String?
    public var itMprice:Int?
    public var itno:String?
    public var itSalyqtyLimit:Int?
    public var itSpecSeq:String?
    public var itColorSeq:String?
    public var specType:Int?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        smSubTitle          <- map["SM_SUB_TITLE"]
        preOrderQty         <- map["PRE_ORD_QTY"]
        smPicSize           <- map["SM_PIC_SIZE"]
        preAvaQty           <- map["PRE_AVA_QTY"]
        isPreOrd            <- map["IS_PRE_QRD"]
        preDtS              <- map["PRE_DT_S"]
        preDtE              <- map["PRE_DT_E"]
        refEtdDt            <- map["REF_ETD_DT"]
        showDt              <- map["SHOW_DT"]
        ssmStDt             <- map["SSM_ST_DT"]
        ssmEnDt             <- map["SSM_EN_DT"]
        smName              <- map["SM_NAME"]
        smPic               <- map["SM_PIC"]
        smColorPic          <- map["SM_COLOR_PIC"]
        smStatus            <- map["SM_STATUS"]
        smPrice             <- map["SM_PRICE"]
        ssmLimitQty         <- map["SSM_LIMIT_QTY"]
        ssmPrice            <- map["SSM_PRICE"]
        ssmType             <- map["SSM_TYPE"]
        smPicMulti          <- map["SM_PIC_MULTI"]
        color               <- map["COLOR"]
        itSize              <- map["IT_SIZE"]
        itMprice            <- map["IT_MPRICE"]
        itno                <- map["ITNO"]
        itSalyqtyLimit      <- map["IT_SALYQTY_LIMIT"]
        itSpecSeq           <- map["IT_SPEC_SEQ"]
        itColorSeq          <- map["IT_COLOR_SEQ"]
        specType            <- map["SPEC_TYPE"]
    }


}

public class GoodsSubTitle:Mappable
{
    /*
        type    啓用賣場副標題   0:否, 1:是
        title   賣場副標題       
    */

    public var type:Int?
    public var title:String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        type <- map["type"]
        title <- map["title"]
    }
}





