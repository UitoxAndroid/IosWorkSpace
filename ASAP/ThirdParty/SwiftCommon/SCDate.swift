//
//  SCDate.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/11/5.
//  Copyright © 2015年 uitox. All rights reserved.
//

import Foundation

/**
*  日期與時間類
*/
public class SCDate{
	
	/**
	獲取指定格式的NSDateFormatter對象
	
	:param: forMatterString 日期或者時間格式，比如：yyyy-MM-dd
	
	:returns: <#return value description#>
	*/
	public class func getDateFormatter(forMatterString forMatterString:String) -> NSDateFormatter {
		let format:NSDateFormatter = NSDateFormatter()
		format.dateFormat = forMatterString
		return format
	}
	
	/**
	通過指定的DateFormatter獲取日期或者時間字符串
	
	:param: dateFormatter 指定的NSDateFormatter對象
	
	:returns: <#return value description#>
	*/
	public class func getDateStringFromDateFormatter(dateFormatter:NSDateFormatter)->String{
		return dateFormatter.stringFromDate(NSDate())
	}
	
	/**
	獲取當前日期和時間（yyyy-MM-dd HH:mm）
	
	:returns: <#return value description#>
	*/
	public class func getCurrentDateTime()->String{
		return getDateStringFromDateFormatter(getDateFormatter(forMatterString: "yyyy-MM-dd HH:mm"))
	}
	
	/**
	獲取當前日期（yyyy-MM-dd）
	
	:returns: <#return value description#>
	*/
	public class func getCurrentDate()->String{
		return getDateStringFromDateFormatter(getDateFormatter(forMatterString: "yyyy-MM-dd"))
	}
	
	/**
	獲取當前時間（HH:mm）
	
	:returns: <#return value description#>
	*/
	public class func getCurrentTime()->String{
		return getDateStringFromDateFormatter(getDateFormatter(forMatterString: "HH:mm"))
	}
}