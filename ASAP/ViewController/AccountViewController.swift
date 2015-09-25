//
//  AccountViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/9/18.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit
import WebKit

class AccountViewController: UIViewController, UIWebViewDelegate, NSURLConnectionDataDelegate
{
	var mgr: Manager!
	var webView: UIWebView?
	var _authenticated:Bool = false
	var _urlConnection:NSURLConnection?
	var _request:NSMutableURLRequest?
	let kUserDefaultsCookie = "kUserDefaultsCookie"
	var storage: NSHTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
	let loginUrl = NSURL(string:"https://member-tw1.uitoxbeta.com/AW000001/maccount/app_login")!
	let memberUrl = NSURL(string: "https://member-tw1.uitoxbeta.com/AW000001/morder/orderList")!

	let userAgent: String = {
		if let info = NSBundle.mainBundle().infoDictionary {
			let executable: AnyObject = info[kCFBundleExecutableKey] ?? "Unknown"
			let bundle: AnyObject = info[kCFBundleIdentifierKey] ?? "Unknown"
			let version: AnyObject = info[kCFBundleVersionKey] ?? "Unknown"
			let os: AnyObject = NSProcessInfo.processInfo().operatingSystemVersionString ?? "Unknown"

			var mutableUserAgent = NSMutableString(string: "\(executable)/\(bundle) (\(version); OS \(os))") as CFMutableString
			let transform = NSString(string: "Any-Latin; Latin-ASCII; [:^ASCII:] Remove") as CFString

			if CFStringTransform(mutableUserAgent, nil, transform, 0) == 1 {
				return mutableUserAgent as String
			}
		}
		return "XX"
	}()

	func configureManager() -> Manager {
		let cfg = NSURLSessionConfiguration.defaultSessionConfiguration()
		cfg.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicy.Always
		cfg.HTTPCookieStorage = storage
		return Manager(configuration: cfg)
	}

	

    override func viewDidLoad() {
        super.viewDidLoad()

		let serverTrustPolicy = ServerTrustPolicy.PinCertificates(
			certificates: ServerTrustPolicy.certificatesInBundle(),
			validateCertificateChain: true,
			validateHost: true
		)

		let serverTrustPolicies: [String: ServerTrustPolicy] = [
			"uxapi.uitoxbeta.com2": serverTrustPolicy,
			"member-tw1.uitoxbeta.com/AW000001": .DisableEvaluation,
			"member-tw1.uitoxbeta.com": .DisableEvaluation,
			"uxapi.uitoxbeta.com": .DisableEvaluation
		]

		mgr = configureManager()
		mgr.session.serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)


		self.webView = UIWebView(frame: self.view.bounds)
		self.webView!.scalesPageToFit = true
		self.webView!.delegate = self
		self.view.addSubview(self.webView!)

    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true)


//		self._request = NSMutableURLRequest(URL: loginUrl)
//		self._request!.setValue("ASAP/com.uitox.ASAP (1; OS Version 8.4 (Build 12H141))", forHTTPHeaderField: "User-Agent")
//		self._request!.setValue("charset=UTF-8", forHTTPHeaderField: "Content-Type")
//		_request!.HTTPMethod = "POST"
//		_request!.HTTPShouldHandleCookies = true

//		deleteCookies()

//		var value = ""
//
//		reSaveToStorage()
//
//		for cookie in self.GetCookieArray(){
//			if cookie.name == "uitox-shop-AW000001" {
//				value = cookie.value!
//				break
//			}
//		}
//
//		var cookieProperties = [String: AnyObject]()
//		cookieProperties[NSHTTPCookieName] = "uitox-shop-AW000001"
//		cookieProperties[NSHTTPCookieValue] = value
//		cookieProperties[NSHTTPCookieDomain] = ".uitoxbeta.com"
//		cookieProperties[NSHTTPCookiePath] = "/AW000001"
//		cookieProperties[NSHTTPCookieExpires] = "242343242342"
//
//		let myCookie = NSHTTPCookie(properties: cookieProperties)
//
//		var cookies = [myCookie!] //storage.cookiesForURL(NSURL(string:"https://member-tw1.uitoxbeta.com/AW000001/")!)!
//		var cookieHeaders = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
//		self._request!.allHTTPHeaderFields = cookieHeaders
//		let allField = self._request!.allHTTPHeaderFields!
//		println(allField)

