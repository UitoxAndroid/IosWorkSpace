//
//  SpecificViewController.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/5.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class SpecificViewController: UITableViewController {
    
    @IBAction func btnDismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return 8
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section){
        case 0:
            switch(indexPath.row){
            case 0:
                let titleCell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
                return titleCell
            case 1:
                let colorCell = tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath) as! ColorCell
                return colorCell
            case 2:
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell", forIndexPath: indexPath) as! SectionTitleCell
                sectionTitleCell.txtTitle.text = "尺寸"
                return sectionTitleCell
            case 3:
                let sizeCell = tableView.dequeueReusableCellWithIdentifier("SizeCell", forIndexPath: indexPath) as! SizeCell
                return sizeCell
            case 4:
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell", forIndexPath: indexPath) as! SectionTitleCell
                sectionTitleCell.txtTitle.text = "包含內容"
                return sectionTitleCell
            case 5:
                let contentCell = tableView.dequeueReusableCellWithIdentifier("ContentCell", forIndexPath: indexPath) as! ContentCell
                return contentCell
            case 6:
                let sectionTitleCell = tableView.dequeueReusableCellWithIdentifier("SectionTitleCell", forIndexPath: indexPath) as! SectionTitleCell
                sectionTitleCell.txtTitle.text = "贈品"
                return sectionTitleCell
            case 7:
                let giftCell = tableView.dequeueReusableCellWithIdentifier("GiftCell", forIndexPath: indexPath) as! GiftCell
                return giftCell
            default:
                let titleCell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
                return titleCell
            }
        default:
            let titleCell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
            return titleCell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch(indexPath.section){
        case 0:
            switch(indexPath.row){
            case 0: //title
                return 150
            case 1: //color
                return 80
            case 2: //尺寸 title
                return 44
            case 3: //尺寸
                return 44
            case 4: //包含內容 title
                return 44
            case 5: //內容
                return 80
            case 6: //贈品 title
                return 44
            case 7: //贈品
                return 80
            default:
                return 44
            }
        default:
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //自動消除選取時該列時會以灰色來顯示的效果
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    

}
