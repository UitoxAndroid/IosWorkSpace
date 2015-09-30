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

		for (index, p) in relatedMenuList.enumerate() {
			let vc = self.storyboard?.instantiateViewControllerWithIdentifier("KindViewController") as! KindViewController
			vc.title = p.name
			

			if index == currentIndex {
				vc.searchListResponse = searchListResponse!
			}

			viewControllers.append(vc)
		}

		setupPagingMenu()

		self.clearAllNotice()

		if #available(iOS 8.0, *) {
		    setRightItemSearch()
		} else {
		    // Fallback on earlier versions
		}
    }

	func setupPagingMenu() {
		let options = PagingMenuOptions()

		//間隔距離
		options.menuItemMargin = 5
		//高度
		options.menuHeight = 50
		//設定顯示模式:FlexibleItemWidth、FixedItemWidth、SegmentedControl
		//設定捲軸模式:ScrollEnabled、ScrollEnabledAndBouces、PagingEnabled
		options.menuDisplayMode = PagingMenuOptions.MenuDisplayMode.Standard(widthMode: PagingMenuOptions.MenuItemWidthMode.Flexible, centerItem: false, scrollingMode: PagingMenuOptions.MenuScrollingMode.ScrollEnabled)
		//設定底線高度、顏色
		options.menuItemMode = PagingMenuOptions.MenuItemMode.Underline(height: 3, color: UIColor.redColor(), horizontalPadding: 0, verticalPadding: 0)
		//預設頁面
		options.defaultPage = currentIndex


		if #available(iOS 8.0, *) {
		    let pagingMenuController = self.childViewControllers.first as! PagingMenuController
			pagingMenuController.delegate = self
			pagingMenuController.setup(viewControllers: viewControllers, options: options)
		} else {
		    // Fallback on earlier versions
		}
	}

	// MARK: - PagingMenuControllerDelegate
	func willMoveToMenuPage(page: Int) {
		if page < 0 || page >= self.relatedMenuList.count {
			return
		}

	 	let vc = viewControllers[page] as? KindViewController
		if vc?.searchListResponse != nil {
			return
		}

		self.pleaseWait()

		let siSeq = self.relatedMenuList[page].sid
		print("name:\(self.relatedMenuList[page].name!)")

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
			self.clearAllNotice()
			if errorMessage != nil {
				if #available(iOS 8.0, *) {
				    self.showAlert(errorMessage!)
				} else {
				    // Fallback on earlier versions
				}
			} else {
				completionHandler(categoryResponse: category!)
			}
		}
	}

}
