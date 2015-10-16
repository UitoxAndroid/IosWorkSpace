//
//  CampaignViewController.swift
//  ASAP
//
//  Created by HsuTony on 2015/10/14.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

class CampaignViewController: UIViewController
{
    @IBOutlet weak var lblCampaignStatus: UILabel!
    @IBOutlet weak var lblCampaignName: UILabel!
    @IBOutlet weak var lblCampaignDate: UILabel!
    @IBOutlet weak var lblCampaignDescribe: UILabel!
    @IBOutlet weak var containerView: UIView!
    lazy var campaignData:CampaignModel? = CampaignModel()
    var campaignStatus:Bool! = true
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblCampaignDate.text = ""
        self.lblCampaignDescribe.text = ""
        self.lblCampaignName.text = ""
        self.lblCampaignStatus.text = ""
        
        if campaignStatus == false {
            lblCampaignStatus.text = "特賣即將開始"
            lblCampaignStatus.backgroundColor = UIColor.grayColor()
        } else {
            lblCampaignStatus.text = "限時特賣中"
            lblCampaignStatus.backgroundColor = UIColor.redColor()
        }
        setKindView()
        setRightItemSearch()
    }
    
    func setKindView() {
        if campaignStatus == true {
            let vc = self.childViewControllers.first as! KindViewController
            self.pleaseWait()
            self.GetCampaign {
                (campaignResponse:SearchListResponse?) in
                vc.searchListResponse = campaignResponse
                self.lblCampaignName.text = campaignResponse?.campInfo[0].campName
                self.lblCampaignDate.text = "\(campaignResponse!.campInfo[0].startDate!) ~ \(campaignResponse!.campInfo[0].endDate!)"
                self.lblCampaignDescribe.text = "\(campaignResponse!.campInfo[0].campPromote!)"
                vc.tableView.reloadData()
                self.clearAllNotice()
            }
        } else {
            containerView.hidden = true
            self.pleaseWait()
            self.GetCampaign {
                (campaignResponse:SearchListResponse?) in
                self.lblCampaignName.text = campaignResponse?.campInfo[0].campName
                self.lblCampaignDate.text = "\(campaignResponse!.campInfo[0].startDate!) ~ \(campaignResponse!.campInfo[0].endDate!)"
                self.lblCampaignDescribe.text = "\(campaignResponse!.campInfo[0].campPromote!)"
                self.clearAllNotice()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK - Call Api
    
    func GetCampaign(completionHandler: (campaignResponse :SearchListResponse?) -> Void) {
        campaignData?.getCampaignData { (campaign:SearchListResponse?, errorMessage: String?) in
            if(errorMessage != nil) {
                self.showAlert(errorMessage!)
            } else {
                completionHandler(campaignResponse: campaign!)
            }
        }
    }
    
    

   
}
