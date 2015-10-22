//
//  RegisterModel.swift
//  ASAP
//
//  Created by janet on 2015/10/6.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 註冊頁 Model
class RegisterModel
{
    var Register: RegisterResponse?
    
    func sendRegisterData(account: String, password: String, sendEdm: String, completionHandler: ( register: RegisterResponse?,
        errorMessage: String?) -> Void ) {
        let url = DomainPath.Mview.rawValue + "/call_api/member"
        
        let userInfo = [
                "ws_seq"        : "AW000001",
                "reg_ws_seq"    : "AW000001",
                "b2c_name"      : "BETA\\u9583\\u96fb\\u8cfc\\u7269",
                "country"       : "TW",
                "region"        : "TW1",
                "area"          : "TW1",
                "ip_addr"       : "10.1.88.102",
                "send_edm"      : sendEdm
            ]
            
        let accountType = account.containsString("@") ? "email" : "phone"
            
        let request = [
            "action"        : "member_api/register_v2",
            "account_type"  : accountType, //"email", //"phone"
            "account_data"  : account,
            "security_code" : "",
            "passwd"        : password,//"MTIzNDU2",
            "userinfo"      : userInfo
            ]           

            ApiManager.sharedInstance.postDictionary(url, params: request as?[String : AnyObject]) {
                (register: RegisterResponse?, error: String?) -> Void in
                
                if register == nil {
                    completionHandler(register: nil, errorMessage: error)
                    return
                }
                
                log.debug("statusCode:\(register!.status_code)")
                log.debug("desctipgion:\(register!.description)")

                completionHandler(register: register, errorMessage: nil)
            }
    }
}