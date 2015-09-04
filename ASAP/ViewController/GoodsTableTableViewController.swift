//
//  GoodsTableTableViewController.swift
//  ASAP
//
//  Created by HsuTony on 2015/9/4.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class GoodsTableTableViewController: UITableViewController , UIScrollViewDelegate{

    @IBOutlet weak var ImageBanner: UIScrollView!
    @IBOutlet weak var BannerControl: UIPageControl!
    
    var courses = [
        ["name":"goods1","pic":"goodsA"],
        ["name":"goods2","pic":"goodsB"],
        ["name":"goods3","pic":"goodsC"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageBannerSetting()
    }
    
    func ImageBannerSetting() {
        
        //设置scrollView的内容总尺寸
        ImageBanner.contentSize = CGSizeMake(
            CGFloat(CGRectGetWidth(self.view.bounds)) * CGFloat(self.courses.count),
            CGRectGetHeight(self.view.bounds)
        )
        
        //关闭滚动条显示
        ImageBanner.scrollsToTop = false
        ImageBanner.delegate = self
        
        let Size = ImageBanner.bounds.size
        
        //添加页面到滚动面板里
        let size = ImageBanner.bounds.size
        for (seq,course) in enumerate(courses) {
            var page = UIView()
            var imageView=UIImageView(image:UIImage(named:course["pic"]!))
            page.addSubview(imageView);
            page.backgroundColor = UIColor.blueColor()
            let lbl = UILabel(frame: CGRect(x: 0, y: 20, width: 100, height: 20))
            lbl.text = course["name"]
            page.addSubview(lbl)
            
            page.frame = CGRect(x: CGFloat(seq) * size.width, y: 0,
                width: size.width, height: size.height)
            ImageBanner.addSubview(page)
        }
        
        //页控件属性
        BannerControl.backgroundColor = UIColor.clearColor()
        BannerControl.numberOfPages = courses.count
        BannerControl.currentPage = 0
        //设置页控件点击事件
        BannerControl.addTarget(self, action: "pageChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UIScrollViewDelegate方法，每次滚动结束后调用
    override func  scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //通过scrollView内容的偏移计算当前显示的是第几页
        let page = Int(ImageBanner.contentOffset.x / ImageBanner.frame.size.width)
        //设置pageController的当前页
        BannerControl.currentPage = page
    }
    
    //点击页控件时事件处理
    func pageChanged(sender:UIPageControl) {
        //根据点击的页数，计算scrollView需要显示的偏移量
        var frame = ImageBanner.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        //展现当前页面内容
        ImageBanner.scrollRectToVisible(frame, animated:true)
    }
    

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

    
}
