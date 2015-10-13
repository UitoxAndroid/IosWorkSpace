//
//  GoodsTableTableViewController.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/4.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit


class GoodsTableViewController: UITableViewController 
{
    
    var moreToBuyGoods = ["iphone6s","Sony Z5","nexus 6","One M9","Sony Xpria C5","Asus ZenPhone2"]
    
    lazy var goodsPageModel:GoodsPageModel? = GoodsPageModel()
    var goodsInfo:GoodsPageItemInfo? = nil
    //是否要展開加購商品 Bool
    var isOpenMoroToBuyCell:Bool = false
    
    //點擊展開按鈕來展開加購商品
    @IBAction func btnOpenCellClick(sender: UIButton) {
        isOpenMoroToBuyCell = true
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }
    
    // MARK: -View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getGoodsPageData()
    }
    
    
    // MARK: -設定tableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch(section){
        case 0:
            return 6
        case 1:
            return moreToBuyGoods.count
        case 2:
            return 2
        case 3:
            return 3
        default :
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch(indexPath.section){
        case 0:
            switch(indexPath.row){
            case 0:
                return 350  //Banner
            case 1:
                return 50   //規格
            case 2:
                return 100  //活動
            case 3:
                return 80   //預購
            case 4:
                return 120  //說明
            case 5:
                return 35   //加購商品Title
            default:
                return 70
            }
        case 1:
            //加購商品
            if(indexPath.row > 1 && isOpenMoroToBuyCell == true){
                return 70
            }else if(indexPath.row > 1 && isOpenMoroToBuyCell == false) {
                return 0
            }else{
                return 70
            }
        case 2:
            //展開列
            if(indexPath.row == 0){
                if(isOpenMoroToBuyCell == true){
                    return 0
                }else{
                    return 40
                }
            }else{
                return 226      //相關商品
            }
        case 3:
            return 300      //TabCell
        default:
            return 200
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if(section == 3)
        {
            let headerCell = tableView.dequeueReusableCellWithIdentifier("SectionHeaderCell") as! SectionHeaderCell
            print("Created SectionHeaderCell.....")
            return headerCell
        }else{
            let headerCell = tableView.dequeueReusableCellWithIdentifier("SectionHeaderCell") as! SectionHeaderCell
            headerCell.hidden = true
            return headerCell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //自動消除選取時該列時會以灰色來顯示的效果
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        switch(indexPath.section){
        case 0:
            switch(indexPath.row){
            case 0: //圖片&品名&售價
                let bannerCell = tableView.dequeueReusableCellWithIdentifier("BannerCell", forIndexPath: indexPath) as! BannerCell
                bannerCell.lblGoodsName.text = self.goodsInfo?.SmName
                bannerCell.imageList = self.goodsInfo?.SmPicMulti
                bannerCell.lblPriceNow.text = "$1000"
                bannerCell.lblPriceOrigin.text = "$5000"
                bannerCell.ImageBannerSetting()
                return bannerCell
            case 1://規格
                let specificationCell = tableView.dequeueReusableCellWithIdentifier("SpecificationCell", forIndexPath: indexPath) as! SpecificationCell
                return specificationCell
            case 2://活動
                let activityCell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as! ActivityCell
                activityCell.lblActTime.text = "a~B"
                activityCell.lblGoodPrice.text = "$1234"
                return activityCell
            case 3://預購倒數
                let preorderCell = tableView.dequeueReusableCellWithIdentifier("PreorderCell", forIndexPath: indexPath) as! PreorderCell
                preorderCell.lblPreorderDeadline.text = self.goodsInfo?.PreDtE
                return preorderCell
            case 4://說明
                let directionCell = tableView.dequeueReusableCellWithIdentifier("DirectionCell", forIndexPath: indexPath) as! DirectionCell
                directionCell.lblDesc.text = "會員限購\(self.goodsInfo?.SsmLimitQty)個"
                directionCell.lblOutDay.text = self.goodsInfo?.RefEtdDt
                directionCell.lblLeftCount.text = self.goodsInfo?.PreAvaQty
                return directionCell
            case 5://加購Title
                let moreToBuyTitleCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyTitleCell", forIndexPath: indexPath) as! MoreToBuyTitleCell
                return moreToBuyTitleCell
            default:
                let moreToBuyCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyCell", forIndexPath: indexPath) as! MoreToBuyCell
                return moreToBuyCell
            }
        case 1://加購商品
            let moreToBuyCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyCell", forIndexPath: indexPath) as! MoreToBuyCell
            moreToBuyCell.lblName.text = moreToBuyGoods[indexPath.row]
            if(indexPath.row > 1 && isOpenMoroToBuyCell == true){
                moreToBuyCell.hidden = false
            }else if(indexPath.row > 1 && isOpenMoroToBuyCell == false){
                moreToBuyCell.hidden = true
            }
            return moreToBuyCell
        case 2:
            switch(indexPath.row){
            case 0://加購商品展開按鈕
                let buttonInCell = tableView.dequeueReusableCellWithIdentifier("ButtonInCell", forIndexPath: indexPath) as! ButtonInCell
                if(isOpenMoroToBuyCell == true){
                    buttonInCell.hidden = true
                }
                return buttonInCell
            case 1://相關商品
                let relationGoodsCell = tableView.dequeueReusableCellWithIdentifier("RelationViewCell", forIndexPath: indexPath) as! RelationViewCell
                return relationGoodsCell
            default:
                let buttonInCell = tableView.dequeueReusableCellWithIdentifier("ButtonInCell", forIndexPath: indexPath) as! ButtonInCell
                return buttonInCell
            }
        case 3://說明,規格,保固
            let footerCell = tableView.dequeueReusableCellWithIdentifier("FooterCell", forIndexPath: indexPath) as! FooterCell
            
            print("cellIndex \(indexPath)")
            print("y = \(footerCell.frame.origin.y)")
            print("x = \(footerCell.frame.origin.x)")
            
            SectionHeaderCell().OnTableViewScrolling(AnimateBarXPosition: 20.0)
            return footerCell
        default:
            let moreToBuyCell = tableView.dequeueReusableCellWithIdentifier("MoreToBuyCell", forIndexPath: indexPath) as! MoreToBuyCell
            return moreToBuyCell
        }
    }
    
    
    // MARK: -呼叫api
    
    func getGoodsPageData()
    {
        goodsPageModel?.getGoodsPageData({ (goodsPage: GoodsPageResponse?, errorMessage:String?) -> Void in
            if (goodsPage == nil){
                self.showAlert(errorMessage!)
            }
            else{
                self.goodsPageModel?.GoodsPage = goodsPage!
                self.goodsInfo = goodsPage!.itemInfo
                self.tableView.reloadData()
            }
        })
    }
       
}
