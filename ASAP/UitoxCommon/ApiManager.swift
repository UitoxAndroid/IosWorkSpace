//
//  ApiManager.swift
//  TestOrm
//
//  Created by uitox_macbook on 2015/8/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

public enum DomainPath: String {
	case Uxapi		= "https://uxapi.uitoxbeta.com"
	case Mview		= "https://mview.uitoxbeta.com/A"
	case MemberTw1	= "https://member-tw1.uitoxbeta.com/AW000001"
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
			NSURL(string: DomainPath.Mview.rawValue)!.host!		: .DisableEvaluation,
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
			(req:NSURLRequest, httpUrlResponse:NSHTTPURLResponse?, responseEntity:T?, _, error:ErrorType?) in
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

}
