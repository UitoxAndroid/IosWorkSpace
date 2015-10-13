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

		setRightItemSearch()
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

	
	// MARK: - UITableViewDataSource
	
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
		}
	}

	func tableView(tableView: SKSTableView!, numberOfSubRowsAtIndexPath indexPath: NSIndexPath!) -> Int {
		if self.detailMenuList.count == 0 {
			return 0
		}
		return self.detailMenuList.count - 1
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
			//由於會記錄著上次的展開狀態，會影響別的Cell，所以都重新取新的
			let cell = SKSTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: SKSCellIdentifier)

			cell.textLabel!.text = self.rightMenuList[indexPath.row].name
			cell.sid = self.rightMenuList[indexPath.row].sid
			cell.tag = indexPath.row

			cell.isExpandable = true

			return cell
		}
	}

	func tableView(tableView: SKSTableView!, cellForSubRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {

		var cell: SKSTableViewCell? = tableView.dequeueReusableCellWithIdentifier(SubCellIdentifier) as? SKSTableViewCell

		if cell == nil {
			cell = SKSTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: SubCellIdentifier)
		}

		log.debug("row:\(indexPath.row)")
		log.debug("subRow:\(indexPath.subRow)")

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
			log.debug(selectedRowId)
			self.rightTableView.expandedIndexPaths.removeAllObjects()
			self.rightTableView.expandableCells.removeAllObjects()
			
			GetMenu(selectedRowId!) {
				(menu: MenuResponse?) in

				if menu?.menuList == nil || menu?.menuList.count == 0 {
//					self.GetCategory(selectedRowId!) {
//						(categoryResponse: SearchListResponse?) in
//						let goodListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GoodListViewController") as? GoodsListViewController
//						goodListViewController?.searchListResponse = categoryResponse
//						let filterMenu = self.filterCategory(self.leftMenuList)
//						goodListViewController!.relatedMenuList = filterMenu
//						goodListViewController!.currentIndex = indexPath.row
//						self.navigationController?.pushViewController(goodListViewController!, animated: true)
//					}
					self.pushToCategoryPage(selectedRowId!, menu: self.leftMenuList)
				} else {
					self.rightMenuList = menu!.menuList
					self.rightTableView.reloadData()
					self.categoryView.show()
				}

			}

		} else {
			let cell = tableView.cellForRowAtIndexPath(indexPath) as? SKSTableViewCell

			if cell == nil {
				return
			}

			let selectedRowId = cell!.sid
			log.debug("sid:\(selectedRowId)")
			
			//已展開情況下，只要合起來即可
			if cell!.isExpanded == true {
				return
			}

			self.detailMenuList = [DataInfo]()

			GetMenu(selectedRowId!) {
				(menu: MenuResponse?) in
				if let menu = menu {
					if menu.menuList.count != 0 {
						menu.menuList.insert(DataInfo()!, atIndex: 0)
						self.detailMenuList = menu.menuList
						(tableView as! SKSTableView).doSubCell(tableView, didSelectRowAtIndexPath: indexPath)
						return
					}
				}

//				self.GetCategory(selectedRowId!) {
//					(categoryResponse: SearchListResponse?) in
//					let goodListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GoodListViewController") as? GoodsListViewController
//					goodListViewController?.searchListResponse = categoryResponse
//					goodListViewController!.relatedMenuList = self.rightMenuList
//					goodListViewController!.currentIndex = cell!.tag
//					self.navigationController?.pushViewController(goodListViewController!, animated: true)
//				}
				self.pushToCategoryPage(selectedRowId!, menu: self.rightMenuList)
			}
		}
	}

	func pushToCategoryPage(sid:String, menu:[DataInfo]) {
		self.GetCategory(sid) {
			(categoryResponse: SearchListResponse?) in
			let goodListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GoodListViewController") as? GoodsListViewController
			goodListViewController?.searchListResponse = categoryResponse
			let filterMenu = self.filterCategory(menu)
			goodListViewController!.relatedMenuList = filterMenu
			let currentIndexRow = self.getCurrentIndex(filterMenu, sid: sid)
			goodListViewController!.currentIndex = currentIndexRow
			self.navigationController?.pushViewController(goodListViewController!, animated: true)
		}

	}
	
	// MARK: - Call Api

	func GetMenu( siSeq: String, completionHandler: (menuResponse: MenuResponse?) -> Void) {
		self.pleaseWait()
		menuData?.getMenuData(siSeq) { (menu: MenuResponse?, errorMessage: String?) in
			self.clearAllNotice()
			if menu == nil {
				self.showAlert(errorMessage!)
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
				self.showAlert(errorMessage!)
			} else {
				completionHandler(categoryResponse: category!)
			}
		}
	}

	
	// MARK: - 導到館頁之前
	
	//過濾只有館分類的選單
	func filterCategory(allMenu: [DataInfo]) -> [DataInfo] {
		var filterMenu = [DataInfo]()
		for info in allMenu {
			if let type = info.type {
				if type == "category" {
					filterMenu.append(info)
				}
			}
		}
		
		return filterMenu
	}

	//取得過濾之後，點選的索引
	func getCurrentIndex(menu:[DataInfo], sid:String) -> Int {
		var i = 0
		for info in menu {
			if info.sid! == sid {
				return i
			}
			i++
		}
		return i
	}
}
