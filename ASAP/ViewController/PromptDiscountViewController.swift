//
//  PromptDiscountViewController.swift
//  ASAP
//
//  Created by HsuTony on 2015/11/5.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

class PromptDiscountViewController: UITableViewController {
    lazy var placeholderImage: UIImage = {
        let image = UIImage(named: "PlaceholderImage")!
        return image
        }()
    var goodsResponse:GoodsPageResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightItemClose()
        setUpBarButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func closeButtonOnClicked(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        navigationController?.toolbarHidden = false
        setUpBarButton()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch(indexPath.section) {
        case 0 :
            switch(indexPath.row) {
            case 0:
                return 135
            case 1:
                return 44
            default :
                return 44
            }
        default:
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0:
                let promptCountCell = tableView.dequeueReusableCellWithIdentifier("PromptCountCell", forIndexPath: indexPath) as! PromptCountCell
                
                if let goodsImg = goodsResponse?.itemInfo?.smPic {
                    let URL = NSURL(string: goodsImg)!
                    //使用Kingfisher以Url當key
                    promptCountCell.imgProduct.kf_setImageWithURL(URL, placeholderImage: placeholderImage,
                        optionsInfo: [.Options: KingfisherOptions.CacheMemoryOnly, .Transition: ImageTransition.Fade(0.1)],
                        progressBlock: { (receivedSize, totalSize) -> () in
                            log.debug("\(indexPath.row + 1): \(receivedSize)/\(totalSize)")
                        }) { (image, error, cacheType, imageURL) -> () in
                            if error != nil  {
                            }
                    }
                }
                
                if let goodsName = goodsResponse?.itemInfo?.smName {
                    promptCountCell.lblProductName.text = goodsName
                }
                
                if let goodsOriginPrice = goodsResponse?.itemInfo?.smPrice {
                    promptCountCell.lblOriginPrice.text = "$\(goodsOriginPrice)"
                }
                
                if let goodsInfos = goodsResponse?.itemInfo {
                    let minusPrice:Int = Int(goodsInfos.smPrice!)! - Int(goodsInfos.ssmPrice)!
                    promptCountCell.lblMinusPrice.text = "-$\(minusPrice)"
                }
                
                return promptCountCell
            case 1:
                let promptResultCell = tableView.dequeueReusableCellWithIdentifier("PromptResultCell", forIndexPath: indexPath) as! PromptResultCell
                
                if let goodsResultPrice = goodsResponse?.itemInfo?.ssmPrice {
                    promptResultCell.lblFinalPrice.text = "$\(goodsResultPrice)"
                }
                
                return promptResultCell
            default:
                let promptCountCell = tableView.dequeueReusableCellWithIdentifier("PromptCountCell", forIndexPath: indexPath) as! PromptCountCell
                return promptCountCell
            }
        default:
            let promptCountCell = tableView.dequeueReusableCellWithIdentifier("PromptCountCell", forIndexPath: indexPath) as! PromptCountCell
            return promptCountCell
        }
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    
    // MARK: - ToolBar 設定
    
    @IBOutlet weak var shopCart: UIBarButtonItem!
    @IBOutlet weak var addShopCart: UIBarButtonItem!
    @IBOutlet weak var buyNum: UIBarButtonItem!
    
    let addInCart = UIButton()
    let shopCartBtn = MIBadgeButton()
    let volumeView = VolumeButton()
    var buyCount = 1
    var numInCart = 0
    let comboData = CartComboData()
    
    func setUpBarButton() {
        buyNum.title = "1"
        addInCart.backgroundColor = UIColor.redColor()
        addInCart.setTitle("加入購物車", forState: .Normal)
        addInCart.addTarget(self, action: "btnAddInCartPressed:", forControlEvents: .TouchUpInside)
        addInCart.frame = CGRectMake(0, 0, 170, 43)
        addShopCart.customView = addInCart
        
        shopCartBtn.setBackgroundImage(UIImage(named: "ic_shopping_cart"), forState: UIControlState.Normal)
        if(MyApp.sharedShoppingCart.goodsList.count > 0) {
            shopCartBtn.badgeString = String(MyApp.sharedShoppingCart.goodsList.count)
            numInCart = MyApp.sharedShoppingCart.goodsList.count
        } else {
            shopCartBtn.badgeString = nil
        }
        shopCartBtn.addTarget(self, action: "btnShopCartPressed:", forControlEvents: .TouchUpInside)
        shopCartBtn.frame = CGRectMake(0, 0, 30, 30)
        shopCartBtn.badgeEdgeInsets = UIEdgeInsetsMake(12, 5, 0, 10)
        shopCart.customView = shopCartBtn
    }
    
    func btnAddInCartPressed(sender :UIButton) {
   
        if let specType = goodsResponse?.itemInfo?.specType {
            if specType != 0 {
                showSpecificViewController()
            } else {
                numInCart++
                if(numInCart <= 0) {
                    shopCartBtn.badgeString = nil
                } else {
                    shopCartBtn.badgeString = "\(numInCart)"
                }
                
                //先寫入假資料
                comboData.itno  = "AB123000\(numInCart)"
                comboData.sno   = "CC123000\(numInCart)"
                
                MyApp.sharedShoppingCart.insertGoodsIntoCart(CartDetail())
                self.showSuccess("已加入購物車")
                self.addCartNumber()
            }
        }
    }
    
    func btnShopCartPressed(sender: MIBadgeButton) {
        MyApp.sharedShoppingCart.queryShoppingCart()
    }
    
    @IBAction func btnPlusPressed(sender: UIBarButtonItem) {
        buyCount++
        self.buyNum.title = "\(buyCount)"
    }
    
    @IBAction func btnMinusPressed(sender: UIBarButtonItem) {
        buyCount--
        if(buyCount <= 1) {
            buyCount = 1
            self.buyNum.title = "1"
        } else {
            self.buyNum.title = "\(buyCount)"
        }
    }

    
    
    //顯示規格頁
    func showSpecificViewController() -> SpecificViewController? {
        let specificViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SpecificViewController")
        specificViewController?.modalPresentationStyle = .CurrentContext
        
        if let specificViewController = specificViewController as? SpecificViewController {
            specificViewController.colorInfo = goodsResponse?.productInfo?.colorInfo
            specificViewController.sizeInfo = goodsResponse?.productInfo?.sizeInfo
            specificViewController.multiProductList = (goodsResponse?.productInfo?.multiProductList)!
            specificViewController.giftList = (goodsResponse?.giftInfo?.giftList)!
            specificViewController.itemInfo = goodsResponse?.itemInfo
            specificViewController.cartAction = 1
            let nav = UINavigationController(rootViewController: specificViewController)
            self.presentViewController(nav, animated: true, completion: nil)
            return specificViewController
        }
        return nil
    }

    
}
