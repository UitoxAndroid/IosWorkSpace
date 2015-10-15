//
//  RegisterModel.swift
//  ASAP
//
//  Created by janet on 2015/10/6.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

class RegisterModel
{
    var Register: RegisterResponse?
    
    func sendRegisterData(account: String, password: String, sendEdm: String, completionHandler: ( register: RegisterResponse?,
        errorMessage: String?) -> Void ) {
        let url = DomainPath.MemberTw1.rawValue + "/member/register"
        
            let data = [
                "wc_seq":"AWC000001"
            ]
            
        let request = [
            "member_email"  : account,
            "member_passwd" : password,
            "send_edm"      : sendEdm,
            "account"       : "01_uitoxtest",
            "password"      : "Aa1234%!@#",
            "platform_id"   : "AW00001",
            "version"       : "1.0.0",
            "data"          : data
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