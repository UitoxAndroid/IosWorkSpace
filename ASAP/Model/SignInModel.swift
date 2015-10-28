//
//  SignInModel.swift
//  ASAP
//
//  Created by janet on 2015/10/20.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 登入頁 Model
class SignInModel
{
    /*
    送出登入資料
    - parameter account:            帳號
    - parameter password:           密碼
    - parameter completionHandler:  回呼之後的處理
    
    - returns:
    */
    func sendSignInData(account: String, password: String, completionHandler: ( signIn: SignInResponse?, errorMessage: String?) -> Void ) {
        let url             = DomainPath.MviewMember.rawValue
        let accountType     = account.accountType()
        let encodePassword  = password.base64Encode()
        
        let request = [            
            "action"        : "member_api/login_v2",
            "ws_seq"        : "AW000001",
            "account_type"  : accountType,      //"email","phone"
            "account_data"  : account,          //"shengeih@uitox.com"
            "passwd"        : encodePassword,   //"MTIzNDU2"
            "ip"			: "10.1.88.102",
            "login_type"	: ""
            ]
            
            ApiManager.sharedInstance.postDictionary(url, params: request as [String : String]) {
                (signIn: SignInResponse?, error: String?) -> Void in
                
                if signIn == nil {
                    completionHandler(signIn: nil, errorMessage: error)
                    return
                }
                
                log.debug("statusCode:\(signIn!.status_code)")
                log.debug("desctipgion:\(signIn!.description)")
                log.debug("guid:\(signIn!.memberData?.guid)")
                log.debug("guid:\(signIn!.memberData?.encodeGuid)")

                completionHandler(signIn: signIn, errorMessage: nil)
            }
    }
}