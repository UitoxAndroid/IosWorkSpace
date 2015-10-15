//
//  GoodsPageModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/7.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class GoodsPageModel {
    var GoodsPage:GoodsPageResponse?
    
    func getGoodsPageData( completionHandler: (goodsPage: GoodsPageResponse?, errorMessage: String?) -> Void ) {
        let url = DomainPath.Uxapi.rawValue + "/web_item/get_item_and_color_info"
        let data = [
            "sm_seq" : "201410AM210000002"
        ]
        let request = [
            "account": "01_uitoxtest",
            "password": "Aa1234%!@#",
            "platform_id": "AW000001",
            "version": "1.0.0",
            "data": data        ]
        
        ApiManager.sharedInstance.postDictionary(url, params: request as? [String : AnyObject]) {
            (goodsPage: GoodsPageResponse?, error: String?) -> Void in
            
            if goodsPage == nil {
                completionHandler(goodsPage: nil, errorMessage: error)
                return
            }
            
            log.debug("statusCode:\(goodsPage!.status_code)")
            
            if let goodsPageDetail = goodsPage?.itemInfo{
                log.debug("smName = \(goodsPageDetail.smName)")
            }
            
            completionHandler(goodsPage: goodsPage, errorMessage: nil)
        }
        
    }
    
    
}