//
//  MenuViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/9/2.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController
{
	@IBOutlet weak var leftTableView: UITableView!
	@IBOutlet weak var helloMemberLabel: UILabel!
	@IBOutlet weak var signInButton: UIButton!

	lazy var categoryData:CategoryModel? = CategoryModel()
	lazy var menuData:MenuModel? = MenuModel()
	var leftMenuList:[DataInfo] = []
	var rightMenuList:[DataInfo] = []
	var rightTableView: SKSTableView!
	var contentView: UIView!
	var categoryView: PGCategoryView!
	let cellIdentifier = "Cell"
	let sKSCellIdentifier = "SKSTableViewCell"
	let subCellIdentifier = "SubCell"
	var twoAllMenuList = [Int: [DataInfo]]()

	
	// MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

		setupView()

		self.pleaseWait()
		
		getMenu("A14954") {
			(menu: MenuResponse?) in
			if let menu = menu {
				self.leftMenuList = menu.menuList
				self.leftTableView!.reloadData()
			}
			self.clearAllNotice()
		}

		setRightItemSearch()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true)
		updateSignStatus()		
	}
		
	func updateSignStatus() {
		if MyApp.sharedMember.encodeGuid != "" {
			let account = MyApp.sharedMember.email == "" ? MyApp.sharedMember.phone : MyApp.sharedMember.email
			helloMemberLabel.text = "hi, \(account)"
			signInButton.setTitle("登出", forState: UIControlState.Normal)
		} else {
			helloMemberLabel.text = ""
			signInButton.setTitle("登入", forState: UIControlState.Normal)
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

	// MARK: - Action
	
	@IBAction func signInButtonOnClicked(sender: UIButton) {
		if signInButton.titleLabel!.text == "登出" {
			self.showSuccess("登出成功!")
			MyApp.sharedMember.deleteMemberData()
			updateSignStatus()		
		} else {
			if let signInViewController = self.showSignInViewController() {
				signInViewController.delegate = self
			}
		}
	}
	
	
	
	// MARK: - Call Api

	func getMenu(siSeq: String, completionHandler: (menuResponse: MenuResponse?) -> Void) {
		self.pleaseWait()
		menuData?.getMenuData(siSeq) { (menu: MenuResponse?, errorMessage: String?) in
			self.clearAllNotice()
			if menu == nil {
				self.showError("資料有誤!")
			} else {
				completionHandler(menuResponse: menu)
			}
		}
	}

	func getCategory(siSeq: String, completionHandler: (categoryResponse: SearchListResponse?) -> Void) {
		self.showBusy("請稍候...")
		categoryData?.getCategoryData(siSeq, page: 1, sortBy: SortBy.SmSoldQty, desc: true) { (category: SearchListResponse?, errorMessage: String?) in
			self.clearAllNotice()
			if errorMessage != nil {
				self.showError("資料有誤!")
			} else {
				completionHandler(categoryResponse: category!)
			}
		}
	}	
}


// MARK: - UITableViewDataSource, UITableViewDelegate

extension MenuViewController: UITableViewDataSource, UITableViewDelegate
{
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
		
	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "全站商品分類"
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 36
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if tableView == leftTableView {
			var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
			
			if cell == nil {
				cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
			}
			
			cell?.textLabel!.text = self.leftMenuList[indexPath.row].name
			return cell!
		} else {
			//由於會記錄著上次的展開狀態，會影響別的Cell，所以都重新取新的
			let cell = SKSTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: sKSCellIdentifier)
			
			cell.textLabel!.text = self.rightMenuList[indexPath.row].name
			cell.sid = self.rightMenuList[indexPath.row].sid
			cell.tag = indexPath.row
			cell.level = 2
			cell.isExpandable = true
			
			return cell
		}
	}
		
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		if tableView == leftTableView {
			let selectedRowId = self.leftMenuList[indexPath.row].sid
			log.debug(selectedRowId)
			self.rightTableView.expandedIndexPaths.removeAllObjects()
			self.rightTableView.expandableCells.removeAllObjects()
			
			getMenu(selectedRowId!) {
				(menu: MenuResponse?) in
				
				if menu?.menuList == nil || menu?.menuList.count == 0 {
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
			
			if cell!.isExpanded == false && self.twoAllMenuList[cell!.tag] != nil { 
				self.twoAllMenuList.removeValueForKey(cell!.tag)
			}
			
			if cell!.level == 2 {
				getMenu(selectedRowId!) {
					(menu: MenuResponse?) in
					if let menu = menu {
						if menu.menuList.count != 0 {
							menu.menuList.insert(DataInfo()!, atIndex: 0)
							self.twoAllMenuList.updateValue(menu.menuList, forKey: cell!.tag)
							(tableView as! SKSTableView).doSubCell(tableView, didSelectRowAtIndexPath: indexPath)
							return
						}
					}
					
					self.pushToCategoryPage(selectedRowId!, menu: self.rightMenuList)
				}				
			} else {
				let list = cell!.nearMenuList as? [DataInfo]
				if let list = list {
					self.pushToCategoryPage(selectedRowId!, menu: list)
				}
			}
		}
	}
	
	//推進到館頁
	func pushToCategoryPage(sid:String, menu:[DataInfo]) {
		self.getCategory(sid) {
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


// MARK: - SKSTableViewDelegate

extension MenuViewController: SKSTableViewDelegate
{
	func tableView(tableView: SKSTableView!, numberOfSubRowsAtIndexPath indexPath: NSIndexPath!) -> Int {	
		if let list = self.twoAllMenuList[indexPath.row] {
			return list.count - 1
		}
		
		return 0
	}

	func tableView(tableView: SKSTableView!, cellForSubRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
		
		var cell = tableView.dequeueReusableCellWithIdentifier(subCellIdentifier) as? SKSTableViewCell
		
		if cell == nil {
			cell = SKSTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: subCellIdentifier)
		}
		
		log.debug("row:\(indexPath.row)")
		log.debug("subRow:\(indexPath.subRow)")
		
		
		
		guard let list = self.twoAllMenuList[indexPath.row] else {
			return cell!
		}
		
		let name = list[indexPath.subRow].name
		cell!.textLabel!.text = name
		cell!.sid = list[indexPath.subRow].sid
		cell!.level = 3
		cell!.nearMenuList = list
		cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
		
		return cell!
	}

}

// MARK: - SignInDelegate

extension MenuViewController: SignInDelegate
{
	func signInSuccess() {
		log.debug("signInSuccess")
		updateSignStatus()
	}
	
	func signInCancel() {
		log.debug("signInCancel")
	}
}

