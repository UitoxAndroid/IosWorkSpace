//
//  MyTabBarViewController.swift
//  UitoxSample1
//
//  Created by uitox_macbook on 2015/8/26.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class MyTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		
//		let vcclass:Array<AnyObject> = [ZTTableViewController.self, ZTTableViewController.self, ZTTableViewController.self, ZTTableViewController.self]
//		let titles = ["第一分類","第二分類","第二分類","第二分類"]
//		var vca = ZTViewController(mneuViewStyle: MenuViewStyleDefault)
//		vca.loadVC(vcclass, andTitle: titles)


//		controller.tabBarItem.image = [UIImage imageNamed:image];
//		vca.title = "New";
//		controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//		dict[NSForegroundColorAttributeName] = rgb(128, 128, 128);
//		NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
//		dict1[NSForegroundColorAttributeName] = [UIColor redColor];
//		[controller.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
//		[controller.tabBarItem setTitleTextAttributes:dict1 forState:UIControlStateSelected];

//		let nav = NavigationViewController(rootViewController: vca)
//		self.addChildViewController(nav)

//		NavigationViewController *nav = [[NavigationViewController alloc]initWithRootViewController:controller];
//		[self addChildViewController:nav];


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
