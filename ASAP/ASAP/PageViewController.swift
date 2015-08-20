//
//  PageViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/20.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource
{
	var pageHeadings = ["Personalize", "Locate", "Discover"]
	var pageImages = ["homei", "mapintro", "fiveleaves"]
	var pageSubHeading = ["subHead1", "subHead2", "subHead3"]

    override func viewDidLoad() {
        super.viewDidLoad()

		dataSource = self

		if let startingViewController = self.viewControllerAtIndex(0) {
			setViewControllers([startingViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
	{
		var index = (viewController as! PageContentViewController).index
		index++
		return self.viewControllerAtIndex(index)
	}

	func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
		var index = (viewController as! PageContentViewController).index
		index--
		return self.viewControllerAtIndex(index)
	}

	func viewControllerAtIndex(index:Int) -> PageContentViewController? {
		if index == NSNotFound || index < 0 || index >= self.pageHeadings.count {
			return nil
		}

		if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController {
			pageContentViewController.imageFile = pageImages[index]
			pageContentViewController.heading = pageHeadings[index]
			pageContentViewController.subHeading = pageSubHeading[index]
			pageContentViewController.index = index
			return pageContentViewController
		}
		return nil
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
