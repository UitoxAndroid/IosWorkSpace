//
//  DealsOntimeModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/16.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class DealsOntimeModel
{   
    func getDealsOntimeData( completionHandler: (dealsOntime: DealsOntimeResponse?, errorMessage: String?) -> Void ) {
        let url = DomainPath.Uxapi.rawValue + "/web_ontime/get_items"
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
            "data": data
		]

		ApiManager.sharedInstance.postDictionary(url, params: request as? [String : AnyObject]) {
			(dealsOntime: DealsOntimeResponse?, error: String?) -> Void in
			if dealsOntime == nil {
				completionHandler(dealsOntime: nil, errorMessage: error)
				return
			}

			log.debug("statusCode:\(dealsOntime!.status_code)")
			log.debug("data:\(dealsOntime!.dataList)")

			if let dealsOntimeList = dealsOntime?.dataList {
				for goodsData in dealsOntimeList {				
					log.debug("\(goodsData.wsoSeq)\t")
					log.debug("\(goodsData.promoHour)\t")
					log.debug("\(goodsData.promoDate)\t")
					log.debug("\(goodsData.smSeq)\t")
					log.debug("\(goodsData.wsoItemPic)\t")
					log.debug("\(goodsData.wsoItemName)\t")
					log.debug("\(goodsData.smName)\t")
					log.debug("\(goodsData.smPic)\t")
					log.debug("\(goodsData.calPriceDetet)\t")
					log.debug("\(goodsData.calPrice)\t")
					log.debug("\(goodsData.calCurrency)\t")
				}
			}
			completionHandler(dealsOntime: dealsOntime, errorMessage: nil)
		}
    }
}