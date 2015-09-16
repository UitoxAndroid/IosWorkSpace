//
//  FirstViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/13.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

let reuseTableViewCellIdentifier = "DealsCell"

class FirstViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, CirCleViewDelegate
{
	@IBOutlet weak var tableView: UITableView!
    
	lazy var openWeather:OpenWeatherModel? = OpenWeatherModel()
	lazy var searchData:SearchModel? = SearchModel()
    lazy var deployData:DeployModel? = DeployModel()
    lazy var slideDataList:[SlideData] = [SlideData]()
    lazy var productList:[ProductData] = [ProductData]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.deployTest()
    }
      
    
	override func viewDidLoad() {
		super.viewDidLoad()
		//apiManagerTest()
		//searchTest()
        
        self.tableView.dataSource   = self
        self.tableView.delegate     = self
        
        getDealsList()
	}

	func apiManagerTest() {
		openWeather?.getWeatherData() { (weather: WeatherResponse?, errorMessage: String?) in
			if weather == nil {
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					let alert = UIAlertController(title: "警告", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
					let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
					alert.addAction(confirmAction)
					self.presentViewController(alert, animated: true, completion: nil)
				})
			} else {
				self.openWeather!.weather = weather!

				println("name:\(weather!.name!)")
				println("cod: \(weather!.cod!)")
				println("date: \(weather!.date!)")
				println("main.humidity: \(weather!.humidity!)")
				println("main.pressure: \(weather!.pressure!)")

				if let weather = weather?.weather {
					for wea in weather {
						println(wea.description!)
						println(wea.icon!)
					}
				}
			}
		}
	}

	func searchTest() {
		searchData?.getSearchData() { (search: SearchListResponse?, errorMessage: String?) in
			if search == nil {
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					let alert = UIAlertController(title: "警告", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
					let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
					alert.addAction(confirmAction)
					self.presentViewController(alert, animated: true, completion: nil)
				})
			} else {
				self.searchData!.search = search!
				println("statusCode:\(search!.statusCode)")
				println("total:\(search!.total)")
                println("currentPage:\(search!.currentPage)")
                
                if let storeList = search?.stroeList {
                    for stroe in storeList {
                        print("\(stroe.name!)\t")
                        print("\(stroe.pic!)\t")
//                        print("\(stroe.title!)\t")
                        println()
                    }
                }

			}
		}
	}
    
    func deployTest() {
        deployData?.getDeployData("", completionHandler: { (deploy: DeployResponse?, errorMessage: String?) -> Void in
            if (deploy == nil) {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let alert = UIAlertController(title: "警告", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(confirmAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            } else {
                self.deployData?.deploy = deploy!
                self.slideDataList      = deploy!.dataList!.slideDataList
                //self.productList        = deploy!.dataList!.productDataList
                
                self.pictureGallery()
            }
        })
    }

	override func prefersStatusBarHidden() -> Bool {
		return false
	}


    /* 首頁－輪播廣告 */
    
    @IBOutlet var galleryScrollView: UIScrollView!

    @IBOutlet var galleryPageControl: UIPageControl!
    
    var circleView: CirCleView!
    
    var imageArray: [UIImage!] = []

    func pictureGallery() {
        for slideData:SlideData in self.slideDataList {
            if let url = NSURL(string: slideData.img!) {
                if let data = NSData(contentsOfURL: url) {
                    self.imageArray.append(UIImage(data: data))                }
            }
        }
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.circleView = CirCleView(frame: CGRectMake(0, 64, self.view.frame.size.width, 120), imageArray: self.imageArray)
        self.circleView.delegate = self
        self.view.addSubview(self.circleView)
    }
    
    /* 首頁－整點特賣*/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseTableViewCellIdentifier, forIndexPath: indexPath) as! DealsTableViewCell

        cell.detailTextLabel?.text = "10:20:05"
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(0 == indexPath.section)
        {
            return 200
        } else {
            return 100
        }
    }

    func getDealsList() {
        let deal1 = ProductData()
        deal1.img = "http://img02-tw1.uitoxbeta.com/A/show/2014/0709/AM0000010/201407AM090000010_047493227.png"
        deal1.name = "Apple iPhone 5S 16GB -銀"
        deal1.price = "21500"
        productList.append(deal1)
        
        let deal2 = ProductData()
        deal2.img = "http://img02-tw1.uitoxbeta.com/A/show/2013/0925/AM0001074/201309AM250001074_417329728.jpg"
        deal2.name = "Blue Star 折疊式老人機 A608"
        deal2.price = "1790"
        productList.append(deal2)
        
        let deal3 = ProductData()
        deal3.img = "http://img02-tw1.uitoxbeta.com/A/show/2013/0926/AM0000853/201309AM260000853_135974997.jpg"
        deal3.name = "iNO CP99極簡風老人摺疊手機"
        deal3.price = "1588"
        productList.append(deal3)
        
        let deal4 = ProductData()
        deal4.img = "http://img02-tw1.uitoxbeta.com/A/show/2013/0926/AM0000870/201309AM260000870_400345476.jpg"
        deal4.name = "iNO CP79摺疊式銀髮族手機"
        deal4.price = "1490"
        productList.append(deal4)
        
        let deal5 = ProductData()
        deal5.img = "http://img02-tw1.uitoxbeta.com/A/show/2013/0926/AM0000953/201309AM260000953_897866938.jpg"
        deal5.name = "YAVi雅米 i05銀髮族極簡御守機"
        deal5.price = "988"
        productList.append(deal5)
    }
}


let reuseCollectionViewCellIdentifier = "DealsCollectionCell"
// MARK: - Collection View Data source and Delegate
extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: DealsCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseCollectionViewCellIdentifier, forIndexPath: indexPath) as! DealsCollectionViewCell
        
        if let url = NSURL(string: self.productList[indexPath.row].img!) {
            if let data = NSData(contentsOfURL: url) {
                cell.productImage.image = UIImage(data: data)
            }
        }
        cell.productNameLabel?.text     = self.productList[indexPath.row].name
        cell.productPriceLabel?.text    = ("$\(self.productList[indexPath.row].price!)")

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("點選\(indexPath.row)")    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (self.view.frame.width - 10) / 3
        return CGSize(width: width, height: collectionView.frame.height)
    }
}
