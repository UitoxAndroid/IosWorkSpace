//
//  MenuModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/9.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class MenuModel{
    var menu:MenuResponse?
    
	func getMenuData( siSeq:String, completionHandler: (menuResponse: MenuResponse?, errorMessage: String?) -> Void ) {
        let url = "web_menu/get_site_menu_list"
        let data = ["si_seq": siSeq,"type":"child"]
        let request =
            ["account": "01_uitoxtest","password": "Aa1234%!@#","platform_id": "AW000001","version": "1.0.0","data": data]
        
        ApiManager<MenuResponse>.postDictionary(url, params: request as? [String : AnyObject]) {
            (responseObject: MenuResponse?, error: String?) -> Void in

            if responseObject == nil {
//				if error == nil || error == "" {
//					completionHandler(menuResponse: nil, errorMessage: "no data")
//				} else {
//					completionHandler(menuResponse: nil, errorMessage: error)
//				}
				completionHandler(menuResponse: nil, errorMessage: error)
                return
            }

			println("statusCode:\(responseObject!.status_code)")

			if let mnuList = responseObject?.menuList{
				for goodsdata in mnuList {
					println("SID:\(goodsdata.sid)")
					println("NAME:\(goodsdata.name)")
					println("LINK:\(goodsdata.link)")
					println("TYPE:\(goodsdata.type)")
					println("SI_TYPE:\(goodsdata.siType)")
				}
			}

            completionHandler(menuResponse: responseObject, errorMessage: nil)
        }
        
    }

}