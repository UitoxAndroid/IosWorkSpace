//
//  DealsOntimeModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/16.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class DealsOntimeModel {
    var DealsOntime:DealsOntimeResponse?
    
    func getDealsOntimeData( completionHandler: (dealsOntime: DealsOntimeResponse?, errorMessage: String?) -> Void ) {
        let url = "web_ontime/get_items"
        let data = [
            "wc_seq":"AWC000001",
            "range":"date",
            "date":"2015/09/16"
            ]
        let request = [
            "account": "01_uitoxtest",
            "password": "Aa1234%!@#",
            "platform_id": "AW000001",
            "version": "1.0.0",
            "data": data        ]
        
        ApiManager<DealsOntimeResponse>.postDictionary(url, params: request as? [String : AnyObject]) {
            (dealsOntime: DealsOntimeResponse?, error: String?) -> Void in
            
            if dealsOntime == nil {
                completionHandler(dealsOntime: nil, errorMessage: error)
                return
            }
            
            println("statusCode:\(dealsOntime!.status_code)")
            println("data:\(dealsOntime!.dataList)")
            
            if let dealsOntimeList = dealsOntime?.dataList {
                for goodsData in dealsOntimeList {
                    println("\(goodsData.wsoSeq)\t")
                    println("\(goodsData.promoHour)\t")
                    println("\(goodsData.promoDate)\t")
                    println("\(goodsData.smSeq)\t")
                    println("\(goodsData.wsoItemPic)\t")
                    println("\(goodsData.wsoItemName)\t")
                    println("\(goodsData.smName)\t")
                    println("\(goodsData.smPic)\t")
                    println("\(goodsData.calPriceDetet)\t")
                    println("\(goodsData.calPrice)\t")
                    println("\(goodsData.calCurrency)\t")
                    println()
                }
            }
            completionHandler(dealsOntime: dealsOntime, errorMessage: nil)
        }
        
    }
}