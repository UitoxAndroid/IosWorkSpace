//
//  DataInsertSqliteModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/22.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation
import RealmSwift

//SQLite讀寫
class SqlCartList
{
    let realm = try! Realm()
    var datas = CartComboData()
    
    func sqliteInsert() {
        realm.beginWrite()
        realm.create(CartComboData.self,value:datas,update: false)
        log.info("寫入Sqlite...")
        realm.commitWrite()
    }
    
    func sqliteQuery() {
        let results = realm.objects(CartComboData)
        log.info("讀取Sqlite 共\(results.count)筆資料: \t")
        for data in results.enumerate() {
            log.info("itno:\(data.element.itno) , sno:\(data.element.sno)")
        }
    }
}