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

	// MARK: - View
	
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

		setupPagingMenu()

		self.clearAllNotice()

		var searchItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: Selector("searchButtonOnClicked:"))
		self.navigationItem.rightBarButtonItem = searchItem
    }

	func setupPagingMenu() {
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
	}

	// MARK: - PagingMenuControllerDelegate
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

	// MARK - Call Api
	func GetCategory( siSeq: String, completionHandler: (categoryResponse: SearchListResponse?) -> Void) {
		categoryData?.getCategoryData(siSeq) { (category: SearchListResponse?, errorMessage: String?) in
			if category == nil {
				self.showAlert(errorMessage!)
			} else {
				completionHandler(categoryResponse: category!)
			}
		}
	}

}