//		var cookieString = "uitox-shop-AW000001=\(value);path=/AW000001;domain=.uitoxbeta.com;"
//		self._request!.setValue(cookieString, forHTTPHeaderField: "Cookie")


		reSaveToStorage()
		self._request = NSMutableURLRequest(URL: memberUrl)

		var cookies = storage.cookiesForURL(self.loginUrl)!
		var cookieHeaders = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
		self._request!.allHTTPHeaderFields = cookieHeaders


//		println(self._request!.allHTTPHeaderFields!)
		self.pleaseWait()
		self.webView!.loadRequest(self._request!)

	}

	@IBAction func Login(sender: AnyObject) {
//		ApiManager<DealsOntimeResponse>.postDictionary("https://member-tw1.uitoxbeta.com/AW000001/maccount/app_login", params: nil) { (mapperObject, errorMessage) -> Void in
//
//			println("ERRORMESSAGE:\(errorMessage)")
//			self.saveCookiesToLocal()
//		}

//		deleteCookies()
		self._request = NSMutableURLRequest(URL: loginUrl)
		self._request!.HTTPMethod = "POST"
		let params = "account=shengeih@gmail.com&passwd=123456"
		self._request!.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding);
//		self._request!.setValue("ASAP/com.uitox.ASAP (1; OS Version 8.4 (Build 12H141))", forHTTPHeaderField: "User-Agent")
//		self._request!.setValue("charset=UTF-8", forHTTPHeaderField: "Content-Type")
		self.webView!.loadRequest(self._request!)


