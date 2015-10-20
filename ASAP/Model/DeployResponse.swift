//
//  DeployResponse.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/14.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

// 首頁佈置資料
public class DeployResponse : Mappable
{
/*  respone/data/	模組資料    */
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
/*  slide.045       廣告輪播    首頁區塊1
    link.050        文字連結    首頁區塊2
    iconlink.046    圖片連結1   首頁區塊4
    iconlink.047    圖片連結2   首頁區塊6
    product.048     商品連結1   首頁區塊5
    product.049     商品連結2   首頁區塊7   */
    
    public var slideDataList:       [SlideData]=[]
    public var linkDataList:        [LinkData]=[]
    public var iconLinkDataList1:   [IconLinkData]=[]
    public var iconLinkDataList2:   [IconLinkData]=[]
    public var productDataList1:    [ProductData]=[]
    public var productDataList2:    [ProductData]=[]
    
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
// 廣告輪播
public class SlideData : Mappable
{
/*  slide/【module_id】/【num】/img         圖片路徑
    slide/【module_id】/【num】/link        圖片連結
    slide/【module_id】/【num】/page_code   內部網站連結page_code
    slide/【module_id】/【num】/seq         內部網站連結seq       */
    
    public var img:     String?
    public var link:    String?
    public var pageCode:String?
    public var seq:     String?
    
	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        img         <- map["img"]
        link        <- map["link"]
        pageCode    <- map["page_code"]
        seq         <- map["seq"]
    }
}
// 文字連結
public class LinkData : Mappable
{
/*  link/【module_id】/【num】/name         名稱
    link/【module_id】/【num】/link         連結
    link/【module_id】/【num】/page_code    內部網站連結page_code
    link/【module_id】/【num】/seq          內部網站連結seq       */
    
    public var name:    String?
    public var link:    String?
    public var pageCode:String?
    public var seq:     String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        name        <- map["name"]
        link        <- map["link"]
        pageCode    <- map["page_code"]
        seq         <- map["seq"]
    }
}
// 圖片連結
public class IconLinkData : Mappable
{
/*  iconlink/【module_id】/【num】/img          圖片
    iconlink/【module_id】/【num】/link         連結
    iconlink/【module_id】/【num】/page_code    內部網站連結page_code
    iconlink/【module_id】/【num】/seq          內部網站連結seq       */
    
    public var img:     String?
    public var link:    String?
    public var pageCode:String?
    public var seq:     String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        img         <- map["img"]
        link        <- map["link"]
        pageCode    <- map["page_code"]
        seq         <- map["seq"]
    }
}
// 商品連結
public class ProductData : Mappable
{
/*  product/【module_id】/【num】/sm_seq    賣場編號
    product/【module_id】/【num】/name      賣場名稱
    product/【module_id】/【num】/slogan    slogan
    product/【module_id】/【num】/sm_price  售價
    product/【module_id】/【num】/price     建議售價
    product/【module_id】/【num】/img       賣場圖片*/
    
    public var smSeq:       String?
    public var name:        String?
    public var sloganList:  Slogan?
    public var smPrice:     String?
    public var price:       String?
    public var img:         String?
    
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
// slogan
public class Slogan : Mappable
{
    public var one:     String?
    public var two:     String?
    public var three:   String?
    
	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        one     <- map["1"]
        two     <- map["2"]
        three   <- map["3"]
    }
}