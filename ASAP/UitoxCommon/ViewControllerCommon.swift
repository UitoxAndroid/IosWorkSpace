//
//  ViewControllerCommon.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/9/11.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import Foundation

@available(iOS 8.0, *)
extension UIViewController 
{ 
	// MARK: - Action

	//設定右邊BarItem為搜尋
	func setRightItemSearch() {
		let img = UIImage(named: "ic_search")
		let searchItem = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("searchButtonOnClicked:"))
		self.navigationItem.rightBarButtonItem = searchItem
	}

	//按下搜尋鈕引發的動作
	func searchButtonOnClicked(sender:UIBarButtonItem) {
		let searchController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchResultViewController") as? SearchResultViewController
		self.navigationController?.pushViewController(searchController!, animated: false)
	}
	
	//設定右邊BarItem為關閉
	func setRightItemClose() {
		let img = UIImage(named: "ic_close")
		let searchItem = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("closeButtonOnClicked:"))
		self.navigationItem.rightBarButtonItem = searchItem
	}
	
	//秀確認畫面
	func showAlert(message: String) {
		dispatch_async(dispatch_get_main_queue(), { () -> Void in
			let alert = UIAlertController(title: "警告", message: message, preferredStyle: UIAlertControllerStyle.Alert)
			let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
			alert.addAction(confirmAction)
			self.presentViewController(alert, animated: true, completion: nil)
		})
	}
	
	//顯示登入頁
	func showSignInViewController() -> SignInViewController? {
		let signInViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController")
		signInViewController?.modalPresentationStyle = .CurrentContext
		
		if let signInViewController = signInViewController as? SignInViewController {
			let nav = UINavigationController(rootViewController: signInViewController)	
			self.presentViewController(nav, animated: true, completion: nil)			
			return signInViewController
		}
		
		return nil
	}
	
	//加入購物車數字
	func addCartNumber() {
		let delegate = UIApplication.sharedApplication().delegate
		let myTabBarViewController = delegate!.window!!.rootViewController as? MyTabBarViewController
		if let myTabBarViewController = myTabBarViewController {
			myTabBarViewController.viewControllers![3].tabBarItem.badgeValue = String(MyApp.sharedShoppingCart.goodsList.count)
		}
	}
	
	//跳到購物流程頁
	func jumpToShoppingCartTab() {
		let delegate = UIApplication.sharedApplication().delegate
		let myTabBarViewController = delegate!.window!!.rootViewController as? MyTabBarViewController
		if let myTabBarViewController = myTabBarViewController {
			myTabBarViewController.selectedIndex = 3
		}
	}
	
	//推進到單品頁
	func pushToGoodsViewController(goodsPage: GoodsPageResponse?, cartAction: Int) {
		guard let goodsPage = goodsPage else {
			return
		}
		
		let goodsView = self.storyboard?.instantiateViewControllerWithIdentifier("GoodsTableViewController") as! GoodsTableViewController
		goodsView.goodsResponse = goodsPage
		goodsView.modalPresentationStyle = UIModalPresentationStyle.FullScreen
		goodsView.hidesBottomBarWhenPushed = true
		goodsView.cartAction = cartAction
		self.navigationController?.showViewController(goodsView, sender: self)

	}
	
	// MARK: - ProgressHUD
	
	func setupHUD() {
		SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
		SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
	}
	
	//秀忙碌圖
	func pleaseWait() {
		setupHUD()
		SVProgressHUD.show()
	}

	//清除忙碌圖
	func clearAllNotice() {
		SVProgressHUD.dismiss()
	}
	
	//秀忙碌圖加文字
	func showBusy(text: String!) {
		setupHUD()
		SVProgressHUD.showWithStatus(text)
	}
	
	//秀成功文字
	func showSuccess(text: String!) {
		setupHUD()
		SVProgressHUD.showSuccessWithStatus(text)
	}

	//秀錯誤文字
	func showError(text: String!) {
		setupHUD()
		SVProgressHUD.showErrorWithStatus(text)
	}
	
	//秀資訊文字
	func showInfo(text: String!) {
		setupHUD()
		SVProgressHUD.showInfoWithStatus(text)
	}

	
}