//		mgr.request(NSURLRequest(URL: loginUrl)).responseString {
//			(_, _, response, _) in
//			var resp = response // { "cookies": { "stack": "overflow" } }
////			println(resp)
//
//			// the cookies are now a part of the URLSession -
//			// we can inspect them and call the next URL
//			println(self.mgr.session.configuration.HTTPCookieStorage?.cookiesForURL(self.loginUrl))
////			println(self.storage.cookiesForURL(self.loginUrl))
//		}
	}

	@IBAction func action(sender: AnyObject) {
		reSaveToStorage()
//		showCookies()
		self._request = NSMutableURLRequest(URL: memberUrl)
//		self._request!.setValue("ASAP/com.uitox.ASAP (1; OS Version 8.4 (Build 12H141))", forHTTPHeaderField: "User-Agent")
//		self._request!.setValue("charset=UTF-8", forHTTPHeaderField: "Content-Type")

		var cookies = storage.cookiesForURL(self.loginUrl)!
		var cookieHeaders = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
		self._request!.allHTTPHeaderFields = cookieHeaders

		self.webView!.loadRequest(self._request!)
//		println(self._request!.allHTTPHeaderFields!)


//		var req = NSMutableURLRequest(URL: self.memberUrl)
//		var cookies = storage.cookiesForURL(self.memberUrl)!
//		var cookieHeaders = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
//		req.allHTTPHeaderFields = cookieHeaders
//		let allField = req.allHTTPHeaderFields!
//		println(allField)
//
//		self.mgr.request(req).responseString {
//			(_, _, response, _) in
////			.response {
////			(_, response, data, error) -> Void in
//			var resp = response // { "cookies": { "stack": "overflow" } }
//			println(resp)
//
//			// the cookies are now a part of the URLSession -
//			// we can inspect them and call the next URL
//
//			println(self.mgr.session.configuration.HTTPCookieStorage?.cookiesForURL(self.memberUrl))
////			println(self.storage.cookiesForURL(self.memberUrl))
//
//			self.webView!.loadHTMLString(resp, baseURL: self.memberUrl)
////			self.webView!.loadData(data, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: self.memberUrl)
//		}
	}

	func saveCookiesToLocal() {
//		let cookies = self.GetCookieArray()

//		for cookie in self.GetCookieArray(){
//			if cookie.name == "uitox-shop-AW000001" {
//				var properString = cookie.value!.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//				println(properString)
//				let c = NSHTTPCookie(properties: ["uitox-shop-AW000001": properString])!
//				storage.setCookie(c)
//			}
//		}

		let cookies = storage.cookiesForURL(self.loginUrl)!
		let data = NSKeyedArchiver.archivedDataWithRootObject(cookies)
		NSUserDefaults.standardUserDefaults().setObject(data, forKey: self.kUserDefaultsCookie)
	}

	func reSaveToStorage() {
		let cookiesdata = NSUserDefaults.standardUserDefaults().objectForKey(self.kUserDefaultsCookie) as? NSData
		if let cookiesdata = cookiesdata {
			let cookies = NSKeyedUnarchiver.unarchiveObjectWithData(cookiesdata) as? [NSHTTPCookie]
//			storage.setCookies(cookies!, forURL: self.memberUrl, mainDocumentURL: nil)
			for cookie in cookies! {
				storage.setCookie(cookie)
			}
		}
	}

	func GetCookieArray()->[NSHTTPCookie]{
		let cookieArray = storage.cookies
		if let arr = cookieArray{
			return cookieArray as! [NSHTTPCookie]
		}
		else{
			return []
		}
	}

	func deleteCookies() {
		for cookie in GetCookieArray() {
			storage.deleteCookie(cookie)
		}
	}

	func showCookies() {
		NSLog("\n")
		for cookie: NSHTTPCookie in self.GetCookieArray() {
			NSLog("cookie:%@\n", cookie)
		}
	}


	func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		NSLog("Did start loading: %@ auth:%d", request.URL!.absoluteString!, _authenticated)

		reSaveToStorage()
		var cookies = storage.cookiesForURL(self.loginUrl)!
		var cookieHeaders = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
		self._request!.allHTTPHeaderFields = cookieHeaders


		if !_authenticated {
			_authenticated = false
			_urlConnection = NSURLConnection(request: self._request!, delegate: self)!
//			println(self._request!.allHTTPHeaderFields!)

			_urlConnection!.start()
			return false
		}
		return true
	}

	func connection(connection: NSURLConnection, willSendRequest request: NSURLRequest, redirectResponse response: NSURLResponse?) -> NSURLRequest? {
		NSLog("redirect %@", request.URLString)
//		self._request!.setValue("ASAP/com.uitox.ASAP (1; OS Version 8.4 (Build 12H141))", forHTTPHeaderField: "User-Agent")
//		self._request!.setValue("charset=UTF-8", forHTTPHeaderField: "Content-Type")

		reSaveToStorage()
		var cookies = storage.cookiesForURL(self.loginUrl)!
		var cookieHeaders = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
		self._request!.allHTTPHeaderFields = cookieHeaders


		return self._request
	}

	func connection(connection: NSURLConnection, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
		NSLog("WebController Got auth challange via NSURLConnection")
		if challenge.previousFailureCount == 0 {
			_authenticated = true
			var credential: NSURLCredential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
			challenge.sender.useCredential(credential, forAuthenticationChallenge: challenge)
		}
		else {
			challenge.sender.cancelAuthenticationChallenge(challenge)
		}
		challenge.sender.continueWithoutCredentialForAuthenticationChallenge(challenge)

	}

	func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
		NSLog("WebController received response via NSURLConnection")

		if let res = response as? NSHTTPURLResponse {
//			println(res.allHeaderFields)
//			let url = NSURL(string: "https://member-tw1.uitoxbeta.com/AW000001")!
//			let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(res.allHeaderFields, forURL: url)
		}

		_authenticated = true
		_urlConnection!.cancel()

		reSaveToStorage()
		var cookies = storage.cookiesForURL(self.loginUrl)!
		var cookieHeaders = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)
		self._request!.allHTTPHeaderFields = cookieHeaders


		webView!.loadRequest(self._request!)
	}

	func webViewDidFinishLoad(webView: UIWebView) {
		NSLog("Did finish load")

		if _request?.URL == loginUrl {
			println("\(loginUrl)")
			saveCookiesToLocal()
		}
		self.clearAllNotice()
	}


	func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace) -> Bool {
		return protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
	}



//	func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//	}
//
//	func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
//		UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//	}
//
//	func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
//		let cred = NSURLCredential.init(forTrust: challenge.protectionSpace.serverTrust!)
//		completionHandler(.UseCredential, cred)
//
//	}
//
//	func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {
//		decisionHandler(WKNavigationResponsePolicy.Allow)
//	}
//
//	func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
//		if navigationAction.navigationType == .LinkActivated {
//			decisionHandler(.Cancel)
//		}
//
//		decisionHandler(WKNavigationActionPolicy.Allow)
//	}
}
