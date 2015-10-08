//
//  SCCookie.swift
//  SwiftCommon
//
//  Created by lijl on 15/7/23.
//  Copyright (c) 2015年 lijialong. All rights reserved.
//


import Foundation

/// 访问Cookie的相关方法
public class SCCookie{
	static let kUserDefaultsCookie = "kUserDefaultsCookie"

	/// 获取存放Cookie的Storage
	public class func GetCookieStorage()->NSHTTPCookieStorage{
		return NSHTTPCookieStorage.sharedHTTPCookieStorage()
	}

	/// 获取所有Cookie数组
	public class func GetCookieArray()->[NSHTTPCookie]{

		let cookieStorage = GetCookieStorage()
		let cookieArray = cookieStorage.cookies
		if let arr = cookieArray{
			return arr
		}
		else{
			return []
		}
	}

	/// 获取Cookie值
	public class func GetCookieByName(let cookieName:String)->String?
	{
		let cookieArray:[NSHTTPCookie] = GetCookieArray()
		var value:String?
		if cookieArray.count > 0
		{

			for cookie in cookieArray
			{

				if cookie.name == cookieName
				{
					value = cookie.value
					break
				}
			}
		}
		return value
	}

	/// 根据Cookie内容数据，获取一个对应的NSDictionary数据
	public class func GetRequestFiledByCookie(let cookieAttay:[NSHTTPCookie]) -> [String : String] {

		let requestFiled = NSHTTPCookie.requestHeaderFieldsWithCookies(cookieAttay)
		return requestFiled
	}

	/// 刪除全部Cookie內容
	public class func DeleteCookies() {
		for cookie in GetCookieArray() {
			GetCookieStorage().deleteCookie(cookie)
		}
	}

	/// 印出所有Cookie內容
	public class func PrintCookies() {
		log.debug("\n")
		for cookie: NSHTTPCookie in self.GetCookieArray() {
			log.debug("Cookie:\(cookie)\n")
		}
	}

	/// 儲存Cookies到File
	public class func SaveCookiesToFile() {
		let cookies = GetCookieStorage().cookies!
		let data = NSKeyedArchiver.archivedDataWithRootObject(cookies)
		NSUserDefaults.standardUserDefaults().setObject(data, forKey: self.kUserDefaultsCookie)
	}

	/// 從檔案還原File到Cookies
	public class func RestoreFileToCookieStorage() {
		let cookiesdata = NSUserDefaults.standardUserDefaults().objectForKey(self.kUserDefaultsCookie) as? NSData
		if let cookiesdata = cookiesdata {
			let cookies = NSKeyedUnarchiver.unarchiveObjectWithData(cookiesdata) as? [NSHTTPCookie]
			for cookie in cookies! {
				GetCookieStorage().setCookie(cookie)
			}
		}
	}

}