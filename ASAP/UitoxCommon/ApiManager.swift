//
//  ApiManager.swift
//  TestOrm
//
//  Created by uitox_macbook on 2015/8/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

class ApiManager2<T:Mappable>
{
	var manager: Manager?

	var domain: String {
		return "https://uxapi.uitoxbeta.com/"
	}


	init() {
		let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()

		let serverTrustPolicy = ServerTrustPolicy.PinCertificates(
			certificates: ServerTrustPolicy.certificatesInBundle(),
			validateCertificateChain: true,
			validateHost: true
		)

		let serverTrustPolicies: [String: ServerTrustPolicy] = [
			"uxapi.uitoxbeta.com2": serverTrustPolicy,
			"uxapi.uitoxbeta.com": .DisableEvaluation
		]

//		manager!.session.serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)
		manager = Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
	}

	func postDictionary(urlPath:String, params:[String:AnyObject]?, completionHandler: (mapperObject: T?, errorMessage:String?) -> Void) {
//		let url = domain + urlPath

//		let req = Manager.sharedInstance.request(.POST, url, parameters: params, encoding: .JSON)
//		req.responseString { ( res:Response<String, NSError>) -> Void in
//			print(res)
//		}

//		Manager.sharedInstance.request(.POST, url, parameters: params, encoding: .JSON).responseObject {
//			(req:NSURLRequest, httpUrlResponse:NSHTTPURLResponse?, responseEntity:T?, _, error:ErrorType?) in
//			if responseEntity == nil || error != nil {
//				completionHandler(mapperObject:nil, errorMessage:error.debugDescription)
//			} else {
//				completionHandler(mapperObject:responseEntity, errorMessage:nil)
//			}
//		}
	}


}

class ApiManager<T:Mappable>
{
	static var domain: String {
		return "https://uxapi.uitoxbeta.com/"
	}

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

		let url = domain + urlPath
//		let req = Manager.sharedInstance.request(.POST, url, parameters: params, encoding: .JSON)
//		req.responseString { ( res:Response<String, NSError>) -> Void in
//			print(res)
//			print(			res.response?.statusCode)
//		}

		Manager.sharedInstance.request(.POST, url, parameters: params, encoding: .JSON).responseObject {
			(req:NSURLRequest, httpUrlResponse:NSHTTPURLResponse?, responseEntity:T?, _, error:ErrorType?) in
			if responseEntity == nil || error != nil {
				completionHandler(mapperObject:nil, errorMessage:error.debugDescription)
			} else {
				completionHandler(mapperObject:responseEntity, errorMessage:nil)
			}
		}

//		Manager.sharedInstance.request(.POST, url, parameters: params, encoding: .JSON).responseObject {
//			(responseEntity: T?, error: NSError?) in
//			if responseEntity == nil || error != nil {
//				completionHandler(mapperObject:nil, errorMessage:error?.localizedDescription)
//			} else {
//				completionHandler(mapperObject:responseEntity, errorMessage:nil)
//			}
//		}
	}

}
