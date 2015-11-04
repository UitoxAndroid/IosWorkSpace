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
	override func viewDidLoad() {
		super.viewDidLoad()
		self.delegate = self
		self.addCartNumber()
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


