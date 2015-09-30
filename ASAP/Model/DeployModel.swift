//
//  DeployModel.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/14.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class DeployModel {
    var deploy:DeployResponse?
    
    func getDeployData( siSeq:String, completionHandler: (deploy: DeployResponse?, errorMessage: String?) -> Void ) {
        let url = "web_deploy/get_deploy_data"
        let data = [
            "page_code": "index",
            "mode": "release",
            "si_seq": siSeq]

        let request = [
            "account": "01_uitoxtest",
            "password": "Aa1234%!@#",
            "platform_id": "AW000001",
            "version": "1.0.0",
            "data": data        ]
        
        ApiManager<DeployResponse>.postDictionary(url, params: request as? [String : AnyObject]) {
            (deploy: DeployResponse?, error: String?) -> Void in
            
            if deploy == nil {
                completionHandler(deploy: nil, errorMessage: error)
                return
            }

			if deploy?.dataList?.slideDataList.count == 0 || deploy?.dataList?.productDataList.count == 0 {
				completionHandler(deploy: nil, errorMessage: "no data")
				return
			}


            print("statusCode:\(deploy!.status_code)")
            print("data:\(deploy!.dataList)")
            
            if let slideDataInfo = deploy?.dataList?.slideDataList {
                for slideDataDetail in slideDataInfo {
                    print("\(slideDataDetail.img)\t")
                    print("\(slideDataDetail.link)\t")
                    print("\(slideDataDetail.startDate)\t")
                    print("\(slideDataDetail.endDate)\t")
                    print("\n")
                }
            }
            
            if let productDataInfo = deploy?.dataList?.productDataList {
                for productDataDetail in productDataInfo {
                    print("\(productDataDetail.name)\t")
                    print("\(productDataDetail.desc)\t")
                    print("\(productDataDetail.price)\t")
                    print("\(productDataDetail.smPrice)\t")
                    print("\(productDataDetail.img)")
                    print("\(productDataDetail.link)\t")
                    print("\(productDataDetail.smSeq)\t")
                    print("\n")
                }
            }

            
            completionHandler(deploy: deploy, errorMessage: nil)
        }
        
    }
}