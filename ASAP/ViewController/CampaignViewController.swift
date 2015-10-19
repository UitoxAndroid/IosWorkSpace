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
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblCampaignDate.text = ""
        self.lblCampaignDescribe.text = ""
        self.lblCampaignName.text = ""
        self.lblCampaignStatus.text = ""
        setKindView()
        setRightItemSearch()
    }
    
    func setKindView() {
        var campPrice : String!
        var campDiscount : String!
        var campType : String!
        var campStatus : Int!
        self.pleaseWait()
        self.GetCampaign {
            (campaignResponse:SearchListResponse?) in
            campPrice = campaignResponse!.campInfo[0].campPromote[0].campPrice
            campDiscount = campaignResponse!.campInfo[0].campPromote[0].campDiscount
            campType = campaignResponse!.campInfo[0].campType
            campStatus = campaignResponse!.campInfo[0].campStatus
            self.lblCampaignName.text = campaignResponse?.campInfo[0].campName
            self.lblCampaignDate.text = "\(campaignResponse!.campInfo[0].startDate!) ~ \(campaignResponse!.campInfo[0].endDate!)"
            switch (campType!) {
            case "0":
                self.lblCampaignDescribe.text = "滿\(campPrice)折\(campDiscount)"
            case "1":
                self.lblCampaignDescribe.text = "滿\(campPrice)贈\(campDiscount)購物金"
            default:
                self.lblCampaignDescribe.text = "滿\(campPrice)送贈品"
            }
            
            if campStatus == 0 {
                let vc = self.childViewControllers.first as! KindViewController
                vc.searchListResponse = campaignResponse
                self.lblCampaignStatus.text = "限時特賣中"
                self.lblCampaignStatus.backgroundColor = UIColor.redColor()
                vc.tableView.reloadData()
            } else {
                self.containerView.hidden = true
                self.lblCampaignStatus.text = "特賣即將開始"
                self.lblCampaignStatus.backgroundColor = UIColor.grayColor()
            }
            self.clearAllNotice()
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
