//
//  GoodsListViewController.swift
//  UitoxSample1
//
//  Created by uitox_macbook on 2015/8/28.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class GoodsListViewController: UIViewController, PagingMenuControllerDelegate
{
	var searchListResponse: SearchListResponse?
	var relatedMenuList:[DataInfo] = []
	var currentIndex:Int = 0
	var viewControllers = [UIViewController]()
	lazy var categoryData:CategoryModel? = CategoryModel()


    override func viewDidLoad() {
        super.viewDidLoad()

		for (index, p) in enumerate(relatedMenuList) {
			let vc = self.storyboard?.instantiateViewControllerWithIdentifier("KindViewController") as! KindViewController
			vc.title = p.name

			if index == currentIndex {
				vc.searchListResponse = searchListResponse!
			}

			viewControllers.append(vc)
		}



//		let usersViewController = self.storyboard?.instantiateViewControllerWithIdentifier("UsersViewController") as! UsersViewController
//		let repositoriesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RepositoriesViewController") as! RepositoriesViewController
//		let gistsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GistsViewController") as! GistsViewController
//		let organizationsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrganizationsViewController") as! OrganizationsViewController
//
//		let test1Controller = UIViewController()
//		test1Controller.title = "test1Controller"
//		let test2Controller = UIViewController()
//		test2Controller.title = "test2Controller"
//
//		let viewControllers = [kindViewController, usersViewController, repositoriesViewController, gistsViewController, organizationsViewController, test1Controller, test2Controller]



		let options = PagingMenuOptions()

		//間隔距離
		options.menuItemMargin = 5
		//高度
		options.menuHeight = 50
		//設定顯示模式:FlexibleItemWidth、FixedItemWidth、SegmentedControl
		//設定捲軸模式:ScrollEnabled、ScrollEnabledAndBouces、PagingEnabled
		options.menuDisplayMode = PagingMenuOptions.MenuDisplayMode.FlexibleItemWidth(centerItem: false, scrollingMode: PagingMenuOptions.MenuScrollingMode.ScrollEnabled)
		//設定底線高度、顏色
		options.menuItemMode = PagingMenuOptions.MenuItemMode.Underline(height: 3, color: UIColor.redColor())
		//預設頁面
		options.defaultPage = currentIndex


		let pagingMenuController = self.childViewControllers.first as! PagingMenuController
		pagingMenuController.delegate = self
		pagingMenuController.setup(viewControllers: viewControllers, options: options)

		self.clearAllNotice()

		var searchItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: Selector("searchButtonOnClicked:"))
		self.navigationItem.rightBarButtonItem = searchItem
    }

	func willMoveToMenuPage(page: Int) {
		if page < 0 || page >= self.relatedMenuList.count {
			return
		}

	 	var vc = viewControllers[page] as? KindViewController
		if vc?.searchListResponse != nil {
			return
		}
		
		let siSeq = self.relatedMenuList[page].sid
		println("name:\(self.relatedMenuList[page].name)")

		self.GetCategory(siSeq!) {
			(categoryResponse: SearchListResponse?) in
			vc?.searchListResponse = categoryResponse
			vc?.tableView.reloadData()
		}

	}

	func didMoveToMenuPage(page: Int) {

	}

	func GetCategory( siSeq: String, completionHandler: (categoryResponse: SearchListResponse?) -> Void) {
		categoryData?.getCategoryData(siSeq) { (category: SearchListResponse?, errorMessage: String?) in
			if category == nil {
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					let alert = UIAlertController(title: "警告", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
					let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
					alert.addAction(confirmAction)
					self.presentViewController(alert, animated: true, completion: nil)
				})
			} else {
				self.categoryData!.category = category!
				println("statusCode:\(category!.statusCode)")
				println("total:\(category!.total)")


				completionHandler(categoryResponse: category!)

			}
		}
	}

}
