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
    func sendSignInData(account: String, password: String, completionHandler: 
		( signIn: SignInResponse?, errorMessage: String?) -> Void ) {
        let url = DomainPath.MviewMember.rawValue
        
        //let accountType = account.containsString("@") ? "email" : "phone"
            
        let request = [            
            "action"        : "member_api/login_v2",
            "ws_seq"        : "AW000001",
            "account_type"  : "email", //accountType, // email/phone
            "account_data"  : "shengeih@uitox.com", //account
            "passwd"        : "MTIzNDU2", //password
            "ip"			: "",
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
			
			if let data = signIn!.memberData {
				MyApp.sharedMember.insertMemberDataIntoDisk(data)					
			}

			completionHandler(signIn: signIn, errorMessage: nil)
		}
    }
}