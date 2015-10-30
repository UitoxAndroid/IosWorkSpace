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
	
	var goodsList: [ShoppingCartInfo] {
		get {
			let realm = try! Realm()
			let results = realm.objects(ShoppingCartInfo)
			
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

	func insertGoodsIntoCart(shoppingCartInfo: ShoppingCartInfo) {
		realm.beginWrite()
		realm.create(ShoppingCartInfo.self, value: shoppingCartInfo, update: false)
		realm.commitWrite()
	}

}

