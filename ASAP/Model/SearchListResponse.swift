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
    public var statusCode:      String?
    public var attrList:        [AttributeInfo] = []
    public var storeList:       [StoreInfo]     = []
    public var cateogryList:    [CategoryInfo]  = []
    public var total:           Int?
    public var currentPage:     Int?

	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        statusCode      <- map["status_code"]
        attrList        <- map["attr_value_list"]
        storeList       <- map["list"]
        cateogryList    <- map["category_list"]
        total           <- map["total"]
        currentPage     <- map["current_page"]
    }
}

// 屬性資料
public class AttributeInfo: Mappable
{
    /*  respone/attr/av_seq     屬性編號	String
        respone/attr/av_name	屬性名稱	String
        respone/attr/av_sort	屬性排序	String
        respone/attr/total      屬性總數	Integer*/

    public var name:    String?
	public var sort:    String?
    public var total:   Int?

	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        total		<- map["total"]
    }
}

// 賣場資料

public class StoreInfo: Mappable
{
    /*  respone/list/sm_name	賣場名稱	String
        respone/list/sm_pic     賣場圖片	String
        respone/list/sm_title	賣場標題	String*/

    public var name:		String?
	public var pic:			String?
	public var smPicSize:	String?
	public var smSeq:		String?
	public var finalPrice:  Int?
	public var title:		String?

	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        title		<- map["SM_TITLE"]
		name		<- map["SM_NAME"]
		pic			<- map["SM_PIC"]
		smPicSize	<- map["SM_PIC_SIZE"]
		finalPrice  <- map["FINAL_PRICE"]
    }
}

// 分類資料
public class CategoryInfo: Mappable
{
    /*  respone/category/cp_seq     分類編號	String
        respone/category/cp_name	分類名稱	String
        respone/category/cp_sort	分類排序
        respone/category/total      分類總數	*/

    public var seq:     String?
    public var name:    String?
    public var sort:    String?
    public var total:   Int?
   
	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        seq     <- map["CP_SEQ"]
        name    <- map["CP_NAME"]
        sort    <- map["CP_SORT"]
        total   <- map["total"]
    }
}

// 可賣量
public class MarketInfo: Mappable
{
	/*	respone/list/market_info/price/final_price/show_price/price	價格 String

		*/

	public var showPrice:   Int?
	public var finalPrice:  Int?
	public var slogan:		[String] = []

	required public init?(_ map: Map) {

	}

	public func mapping(map: Map) {
		showPrice     <- map["price.show_price.price"]
		slogan		  <- map["other.slogan"]
	}

}
