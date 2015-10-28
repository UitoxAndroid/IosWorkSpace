//
//  ResetPasswordModel.swift
//  ASAP
//
//  Created by janet on 2015/10/27.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 手機重設密碼頁 Model
class ResetPasswordModel
{
    /*
    發送手機重設密碼資料
    - parameter cellPhone:          手機號碼
    - parameter password:           密碼
    - parameter completionHandler:  回呼之後的處理
    
    - returns:
    */
    func sendVerifyMobileData(cellPhone: String, password: String, completionHandler: ( reset: ResetPasswordResponse?, errorMessage: String?) -> Void ) {
        let url             = DomainPath.MviewMember.rawValue
        let encodePassword  = password.base64Encode()
        
        let request = [
            "action"        : "member_api/reset_passwd_by_phone",
            "ws_seq"        : "AW000001",
            "cell_phone"    : cellPhone,
            "passwd"        : encodePassword
        ]
        
        ApiManager.sharedInstance.postDictionary(url, params: request as [String : AnyObject]?) {
            (reset: ResetPasswordResponse?, error: String?) -> Void in
            
            if reset == nil {
                completionHandler(reset: nil, errorMessage: error)
                return
            }
            
            log.debug("statusCode:\(reset!.status_code)")
            log.debug("desctipgion:\(reset!.description)")
            
            completionHandler(reset: reset, errorMessage: nil)
        }
    }
}