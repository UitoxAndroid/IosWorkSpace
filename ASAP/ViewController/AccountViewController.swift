//
//  AccountViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/9/18.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController
{
	@IBOutlet weak var webView: UIWebView!
	var authenticated:Bool = false
	var urlConnection:NSURLConnection?
	var request:NSMutableURLRequest?
	let loginUrl = NSURL(string: DomainPath.MemberTw1.rawValue + "/maccount/app_login")!
	let memberUrl = NSURL(string: DomainPath.MemberTw1.rawValue + "/account/home")!

	override func viewDidLoad() {
        super.viewDidLoad()
			
		if MyApp.sharedMember.guid != "" {
			signInSuccess()
		}
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true)
	}
}

extension String 
{
	/// Percent escape value to be added to a URL query value as specified in RFC 3986
	///
	/// This percent-escapes all characters besize the alphanumeric character set and "-", ".", "_", and "~".
	///
	/// http://www.ietf.org/rfc/rfc3986.txt
	///
	/// :returns: Return precent escaped string.
	func stringByAddingPercentEncodingForURLQueryValue() -> String? {
		let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
		characterSet.addCharactersInString("-._~")
		
		return self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
	}
	
}

extension Dictionary 
{	
	/// Build string representation of HTTP parameter dictionary of keys and objects
	///
	/// This percent escapes in compliance with RFC 3986
	///
	/// http://www.ietf.org/rfc/rfc3986.txt
	///
	/// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
	func stringFromHttpParameters() -> String {
		let parameterArray = self.map { (key, value) -> String in
			let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
			let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
			return "\(percentEscapedKey)=\(percentEscapedValue)"
		}
		
		return parameterArray.joinWithSeparator("&")
	}	
}


// MARK: - SignInDelegate

extension AccountViewController: SignInDelegate
{
	func signInSuccess() {
		log.debug("signInSuccess")
		
		self.request = NSMutableURLRequest(URL: loginUrl)
		self.request!.HTTPMethod = "POST"
		
		let parameters = ["encode":MyApp.sharedMember.encodeGuid, "ws_seq": "AW000001"]
		let parameterString = parameters.stringFromHttpParameters()
		let data = parameterString.dataUsingEncoding(NSUTF8StringEncoding)
		
		self.request!.HTTPBody = data	
		
		self.pleaseWait()
		self.webView.loadRequest(self.request!)
	}
	
	func signInCancel() {
		log.debug("signInCancel")
	}
}


// MARK: - UIWebViewDelegate

extension AccountViewController: UIWebViewDelegate 
{	
	func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		log.debug("Did start loading: \(request.URL!.absoluteString)")
				
		if !authenticated {
			authenticated = false
			urlConnection = NSURLConnection(request: self.request!, delegate: self)!
			urlConnection!.start()
			return false
		}
		return true
	}
	
	func webViewDidFinishLoad(webView: UIWebView) {
		log.debug("Did finish load")
		self.clearAllNotice()
	}
}


// MARK: - NSURLConnectionDataDelegate

extension AccountViewController: NSURLConnectionDataDelegate
{
	func connection(connection: NSURLConnection, willSendRequest request: NSURLRequest, redirectResponse response: NSURLResponse?) -> NSURLRequest? {
		log.debug("redirect \(request.URLString)")
				
		//登入後會轉導這個網址，必須載到webVeiew
		if request.URLString == memberUrl.URLString {
			authenticated = true
			urlConnection!.cancel()
			webView.loadRequest(self.request!)			
		}
		
		return self.request
	}
	
	//有https驗證時會跑進來
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
	
	//收到response時，目前好像不會跑進來，所以改在willSendRequest方法處理
	func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
		log.debug("WebController received response via NSURLConnection")
		
		authenticated = true
		urlConnection!.cancel()
				
		webView.loadRequest(self.request!)
	}
}
