//
//  RegisterModel.swift
//  ASAP
//
//  Created by janet on 2015/10/6.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

// 密碼強度
public enum Strength: Int {
    case Weak
    case Medium
    case Strong
}

extension String {
    // base64加密
    func base64Encode() -> String {
        let utf8Str: NSData = self.dataUsingEncoding(NSUTF8StringEncoding)!
        return utf8Str.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }
    
    // 帳號類型 email/phone
    func accountType() -> String {
        return self.isMobile() ? "phone" : "email"
    }
    
    // 行動電話
    func isMobile() -> Bool {
        let pattern = "^0[0-9]{9}"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        return regex.firstMatchInString(self, options: [], range: NSMakeRange(0, characters.count)) != nil
    }
    
    // 密碼強度:弱
    func isWeak() -> Bool {
        if (self.characters.count < 6) {
            return true
        }
        
        let pattern = "^[0-9]*$|^[a-zA-Z]+$"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        return regex.firstMatchInString(self, options: [], range: NSMakeRange(0, characters.count)) != nil
    }
    
    // 密碼強度:強
    func isStrong() -> Bool {
        let pattern = "^(?=^.{6,16}$)((?=.*[A-Za-z0-9-_])(?=.*[A-Za-z])(?=.*[-_]))^.*$"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        return regex.firstMatchInString(self, options: [], range: NSMakeRange(0, characters.count)) != nil
    }
}
// 註冊頁 Model
class RegisterModel
{
    typealias completedHandler = (register: RegisterResponse?, errorMessage: String?) -> Void
    
    /*
    送出註冊資料
    - parameter account:            帳號
    - parameter password:           密碼
    - parameter sendEdm:            電子報
    - parameter verify:             手機驗證碼(phone才需要填)
    - parameter completionHandler:  回呼之後的處理
    
    - returns:
    */
    func sendRegisterData( account: String, password: String, sendEdm: String, verify: String, completionHandler: completedHandler ) {
        let url             = DomainPath.MviewMember.rawValue
        let accountType     = account.accountType()
        let encodePassword  = password.base64Encode()
        
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
        
        let request = [
            "action"        : "member_api/register_v2",
            "account_type"  : accountType, //"email","phone"
            "account_data"  : account,
            "security_code" : verify,
            "passwd"        : encodePassword,
            "userinfo"      : userInfo
            ]           

            ApiManager.sharedInstance.postDictionary( url, params: request as?[String : AnyObject] ) {
                (register: RegisterResponse?, error: String?) -> Void in
                
                if register == nil {
                    completionHandler(register: nil, errorMessage: error)
                    return
                }
                
                log.debug("statusCode:\(register!.status_code)")
                log.debug("desctipgion:\(register!.description)")

				var status_code = register!.status_code
				let range       = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
				status_code?.removeRange(range)

				if status_code! == "100" {
					let memberData = MemberData() 
					if accountType == "email" {
						memberData.email = account
					} else {
						memberData.phone = account						
					}

					memberData.guid = register!.guid!
					memberData.encodeGuid = register!.encodeGuid!
					MyApp.sharedMember.insertMemberDataIntoDisk(memberData)					
				}
				
                completionHandler(register: register, errorMessage: nil)
            }
    }
}