//
//  MenuViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/9/2.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,SKSTableViewDelegate
{
	@IBOutlet weak var leftTableView: UITableView!

	lazy var categoryData:CategoryModel? = CategoryModel()
	lazy var menuData:MenuModel? = MenuModel()
	var leftMenuList:[DataInfo] = []
	var rightMenuList:[DataInfo] = []
	var detailMenuList:[DataInfo] = []
	var rightTableView: SKSTableView!
	var contentView: UIView!
	var categoryView: PGCategoryView!
	let CellIdentifier = "Cell"
	let SKSCellIdentifier = "SKSTableViewCell"
	let SubCellIdentifier = "SubCell"
	var _contentList:[[String]] = []
	var contentList: [[String]] {
		if _contentList.count == 0 {

			_contentList.append(["Section0_Row0", "Row0_Subrow1","Row0_Subrow2"])
			_contentList.append(["Section0_Row1", "Row1_Subrow1", "Row1_Subrow2", "Row1_Subrow3", "Row1_Subrow4", "Row1_Subrow5", "Row1_Subrow6", "Row1_Subrow7", "Row1_Subrow8", "Row1_Subrow9", "Row1_Subrow10", "Row1_Subrow11", "Row1_Subrow12"])
			_contentList.append(["Section0_Row2"])
			_contentList.append(["Section1_Row0", "Row0_Subrow1", "Row0_Subrow2", "Row0_Subrow3"])
			_contentList.append(["Section1_Row1"])
			_contentList.append(["Section1_Row2", "Row2_Subrow1", "Row2_Subrow2", "Row2_Subrow3", "Row2_Subrow4", "Row2_Subrow5"])
		}

		return _contentList
	}


    override func viewDidLoad() {
        super.viewDidLoad()

		let statusBarHeight:CGFloat = 20
		let loginBarHeight:CGFloat = 54
		let tabBarHeight:CGFloat = 44
		let kLeftViewWidth:CGFloat = 96

		contentView = UIView()
		contentView.frame = CGRect(x: self.view.bounds.size.width, y: statusBarHeight + tabBarHeight + loginBarHeight,
			width: self.view.bounds.size.width -  kLeftViewWidth, height: self.view.bounds.size.height - statusBarHeight - tabBarHeight - loginBarHeight)
		contentView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
		contentView.backgroundColor = UIColor.redColor()
		self.view.addSubview(contentView)

		rightTableView = SKSTableView()
		rightTableView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.height - tabBarHeight)
		rightTableView.SKSTableViewDelegate = self
		rightTableView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
		rightTableView.tableFooterView = UIView()
		contentView.addSubview(rightTableView)

		var viewFrame = contentView.frame;
		viewFrame.origin.x -= 30
		viewFrame.size.width = 30;
		categoryView = PGCategoryView.categoryRightView(contentView)
		categoryView.frame = viewFrame
		self.view.addSubview(categoryView)

		self.pleaseWait()

		GetMenu("A14954") {
			(menu: MenuResponse?) in
			if let menu = menu {
				self.leftMenuList = menu.menuList
				self.leftTableView!.reloadData()
			}
			self.clearAllNotice()
		}

		var searchItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: Selector("searchButtonOnClicked:"))
		self.navigationItem.rightBarButtonItem = searchItem
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		if tableView == leftTableView {
			return 1
		} else {
			return 1
		}
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == leftTableView {
			return self.leftMenuList.count
		} else {
			return self.rightMenuList.count
//			return self.contentList.count
		}
	}

	func tableView(tableView: SKSTableView!, numberOfSubRowsAtIndexPath indexPath: NSIndexPath!) -> Int {
		return self.detailMenuList.count
//		return self.contentList[indexPath.row].count - 1
	}

	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "全站商品分類"
	}

	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 36
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if tableView == leftTableView {

			var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell

			if cell == nil {
				cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
			}

			cell?.textLabel!.text = self.leftMenuList[indexPath.row].name
			return cell!
		} else {
			var cell: SKSTableViewCell? = tableView.dequeueReusableCellWithIdentifier(SKSCellIdentifier) as? SKSTableViewCell

			if cell == nil {
				cell = SKSTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: SKSCellIdentifier)
			}

//			cell?.textLabel!.text = self.contentList[indexPath.row][0]
			cell?.textLabel!.text = self.rightMenuList[indexPath.row].name

//			if (self.contentList[indexPath.row].count > 1) {
//				cell?.isExpandable = true
//			} else {
//				cell?.isExpandable = false
//			}

			cell?.isExpandable = false


			return cell!
		}
	}

	func tableView(tableView: SKSTableView!, cellForSubRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {

		var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(SubCellIdentifier) as? UITableViewCell

		if cell == nil {
			cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: SubCellIdentifier)
		}

		println("row:\(indexPath.row)")
		println("subRow:\(indexPath.subRow)")

//		var s = self.contentList[indexPath.row][indexPath.subRow]
		var s = self.detailMenuList[indexPath.row]
		cell?.textLabel?.text = "\(s)"
		cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

		return cell!
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)

		if tableView == leftTableView {
			let selectedRowId = self.leftMenuList[indexPath.row].sid
			println(selectedRowId)
			GetMenu(selectedRowId!) {
				(menu: MenuResponse?) in
					self.rightMenuList = menu!.menuList
					self.rightTableView.reloadData()
					self.categoryView.show()
			}

		} else {
			let selectedRowId = self.rightMenuList[indexPath.row].sid
			println(selectedRowId)

			self.pleaseWait()

			GetMenu(selectedRowId!) {
				(menu: MenuResponse?) in
				if let menu = menu {
					if menu.menuList.count != 0 {
						self.detailMenuList = menu.menuList
						return
					}
				}

				self.GetCategory(selectedRowId!) {
					(categoryResponse: SearchListResponse?) in
					let goodListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GoodListViewController") as? GoodsListViewController
					goodListViewController?.searchListResponse = categoryResponse
					goodListViewController!.relatedMenuList = self.rightMenuList
					goodListViewController!.currentIndex = indexPath.row
					self.navigationController?.pushViewController(goodListViewController!, animated: true)
				}
			}




		}
	}


	func GetMenu( siSeq: String, completionHandler: (menuResponse: MenuResponse?) -> Void) {
		menuData?.getMenuData(siSeq) { (menu: MenuResponse?, errorMessage: String?) in
			if menu == nil {
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					let alert = UIAlertController(title: "警告", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
					let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
					alert.addAction(confirmAction)
					self.presentViewController(alert, animated: true, completion: nil)
				})
			} else {
				self.menuData!.menu = menu!
				println("statusCode:\(menu!.status_code)")

				if let mnuList = menu?.menuList{
					for goodsdata in mnuList {
						println("SID:\(goodsdata.sid)")
						println("NAME:\(goodsdata.name)")
						println("LINK:\(goodsdata.link)")
						println("TYPE:\(goodsdata.type)")
						println("SI_TYPR:\(goodsdata.siType)")
					}
				}

				completionHandler(menuResponse: menu)
			}
		}
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
