//
//  ShoppingCartResponse.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/11/9.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 確認購物車回應
public class ShoppingCartResponse: Mappable
{
	/*
	status_code			狀態			Y	String		無異動 / 有異動 / 錯誤
	sm_seq				異動賣場編號	Y	Array		多筆以逗號分隔
	cart_total			購物車總金額	Y	Number		商品總金額 - 折扣 + 運費（不扣購物金）
	sm_list				賣場資料		Y	SMList
	delivery_charges	運費			Y	Number		免運時傳0
	shopping_credits	可用購物金	Y	Number		1. 若有傳入會員GUID，計算購物車可用購物金
													2. 若未傳入會員GUID，回傳0
	payment_method		可用付款方式	Y	String		回傳代碼，有多種以逗號分隔
													1. 取平台目前可用付款方式
													2. 判斷購物車金額是否超過限制
													3. 沒有超取，先不做材積檢核
													4. 一律排除超取"
	installment_method	可用分期	N	InstallmentMethod
	*/
	
	public var statusCode:			String?
	public var statusCodeInData:	String?
	public var description:			String?
	public var smSeq:				[String] = []
	public var cartTotal:           Int?
	public var smList:				[SmInfo] = []
	public var deliveryCharges:		String?
	public var shoppingCredits:		Int?
	public var paymentMethod:		[String] = []
	public var installmentMethod:	[InstallmentMethodInfo] = []
	
	required public init?(_ map: Map) {
		
	}
	
	public func mapping(map: Map) {
		statusCode			<- map["status_code"]
		statusCodeInData	<- map["data.status_code"]
		description			<- map["description"]
		smSeq				<- map["data.sm_seq"]
		cartTotal           <- map["data.cart_total"]
		smList				<- map["data.sm_list"]
		deliveryCharges		<- map["data.delivery_charges"]
		shoppingCredits     <- map["data.shopping_credits"]
		paymentMethod		<- map["data.payment_method"]
		installmentMethod	<- map["data.installment_method"]
	}
}

// 賣場資料
public class SmInfo: Mappable
{
	/*
	sm_seq			賣場流水號	Y	String
	sm_name			賣場名稱		Y	String
	itno			商品編號		Y	String
	product_name	商品名稱		Y	String
	color			顏色			Y	String
	size			尺寸			Y	String
	item_type		商品類別		Y	String		1:主商品 / 2:贈品 / 3:加購品 / 6:組合商品 / 8:購物車加購品
	price			商品價格		Y	Number		若為組合商品為攤提價格
	qty				數量			Y	Number
	pic				商品圖片		Y	String		1. 主商品 - 原生賣場圖
												2. 組合商品 - 組合壩場圖
												3. 購物車加購 - 加購賣場圖
												4. 贈品、加購品 - 沒有圖
	ref_etd_dt		預計出貨日	Y	String		若非預購品，為空
	ssm_limit_qty	限購數量		Y	Number		若非限購品，為空
	discount_info	折扣			N	DiscountInfo
	*/
	
	public var smSeq:			String?
	public var smName:			String?
	public var itno:			String?
	public var productName:		String?
	public var color:			String?
	public var size:			String?
	public var itemType:		String?
	public var price:			String?
	public var qty:				String?
	public var pic:				String?
	public var discountInfo:	[DiscountInfo] = []
	
	required public init?(_ map: Map) {
		
	}
	
	public func mapping(map: Map) {
		smSeq			<- map["sm_seq"]
		smName			<- map["sm_name"]
		itno			<- map["itno"]
		productName		<- map["product_name"]
		color			<- map["color"]
		size			<- map["size"]
		itemType		<- map["item_type"]
		price			<- map["price"]
		qty				<- map["qty"]
		pic				<- map["pic"]
		discountInfo	<- map["discount_info"]
	}
}

// 折扣資料
public class DiscountInfo: Mappable
{
	/*
	act_type				折扣類型	Y	String		買立折 / 行銷活動-滿額折 / 行銷活動-滿額贈
	act_seq					折扣代碼	Y	String		買立折沒有代碼，傳空
	act_name				折扣名稱	Y	String		買立折沒有名稱，傳空
	qualified				是否符合	Y	String		Y/N
	discout					折扣金額	Y	Number		此商品總折扣金額，傳正數
	get_shopping_credits	贈送點數	Y	Number		此商品總贈點
	*/
	
	public var actType:				String?
	public var actSeq:				String?
	public var actName:				String?
	public var qualified:			String?
	public var discout:				String?
	public var getShoppingcredit:	String?
	
	required public init?(_ map: Map) {
		
	}
	
	public func mapping(map: Map) {
		actType				<- map["act_type"]
		actSeq				<- map["act_seq"]
		actName				<- map["act_name"]
		qualified			<- map["qualified"]
		discout				<- map["discout"]
		getShoppingcredit	<- map["get_shopping_credits"]
	}
}


// 可用分期資料
public class InstallmentMethodInfo: Mappable
{
	/*
	installment_type	期數		Y	Number
	bank				銀行代碼	Y	Array		銀行代碼，以逗號分隔
	*/
	
	public var installmentType:	Int?
	public var bank:			[String] = []
	
	required public init?(_ map: Map) {
		
	}
	
	public func mapping(map: Map) {
		installmentType		<- map["installment_type"]
		bank				<- map["bank"]
	}
}



