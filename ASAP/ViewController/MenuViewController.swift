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
	var subCount:Int = 0
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

	// MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()


		setupView()

		self.pleaseWait()

		GetMenu("A14954") {
			(menu: MenuResponse?) in
			if let menu = menu {
				self.leftMenuList = menu.menuList
				self.leftTableView!.reloadData()
			}
			self.clearAllNotice()
		}

		if #available(iOS 8.0, *) {
		    setRightItemSearch()
		} else {
		    // Fallback on earlier versions
		}
	}

	func setupView() {
		let statusBarHeight:CGFloat = 20
		let loginBarHeight:CGFloat = 44
		let tabBarHeight:CGFloat = 44
		let kLeftViewWidth:CGFloat = 96

		contentView = UIView()
		contentView.frame = CGRect(x: self.view.bounds.size.width, y: statusBarHeight + tabBarHeight + loginBarHeight,
			width: self.view.bounds.size.width -  kLeftViewWidth, height: self.view.bounds.size.height - statusBarHeight - tabBarHeight - loginBarHeight)
		contentView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
//		contentView.backgroundColor = UIColor.redColor()
		self.view.addSubview(contentView)

		rightTableView = SKSTableView()
		rightTableView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.height - tabBarHeight)
		rightTableView.SKSTableViewDelegate = self
		rightTableView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
		rightTableView.tableFooterView = UIView()
		contentView.addSubview(rightTableView)

		var viewFrame = contentView.frame;
		viewFrame.origin.x -= 30
		viewFrame.size.width = 30;
		categoryView = PGCategoryView.categoryRightView(contentView)
		categoryView.frame = viewFrame
		self.view.addSubview(categoryView)
	}

	// MARK: - TableView
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
		if self.detailMenuList.count == 0 {
			return 0
		}
		return self.detailMenuList.count - 1
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

			var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)

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
			cell?.sid = self.rightMenuList[indexPath.row].sid
			cell?.tag = indexPath.row

//			if (self.contentList[indexPath.row].count > 1) {
//				cell?.isExpandable = true
//			} else {
//				cell?.isExpandable = false
//			}

			cell?.isExpandable = true


			return cell!
		}
	}

	func tableView(tableView: SKSTableView!, cellForSubRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {

		var cell: SKSTableViewCell? = tableView.dequeueReusableCellWithIdentifier(SubCellIdentifier) as? SKSTableViewCell

		if cell == nil {
			cell = SKSTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: SubCellIdentifier)
		}

		print("row:\(indexPath.row)")
		print("subRow:\(indexPath.subRow)")

//		var s = self.contentList[indexPath.row][indexPath.subRow]
		let name = self.detailMenuList[indexPath.subRow].name
		cell?.textLabel?.text = name
		cell?.sid = self.detailMenuList[indexPath.subRow].sid
		cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

		return cell!
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)

		if tableView == leftTableView {
			let selectedRowId = self.leftMenuList[indexPath.row].sid
			print(selectedRowId)
			GetMenu(selectedRowId!) {
				(menu: MenuResponse?) in

				if menu?.menuList == nil || menu?.menuList.count == 0 {
					if #available(iOS 8.0, *) {
					    self.showAlert("no data")
					} else {
					    // Fallback on earlier versions
					}
//					self.GetCategory(selectedRowId!) {
//						(categoryResponse: SearchListResponse?) in
//						let goodListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GoodListViewController") as? GoodsListViewController
//						goodListViewController?.searchListResponse = categoryResponse
//						goodListViewController!.relatedMenuList = self.leftMenuList
//						goodListViewController!.currentIndex = indexPath.row
//						self.navigationController?.pushViewController(goodListViewController!, animated: true)
//					}
				} else {
					self.rightMenuList = menu!.menuList
					self.rightTableView.reloadData()
					self.categoryView.show()
				}

			}

		} else {
			print("indexPath.row:\(indexPath.row)")
			let cell = tableView.cellForRowAtIndexPath(indexPath) as? SKSTableViewCell

			if cell == nil {
				return
			}

			let selectedRowId = cell!.sid
			print(selectedRowId)

			self.detailMenuList = [DataInfo]()

			GetMenu(selectedRowId!) {
				(menu: MenuResponse?) in
//				var menu:MenuResponse? = MenuResponse()
				if let menu = menu {

//					if (indexPath.row == 1 || indexPath.row == 2) {
//						menu.menuList = [DataInfo]()
//						let d1 = DataInfo()
//						d1.name = "假資料1"
//						menu.menuList.append(d1)
//						let d2 = DataInfo()
//						d2.name = "假資料2"
//						menu.menuList.append(d2)
//						let d3 = DataInfo()
//						d3.name = "假資料3"
//						menu.menuList.append(d3)
//					}

					if menu.menuList.count != 0 {
						menu.menuList.insert(DataInfo()!, atIndex: 0)
						self.detailMenuList = menu.menuList
						(tableView as! SKSTableView).doSubCell(tableView, didSelectRowAtIndexPath: indexPath)
						return
					}
				}

				self.GetCategory(selectedRowId!) {
					(categoryResponse: SearchListResponse?) in
					let goodListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GoodListViewController") as? GoodsListViewController
					goodListViewController?.searchListResponse = categoryResponse
					goodListViewController!.relatedMenuList = self.rightMenuList
					goodListViewController!.currentIndex = cell!.tag
					self.navigationController?.pushViewController(goodListViewController!, animated: true)
				}
			}
		}
	}

	// MARK: - Call Api

	func GetMenu( siSeq: String, completionHandler: (menuResponse: MenuResponse?) -> Void) {
		self.pleaseWait()
		menuData?.getMenuData(siSeq) { (menu: MenuResponse?, errorMessage: String?) in
			self.clearAllNotice()
			if menu == nil {
				if #available(iOS 8.0, *) {
				    self.showAlert(errorMessage!)
				} else {
				    // Fallback on earlier versions
				}
			} else {
				completionHandler(menuResponse: menu)
			}
		}
	}

	func GetCategory( siSeq: String, completionHandler: (categoryResponse: SearchListResponse?) -> Void) {
		self.pleaseWait()
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
