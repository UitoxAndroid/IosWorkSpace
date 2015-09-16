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
        let url = "https://uxapi.uitoxbeta.com/web_deploy/get_deploy_data"
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
            
            println("statusCode:\(deploy!.status_code)")
            println("data:\(deploy!.dataList)")
            
            if let slideDataInfo = deploy?.dataList?.slideDataList {
                for slideDataDetail in slideDataInfo {
                    println("\(slideDataDetail.img)\t")
                    println("\(slideDataDetail.link)\t")
                    println("\(slideDataDetail.startDate)\t")
                    println("\(slideDataDetail.endDate)\t")
                    println()
                }
            }
            
            if let productDataInfo = deploy?.dataList?.productDataList {
                for productDataDetail in productDataInfo {
                    println("\(productDataDetail.name)\t")
                    println("\(productDataDetail.desc)\t")
                    println("\(productDataDetail.price)\t")
                    println("\(productDataDetail.smPrice)\t")
                    println("\(productDataDetail.img)")
                    println("\(productDataDetail.link)\t")
                    println("\(productDataDetail.smSeq)\t")
                    println()
                }
            }

            
            completionHandler(deploy: deploy, errorMessage: nil)
        }
        
    }
}