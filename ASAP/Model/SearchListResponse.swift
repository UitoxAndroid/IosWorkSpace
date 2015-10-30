//
//  SearchListResponse.swift
//  ASAP
//
//  Created by janet on 2015/9/2.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

// 搜尋頁
public class SearchListResponse: Mappable
{
    public var statusCode:      String?
    public var storeList:       [StoreInfo]     = []
    public var total:           Int?
    public var currentPage:     String?
	public var maxPage:			Int?
    public var campInfo:        [CampaignInfo]  = []  // 行銷活動頁用

	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
        statusCode      <- map["status_code"]
        storeList       <- map["list"]
        total           <- map["total"]
        currentPage     <- map["current_page"]
		maxPage			<- map["max_page"]
        campInfo        <- map["campaign_info"]
    }
}

// 賣場資料
public class StoreInfo: Mappable
{
    /*  respone/list/sm_name		賣場名稱	String
        respone/list/sm_pic			賣場圖片	String
		response/list/SM_PIC_SIZE	圖片尺吋 String
		response/list/FINAL_PRICE	價格		Int
		response/list/SHOW_PRICE	原價		Int
		response/list/SLOGAN		銷售口號	Array
		response/list/CART_ACTION	購買類型 Int
        response/list/SM_SEQ        商品流水號*/

    public var name:		String?
	public var pic:			String?
	public var smPicSize:	String?
	public var finalPrice:  Int?
	public var showPrice:	Int?
	public var slogan:		[String] = []
	public var cartAction:	Int?
    public var smSeq:       String?

	required public init?(_ map: Map) {

	}

    public func mapping(map: Map) {
		name		<- map["SM_NAME"]
		pic			<- map["SM_PIC"]
		smPicSize	<- map["SM_PIC_SIZE"]
		finalPrice  <- map["FINAL_PRICE"]
		showPrice	<- map["SHOW_PRICE"]	
		slogan		<- map["SLOGAN"]
		cartAction	<- map["CART_ACTION"]
        smSeq       <- map["SM_SEQ"]
    }
}

// 行銷活動頁資料
public class CampaignInfo: Mappable
{
    /*
    respone/campaign_info/camp_name     行銷活動名稱
    respone/campaign_info/camp_promote	滿額多少 折抵多少
    respone/campaign_info/start_dt      活動開始日期
    respone/campaign_info/edn_dt        活動結束日期
    respone/campaign_info/camp_type	    活動類型           0:滿額折 1:滿額贈購物金 2:滿額送贈品
    respone/campaign_info/camp_status	行銷活動狀態        0:在活動期間內 1:活動未開始 2:活動已結束
    */
    
    public var campName     :String?
    public var campPromote  :[campPromoteDetail] = []
    public var startDate    :String?
    public var endDate      :String?
    public var campType     :String?
    public var campStatus   :Int?
    
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map:Map) {
        campName    <- map["CAMP_NAME"]
        campPromote <- map["CAMP_PROMOTE"]
        startDate   <- map["START_DT"]
        endDate     <- map["END_DT"]
        campType    <- map["CAMP_TYPE"]
        campStatus  <- map["CAMP_STATUS"]
    }
}

// 行銷活動規則
public class campPromoteDetail:Mappable
{
    /*
    campPrice      滿額多少
    campDiscount   折抵多少
    */
    public var campPrice    :String?
    public var campDiscount :String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        campPrice    <- map["camp_price"]
        campDiscount <- map["camp_discount"]
    }
}
