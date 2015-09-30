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

			print("statusCode:\(responseObject!.status_code)")

			if let mnuList = responseObject?.menuList{
				for goodsdata in mnuList {
					print("SID:\(goodsdata.sid)")
					print("NAME:\(goodsdata.name)")
					print("LINK:\(goodsdata.link)")
					print("TYPE:\(goodsdata.type)")
					print("SI_TYPE:\(goodsdata.siType)")
				}
			}

            completionHandler(menuResponse: responseObject, errorMessage: nil)
        }
        
    }

}