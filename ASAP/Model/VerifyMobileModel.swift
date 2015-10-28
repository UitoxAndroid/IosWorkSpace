//
//  VerifyMobileModel.swift
//  ASAP
//
//  Created by janet on 2015/10/22.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 發送驗證碼
public enum SendVerifyFrom: String {
    case Register       = ""
    case ForgotPassword = "forget_pwd"
}

// 手機驗證碼頁 Model 
class VerifyMobileModel
{
    /*
    發送手機驗證碼資料
    - parameter cellPhone:          手機號碼
    - parameter from:               發送來源(註冊:""/忘記密碼:"forget_pwd")
    - parameter completionHandler:  回呼之後的處理
    
    - returns:
    */
    func sendVerifyMobileData(cellPhone: String, from: String, completionHandler: ( verify: VerifyMobileResponse?, errorMessage: String?) -> Void ) {
            let url = DomainPath.MviewMember.rawValue
            
            let request = [
                "action"        : "member_api/send_security_code",
                "ws_seq"        : "AW000001",
                "cell_phone"    : cellPhone,
                "ip"			: "10.1.88.102",
                "from"          : from
            ]
            
            ApiManager.sharedInstance.postDictionary(url, params: request as [String : AnyObject]?) {
                (verify: VerifyMobileResponse?, error: String?) -> Void in
                
                if verify == nil {
                    completionHandler(verify: nil, errorMessage: error)
                    return
                }
                
                log.debug("statusCode:\(verify!.status_code)")
                log.debug("desctipgion:\(verify!.description)")
                
                completionHandler(verify: verify, errorMessage: nil)
            }
    }
}