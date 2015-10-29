//
//  MyTabBarViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/26.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class MyTabBarViewController: UITabBarController
{
	var webView:UIWebView!
	var urlConnection:NSURLConnection?
	var request:NSMutableURLRequest?
	var authenticated:Bool = false
	let loginUrl = NSURL(string: DomainPath.MemberTw1.rawValue + "/maccount/app_login")!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.delegate = self
		self.webView = UIWebView(frame: self.view.bounds)
		self.webView.delegate = self
	}

	func login(account:String, passwd:String) {
		SCCookie.DeleteCookies()
		self.request = NSMutableURLRequest(URL: loginUrl, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: 10.0)
		self.request!.HTTPMethod = "POST"
		self.request!.setValue("asap", forHTTPHeaderField: "User-agent")
		self.request!.setValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
		let params = "account=\(account)&passwd=\(passwd)"
		self.request!.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
		webView.loadRequest(self.request!)
	}
}


// MARK - UITabBarControllerDelegate

extension MyTabBarViewController: UITabBarControllerDelegate 
{
	func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
		// 點選到帳戶頁籤
		if self.selectedIndex == 2 {
			if let accountViewController = viewController.childViewControllers[0] as? AccountViewController {
				if MyApp.sharedMember.guid == "" {
					if let signInViewController = self.showSignInViewController() {
						signInViewController.delegate = accountViewController
					}
				}
			}
		}
	}

}

// MARK - UIWebViewDelegate 

extension MyTabBarViewController: UIWebViewDelegate
{
	func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		log.debug("Did start loading: \(request.URL!.absoluteString)")

//		SCCookie.RestoreFileToCookieStorage()
//		self.request!.allHTTPHeaderFields = SCCookie.GetRequestFiledByCookie(SCCookie.GetCookieArray())

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
		webView!.loadRequest(self.request!)
	}

	func webViewDidFinishLoad(webView: UIWebView) {
		log.debug("Did finish load")
		SCCookie.SaveCookiesToFile()
		
	}	

}

