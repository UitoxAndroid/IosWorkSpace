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
        realm.commitWrite()
    }
    
    func sqliteQuery() {
        let results = realm.objects(CartComboData)
        for data in results.enumerate() {
            log.debug("itno:\(data.element.itno) , sno:\(data.element.sno)")
        }
    }
}