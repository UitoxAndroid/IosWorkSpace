//
//  ShoppingCartModel.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/10/30.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingCartModel
{
	let realm = try! Realm()
	typealias completedHandler = (resp: ShoppingCartResponse?, errorMessage: String?) -> Void
	
	var goodsList: [CartDetail] {
		get {
			let realm = try! Realm()
			let results = realm.objects(CartDetail)

			return results.map{ $0 }
		}
	}

	
	func queryShoppingCart() {
		let results = realm.objects(CartComboData)
		log.info("讀取Sqlite 共\(results.count)筆資料: \t")
		for data in results.enumerate() {
			log.info("itno:\(data.element.itno) , sno:\(data.element.sno)")
		}
	}

	func insertGoodsIntoCart(shoppingCartDetail: CartDetail) {
		realm.beginWrite()
		realm.create(CartDetail.self, value: shoppingCartDetail, update: false)
		realm.commitWrite()
	}
    
    func deleteGoodsFromCart(shoppingcartDetail: CartDetail) {
        realm.beginWrite()
        realm.delete(shoppingcartDetail)
        realm.commitWrite()
    }
	
    func clearGoodsCart() {
        let results = realm.objects(CartDetail)
        if results.count > 0 {
            var index = results.count - 1
            while index >= 0 {
                realm.write {
                    self.realm.delete(results[index])
                }
                index--
            }
        }
    }
    
	/**
	呼叫購物車清單
	- parameter completionHandler:  回呼之後的處理
	
	- returns:
	*/
	func callApiGetShoppingCart(completionHandler: completedHandler) {
		let urlPath = DomainPath.MviewShop.rawValue
		let cartList = MyApp.sharedShoppingCart.goodsList
		
		
		let data = [
			"mem_guid":MyApp.sharedMember.encodeGuid,
			"platform_id":"AW000001",
			"cart_list":transCartDetailParameters(cartList)
		]
		
		let requestDic = [
			"action": "app_api/lists",
			"platform_id": "AW000001",
			"data": data
		]
		

		ApiManager.sharedInstance.postDictionary(urlPath, params: requestDic) {
			(resp: ShoppingCartResponse?, error: String?) -> Void in
			
			if resp == nil {
				completionHandler(resp: nil, errorMessage: error)
				return
			}
			
			log.debug("statusCode:\(resp!.statusCode)")
			
			if resp?.statusCodeInData != "100" {
				completionHandler(resp: nil, errorMessage: resp?.description)
				return
			}
			
			completionHandler(resp: resp, errorMessage: nil)
		}

	}
	
	// 將物件轉成符合的json格式
	func transCartDetailParameters(cartList: [CartDetail]) -> [AnyObject] {
		var results = [AnyObject]()
		
		for detail in cartList {
			let dic: [String: String] = [
				"sm_seq":detail.smSeq,
				"qty":detail.qty
			]
			results.append(dic)
		}
		
		return results
	}


}

