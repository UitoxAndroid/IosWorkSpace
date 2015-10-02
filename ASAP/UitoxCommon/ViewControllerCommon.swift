//
//  ViewControllerCommon.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/9/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

@available(iOS 8.0, *)
extension UIViewController {
	// MARK: - Action
	func searchButtonOnClicked(sender:UIBarButtonItem) {
		//		performSegueWithIdentifier("SearchPage", sender: self)
		let searchController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchResultViewController") as? SearchResultViewController
		self.navigationController?.pushViewController(searchController!, animated: false)
	}

	func showAlert( message: String) {
		dispatch_async(dispatch_get_main_queue(), { () -> Void in
			let alert = UIAlertController(title: "警告", message: message, preferredStyle: UIAlertControllerStyle.Alert)
			let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
			alert.addAction(confirmAction)
			self.presentViewController(alert, animated: true, completion: nil)
		})
	}

	func setRightItemSearch() {
//		var searchItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: Selector("searchButtonOnClicked:"))
		let img = UIImage(named: "ic_search")
		let searchItem = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("searchButtonOnClicked:"))
		self.navigationItem.rightBarButtonItem = searchItem

	}
}