//
//  AppDelegate.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/13.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit
import RealmSwift

//記錄log
let log: XCGLogger = {
	// Setup XCGLogger
	let log = XCGLogger.defaultInstance()
	log.xcodeColorsEnabled = false // Or set the XcodeColors environment variable in your scheme to YES
	log.xcodeColors = [
		.Verbose: .lightGrey,
		.Debug: .darkGrey,
		.Info: .darkGreen,
		.Warning: .orange,
		.Error: XCGLogger.XcodeColor(fg: UIColor.redColor(), bg: UIColor.whiteColor()), // Optionally use a UIColor
		.Severe: XCGLogger.XcodeColor(fg: (255, 255, 255), bg: (255, 0, 0)) // Optionally use RGB values directly
	]
	
	#if DEBUG // Set via Build Settings, under Other Swift Flags
		log.setup(.Info, showThreadName: false, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil)
	#else
		log.setup(.Verbose, showThreadName: false, showLogLevel: false, showFileNames: false, showLineNumbers: false, writeToFile: nil)		
	#endif
	
	return log
}()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.

//		UITabBar.appearance().barTintColor = UIColor.blackColor()
		//		UITabBar.appearance().tintColor = UIColor.whiteColor()
//		UINavigationBar.appearance().barTintColor = UIColor.brownColor()
//		UINavigationBar.appearance().tintColor = UIColor.whiteColor()
//		UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

		
		do {
			try NSFileManager.defaultManager().removeItemAtPath(Realm.Configuration.defaultConfiguration.path!)
		} catch {}

		return true
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		NSHTTPCookieStorage.sharedHTTPCookieStorage().cookieAcceptPolicy = NSHTTPCookieAcceptPolicy.Always
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

}

// MARK - Login

extension AppDelegate
{
	func login(account: String, passwd: String) {
		let myTabBarViewController = self.window!.rootViewController as? MyTabBarViewController
		if let myTabBarViewController = myTabBarViewController {
			myTabBarViewController.login("shengeih@gmail.com", passwd: "123456")
		}
	}
	
	func showLogin() {
		let myTabBarViewController = self.window!.rootViewController as? MyTabBarViewController
		if let myTabBarViewController = myTabBarViewController {
			let loginViewController = myTabBarViewController.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController")
			myTabBarViewController.presentViewController(loginViewController!, animated: true, completion: { () -> Void in
				
			})
		}

	}
}

