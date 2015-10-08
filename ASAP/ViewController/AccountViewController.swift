//
//  AccountViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/9/18.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UIWebViewDelegate, NSURLConnectionDataDelegate
{
	var webView: UIWebView?
	var authenticated:Bool = false
	var urlConnection:NSURLConnection?
	var request:NSMutableURLRequest?
	let loginUrl = NSURL(string: DomainPath.MemberTw1.rawValue + "/maccount/app_login")!
	let memberUrl = NSURL(string: DomainPath.MemberTw1.rawValue + "/morder/orderList")!

    override func viewDidLoad() {
        super.viewDidLoad()

		self.webView = UIWebView(frame: self.view.bounds)
		self.webView!.scalesPageToFit = true
		self.webView!.delegate = self
		self.view.addSubview(self.webView!)
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true)

		SCCookie.RestoreFileToCookieStorage()

		self.request = NSMutableURLRequest(URL: memberUrl)
		self.request!.setValue("asap", forHTTPHeaderField: "User-agent")
		self.request!.setValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
		self.request!.allHTTPHeaderFields = SCCookie.GetRequestFiledByCookie(SCCookie.GetCookieArray())
		self.pleaseWait()
		self.webView!.loadRequest(self.request!)
	}

	@IBAction func Login(sender: AnyObject) {
		let myTabBarViewController = UIApplication.sharedApplication().delegate?.window!?.rootViewController as? MyTabBarViewController
		myTabBarViewController!.login("shengeih@gmail.com", passwd: "123456")
	}

	func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		log.debug("Did start loading: \(request.URL!.absoluteString)")

		SCCookie.RestoreFileToCookieStorage()
		self.request!.allHTTPHeaderFields = SCCookie.GetRequestFiledByCookie(SCCookie.GetCookieArray())

		if !authenticated {
			authenticated = false
			urlConnection = NSURLConnection(request: self.request!, delegate: self)!
			urlConnection!.start()
			return false
		}
		return true
	}

	func connection(connection: NSURLConnection, willSendRequest request: NSURLRequest, redirectResponse response: NSURLResponse?) -> NSURLRequest? {
		log.debug("redirect \(request.URLString)")

		SCCookie.RestoreFileToCookieStorage()
		self.request!.allHTTPHeaderFields = SCCookie.GetRequestFiledByCookie(SCCookie.GetCookieArray())

		return self.request
	}

	func connection(connection: NSURLConnection, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
		log.debug("WebController Got auth challange via NSURLConnection")
		if challenge.previousFailureCount == 0 {
			authenticated = true
			let credential: NSURLCredential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
			challenge.sender!.useCredential(credential, forAuthenticationChallenge: challenge)
		}
		else {
			challenge.sender!.cancelAuthenticationChallenge(challenge)
		}
		challenge.sender!.continueWithoutCredentialForAuthenticationChallenge(challenge)
	}

	func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
		log.debug("WebController received response via NSURLConnection")

		authenticated = true
		urlConnection!.cancel()

		SCCookie.RestoreFileToCookieStorage()

		self.request!.allHTTPHeaderFields = SCCookie.GetRequestFiledByCookie(SCCookie.GetCookieArray())

		webView!.loadRequest(self.request!)
	}

	func webViewDidFinishLoad(webView: UIWebView) {
		log.debug("Did finish load")
		self.clearAllNotice()
	}
}