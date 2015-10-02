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
            "date":"2015/10/31"
            ]
        let request = [
            "account": "01_uitoxtest",
            "password": "Aa1234%!@#",
            "platform_id": "AW000001",
            "version": "1.0.0",
            "data": data        ]

		let api = ApiManager2<DealsOntimeResponse>()
		api.postDictionary(url, params: request as? [String : AnyObject]) {
			(dealsOntime: DealsOntimeResponse?, error: String?) -> Void in
			if dealsOntime == nil {
				completionHandler(dealsOntime: nil, errorMessage: error)
				return
			}

		}

        ApiManager<DealsOntimeResponse>.postDictionary(url, params: request as? [String : AnyObject]) {
            (dealsOntime: DealsOntimeResponse?, error: String?) -> Void in
            
            if dealsOntime == nil {
                completionHandler(dealsOntime: nil, errorMessage: error)
                return
            }
            
            print("statusCode:\(dealsOntime!.status_code)")
            print("data:\(dealsOntime!.dataList)")
            
            if let dealsOntimeList = dealsOntime?.dataList {
                for goodsData in dealsOntimeList {
                    print("\(goodsData.wsoSeq)\t")
                    print("\(goodsData.promoHour)\t")
                    print("\(goodsData.promoDate)\t")
                    print("\(goodsData.smSeq)\t")
                    print("\(goodsData.wsoItemPic)\t")
                    print("\(goodsData.wsoItemName)\t")
                    print("\(goodsData.smName)\t")
                    print("\(goodsData.smPic)\t")
                    print("\(goodsData.calPriceDetet)\t")
                    print("\(goodsData.calPrice)\t")
                    print("\(goodsData.calCurrency)\t")
                    print("\n")
                }
            }
            completionHandler(dealsOntime: dealsOntime, errorMessage: nil)
        }
        
    }
}