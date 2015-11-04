//
//  ApiManager.swift
//  TestOrm
//
//  Created by uitox_macbook on 2015/8/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

public enum DomainPath: String {
	case Uxapi			= "https://uxapi.uitoxbeta.com"
	case Mview			= "https://mview.uitoxbeta.com/A"
	case MviewPmadmin	= "https://mview.uitoxbeta.com/A/call_api/pmadmin"
	case MviewWww		= "https://mview.uitoxbeta.com/A/call_api/www"
	case MviewMember	= "https://mview.uitoxbeta.com/A/call_api/member"
	case MemberTw1		= "https://member-tw1.uitoxbeta.com/AW000001"
}

public class ApiManager
{
	public static let sharedInstance: ApiManager = {
		return ApiManager()
	}()

	private var manager: Manager

	init() {
		let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
		configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders

		let serverTrustPolicy = ServerTrustPolicy.PinCertificates(
			certificates: ServerTrustPolicy.certificatesInBundle(),
			validateCertificateChain: true,
			validateHost: true
		)

		let serverTrustPolicies: [String: ServerTrustPolicy] = [
			"uxapi.uitoxbeta.com2"								: serverTrustPolicy,
			NSURL(string: DomainPath.Uxapi.rawValue)!.host!		: .DisableEvaluation,
			NSURL(string: DomainPath.MviewPmadmin.rawValue)!.host!		: .DisableEvaluation,
			NSURL(string: DomainPath.MemberTw1.rawValue)!.host!	: .DisableEvaluation
		]

		manager = Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
	}
	
	func postDictionary<T:Mappable>(urlPath:String, params:[String:AnyObject]?, completionHandler: (mapperObject: T?, errorMessage:String?) -> Void) {
		log.info { () -> String? in
			var output = "\nUrl: \(urlPath)\nRequest >>>\n"
			if let params = params {
				for (key,value) in params {
					output += "\(key):\(value) \n"
				}
			}
			return output
		}
		
		manager.request(.POST, urlPath, parameters: params, encoding: .JSON).responseObject {
			(req:NSURLRequest, httpUrlResponse:NSHTTPURLResponse?, responseEntity:T?, obj:AnyObject?, error:ErrorType?) in
//			if let data = obj as? NSData {
//				let output : String = NSString(data: data , encoding: NSUTF8StringEncoding)
//				log.info("\(output)")
//			}


			if responseEntity == nil || error != nil {
				if error != nil {
					log.error(error.debugDescription)
				}
				completionHandler(mapperObject:nil, errorMessage:error.debugDescription)
			} else {
				completionHandler(mapperObject:responseEntity, errorMessage:nil)
			}
		}
	}

	func postDictionary<T:Mappable>(urlPath:String, params:[String:AnyObject]?, completionHandler: (mapperObject: T?, errorMessage:String?, statusCode:String?) -> Void) {
		log.info { () -> String? in
			var output = "\nUrl: \(urlPath)\nRequest >>>\n"
			if let params = params {
				for (key,value) in params {
					output += "\(key):\(value) \n"
				}
			}
			return output
		}
		
		manager.request(.POST, urlPath, parameters: params, encoding: .JSON).responseObject {
			(req:NSURLRequest, httpUrlResponse:NSHTTPURLResponse?, responseEntity:T?, obj:AnyObject?, error:ErrorType?) in
			if responseEntity == nil || error != nil {
				if error != nil {
					log.error(error.debugDescription)
				}
				completionHandler(mapperObject:nil, errorMessage:error.debugDescription, statusCode: "")
			} else {			
				let statusCode = self.reflection(responseEntity)			
				completionHandler(mapperObject:responseEntity, errorMessage:nil, statusCode: statusCode)
			}
		}
	}

	//取得status code
	func reflection(obj:Any) -> String? {
		var statusCode:String?
		let ref = Mirror(reflecting: obj)
		for child in ref.children {
			
			guard let key = child.label else {
				continue
			}

			let value = child.value
			
			if key == "status_code" {	
				var temp = ""
				Mirror(reflecting: value).children.forEach {
					temp = "\($0.value)"
					return
				}		
				return temp
			}
			
//			log.info("key:\(key),value:\(value)")
			statusCode = reflection(value)
		}
		
		return statusCode
	}
}
