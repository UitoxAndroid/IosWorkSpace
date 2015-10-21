//
//  DeployModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/14.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class DeployModel
{
    var deploy:DeployResponse?
    
    func getDeployData( siSeq:String, completionHandler: (deploy: DeployResponse?, errorMessage: String?) -> Void ) {
        let url = DomainPath.Uxapi.rawValue + "/web_deploy/get_deploy_data"
        let data = [
            "page_code": "index",
            "mode": "release",
            "si_seq": siSeq
		]

        let request = [
            "account": "01_uitoxtest",
            "password": "Aa1234%!@#",
            "platform_id": "AW000001",
            "version": "1.0.0",
            "data": data
		]
        
        ApiManager.sharedInstance.postDictionary(url, params: request as? [String : AnyObject]) {
            (deploy: DeployResponse?, error: String?) -> Void in
            
            if deploy == nil {
                completionHandler(deploy: nil, errorMessage: error)
                return
            }

			if deploy?.dataList?.slideDataList.count == 0 || deploy?.dataList?.linkDataList.count == 0 || deploy?.dataList?.productDataList1.count == 0 || deploy?.dataList?.productDataList2.count == 0 || deploy?.dataList?.iconLinkDataList1.count == 0 || deploy?.dataList?.iconLinkDataList2.count == 0 {
				completionHandler(deploy: nil, errorMessage: "no data")
				return
			}


            log.debug("statusCode:\(deploy!.status_code)")
            log.debug("data:\(deploy!.dataList)")
            
            if let slideDataInfo = deploy?.dataList?.slideDataList {
                for slideDataDetail in slideDataInfo {
                    log.debug("\(slideDataDetail.img)\t")
                    log.debug("\(slideDataDetail.link)\t")
                    log.debug("\(slideDataDetail.pageCode)\t")
                    log.debug("\(slideDataDetail.seq)\t")
                    log.debug("\n")
                }
            }
            
            if let productDataInfo = deploy?.dataList?.productDataList1 {
                for productDataDetail in productDataInfo {
                    log.debug("\(productDataDetail.name)\t")
                    log.debug("\(productDataDetail.price)\t")
                    log.debug("\(productDataDetail.smPrice)\t")
                    log.debug("\(productDataDetail.img)")
                    log.debug("\(productDataDetail.smSeq)\t")
                    log.debug("\n")
                }
            }

            
            completionHandler(deploy: deploy, errorMessage: nil)
        }
        
    }
}