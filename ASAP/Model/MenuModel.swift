//
//  MenuModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/9.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class MenuModel
{   
	func getMenuData( siSeq:String, completionHandler: (menuResponse: MenuResponse?, errorMessage: String?) -> Void ) {
        let url = DomainPath.Uxapi.rawValue + "/web_menu/get_site_menu_list"
        let data = [
			"si_seq": siSeq,
			"type": "child"
		]

        let request = [
			"account": "01_uitoxtest",
			"password": "Aa1234%!@#",
			"platform_id": "AW000001",
			"version": "1.0.0",
			"data": data
		]
        
        ApiManager.sharedInstance.postDictionary(url, params: request as? [String : AnyObject]) {
            (responseObject: MenuResponse?, error: String?) -> Void in

            if responseObject == nil {
				completionHandler(menuResponse: nil, errorMessage: error)
                return
            }

			log.debug("statusCode:\(responseObject!.status_code)")

			if let mnuList = responseObject?.menuList{
				for goodsdata in mnuList {
					log.debug("SID:\(goodsdata.sid)")
					log.debug("NAME:\(goodsdata.name)")
					log.debug("LINK:\(goodsdata.link)")
					log.debug("TYPE:\(goodsdata.type)")
					log.debug("SI_TYPE:\(goodsdata.siType)")
				}
			}

            completionHandler(menuResponse: responseObject, errorMessage: nil)
        }
        
    }

}