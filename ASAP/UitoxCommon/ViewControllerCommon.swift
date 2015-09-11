//
//  ViewControllerCommon.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/9/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

extension UIViewController {
	// MARK: - Action
	func searchButtonOnClicked(sender:UIBarButtonItem) {
		//		performSegueWithIdentifier("SearchPage", sender: self)
		let searchController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchResultViewController") as? SearchResultViewController
		self.navigationController?.pushViewController(searchController!, animated: false)
	}

}