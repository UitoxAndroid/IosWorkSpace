//
//  PageContentViewController.swift
//  ASAP
//
//  Created by uitox_macbook on 2015/8/20.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController
{

	@IBOutlet weak var headingLabel: UILabel!
	@IBOutlet weak var subHeadingLabel: UILabel!
	@IBOutlet weak var contentImageView: UIImageView!
	var index:Int = 0
	var heading: String = ""
	var imageFile: String = ""
	var subHeading: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

		headingLabel.text = heading
		subHeadingLabel.text = heading
		contentImageView.image = UIImage(named: imageFile)
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
