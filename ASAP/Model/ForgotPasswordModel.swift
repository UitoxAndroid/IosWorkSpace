//
//  ForgetPasswordModel.swift
//  ASAP
//
//  Created by janet on 2015/10/27.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 忘記密碼頁 Model
class ForgotPasswordModel
{
    typealias completedHandler = (forgot: ForgotPasswordResponse?, errorMessage: String?) -> Void

    /*
    送出忘記密碼資料
    - parameter account:            帳號
    - parameter verify:             手機驗證碼(phone才需要填)
    - parameter completionHandler:  回呼之後的處理
    
    - returns:
    */
    func sendForgotPasswordData(account: String, verify: String, completionHandler: completedHandler ) {
        let url             = DomainPath.MviewMember.rawValue
        let accountType     = account.accountType()
            
        let request = [
            "action"        : "member_api/forget_passwd_v2",
            "ws_seq"        : "AW000001",
            "account_type"  : accountType,  //"email","phone"
            "account_data"  : account,
            "security_code" : verify
        ]
            
        ApiManager.sharedInstance.postDictionary(url, params: request as [String : String]) {
            (forgot: ForgotPasswordResponse?, error: String?) -> Void in
                
            if forgot == nil {
                completionHandler(forgot: nil, errorMessage: error)
                return
            }
                
            log.debug("statusCode:\(forgot!.status_code)")
            log.debug("desctipgion:\(forgot!.description)")
                
            completionHandler(forgot: forgot, errorMessage: nil)
        }
    }
}