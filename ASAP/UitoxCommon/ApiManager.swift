//
//  ApiManager.swift
//  TestOrm
//
//  Created by uitox_macbook on 2015/8/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class ApiManager<T:Mappable>
{
	static func resetTrustPolicy() -> Void {
		let serverTrustPolicy = ServerTrustPolicy.PinCertificates(
			certificates: ServerTrustPolicy.certificatesInBundle(),
			validateCertificateChain: true,
			validateHost: true
		)

		let serverTrustPolicies: [String: ServerTrustPolicy] = [
			"uxapi.uitoxbeta.com2": serverTrustPolicy,
			"uxapi.uitoxbeta.com": .DisableEvaluation
		]

		Manager.sharedInstance.session.serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
	}

	static func postDictionary(urlPath:String, params:[String:AnyObject]?, completionHandler: (mapperObject: T?, errorMessage:String?) -> Void) {
		resetTrustPolicy()
		Manager.sharedInstance.request(.POST, urlPath, parameters: params).responseObject {
			(responseEntity: T?, error: NSError?) in
			if responseEntity == nil || error != nil {
				completionHandler(mapperObject:nil, errorMessage:error?.localizedDescription)
			} else {
				completionHandler(mapperObject:responseEntity, errorMessage:nil)
			}
		}
	}

	static func postArray(urlPath:String, params:[String:AnyObject]?, completionHandler: (mapperObject: [T]?, errorMessage:String?) -> Void) {
		resetTrustPolicy()
		request(.POST, urlPath, parameters: params).responseArray {
			(responseEntity: [T]?, error: NSError?) in
			if responseEntity == nil || error != nil {
				completionHandler(mapperObject:nil, errorMessage:error?.localizedDescription)
			} else {
				completionHandler(mapperObject:responseEntity, errorMessage:nil)
			}
		}
	}

}
