//
//  BannerCell.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/22.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class BannerCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var lblGoodsName: UILabel!
    @IBOutlet weak var lblGoodsdesc1: UILabel!
    @IBOutlet weak var lblPriceNow: UILabel!
    @IBOutlet weak var lblPriceOrigin: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var ImageBannerScroll: UIScrollView!
    @IBOutlet weak var BannerPageControl: UIPageControl!
    internal var imageList:[String]!
    var isCare:Bool = false
    
    
    @IBAction func btnStarPressed(sender: UIButton) {
        if(isCare == false) {
            self.btnStar.setBackgroundImage(UIImage(named: "ic_star"), forState: UIControlState.Normal)
            isCare = true
        } else {
            self.btnStar.setBackgroundImage(UIImage(named: "ic_star_outline"), forState: UIControlState.Normal)
            isCare = false
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //設定label為多行
        lblGoodsName.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblGoodsName.numberOfLines = 2
        
        lblGoodsdesc1.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblGoodsdesc1.numberOfLines = 2
        
        ImageBannerSetting()
    }
   
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func ImageBannerSetting() {
        //关闭滚动条显示
        ImageBannerScroll.scrollsToTop = false
        ImageBannerScroll.delegate = self
        
        //添加页面到滚动面板里
        let size = ImageBannerScroll.bounds.size
        
        
        if imageList != nil{
            //設置scrollView的内容總尺寸
            let screenSize = UIScreen.mainScreen().bounds
            ImageBannerScroll.contentSize = CGSizeMake(CGFloat(screenSize.width) * CGFloat(self.imageList.count),0)
            
            for var index = 0 ;index < imageList.count ; ++index{
                let page = UIView()
                if let url = NSURL(string: imageList[index]){
                    if  let data = NSData(contentsOfURL: url){
                        let imageView = UIImageView(image: UIImage(data: data))
                        var scale:CGFloat = 1.0
                        scale = CGFloat(screenSize.width) / (UIImage(data: data)?.size.width)!
                        let rect:CGRect = CGRectMake(0, 0, (UIImage(data: data)?.size.width)! * scale, (UIImage(data: data)?.size.height)! * scale)
                        imageView.frame = rect
                        page.addSubview(imageView)
                        page.backgroundColor = UIColor.blueColor()
                        page.frame = CGRect(x: CGFloat(index) * screenSize.width, y: 0,width: screenSize.width, height: size.height)
                        ImageBannerScroll.addSubview(page)
                    }
                }
            }
            //页控件属性
            BannerPageControl.backgroundColor = UIColor.clearColor()
            BannerPageControl.numberOfPages = imageList.count
            BannerPageControl.currentPage = 0
        }
        
        //设置页控件点击事件
        BannerPageControl.addTarget(self, action: "pageChanged:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    //UIScrollViewDelegate方法，每次滚动结束后调用
    func  scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //通过scrollView内容的偏移计算当前显示的是第几页
        let page = Int(ImageBannerScroll.contentOffset.x / ImageBannerScroll.frame.size.width)
        //设置pageController的当前页
        BannerPageControl.currentPage = page
    }
    
    //点击页控件时事件处理
    func pageChanged(sender:UIPageControl) {
        //根据点击的页数，计算scrollView需要显示的偏移量
        var frame = ImageBannerScroll.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        //展现当前页面内容
        ImageBannerScroll.scrollRectToVisible(frame, animated:true)
    }


}
