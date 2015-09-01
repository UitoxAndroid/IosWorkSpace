//
//  GoodsListViewController.swift
//  UitoxSample1
//
//  Created by uitox_macbook on 2015/8/28.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class GoodsListViewController: UIViewController, PagingMenuControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

		let usersViewController = self.storyboard?.instantiateViewControllerWithIdentifier("UsersViewController") as! UsersViewController
		let repositoriesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RepositoriesViewController") as! RepositoriesViewController
		let gistsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GistsViewController") as! GistsViewController
		let organizationsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrganizationsViewController") as! OrganizationsViewController

		let test1Controller = UIViewController()
		test1Controller.title = "test1Controller"
		let test2Controller = UIViewController()
		test2Controller.title = "test2Controller"

		let kindViewController = self.storyboard?.instantiateViewControllerWithIdentifier("KindViewController") as! KindViewController
		kindViewController.title = "Life"

		let viewControllers = [kindViewController, usersViewController, repositoriesViewController, gistsViewController, organizationsViewController, test1Controller, test2Controller]

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


		let pagingMenuController = self.childViewControllers.first as! PagingMenuController
		pagingMenuController.delegate = self
		pagingMenuController.setup(viewControllers: viewControllers, options: options)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
