//
//  ForgotPasswordViewController.swift
//  ASAP
//
//  Created by janet on 2015/9/25.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UITableViewController {
    
    var verifyMobileModel: VerifyMobileModel?       = VerifyMobileModel()
    var forgotPasswordModel: ForgotPasswordModel?   = ForgotPasswordModel()
    
    var account: String = ""
    
    @IBOutlet var accountText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func forgotPasswordClick(sender: AnyObject) {
        self.account = self.accountText.text!
        if (self.account.characters.count == 0) {
            self.showAlert("輸入資料格式有誤")
            return
        }
        
        if account.isMobile() {
            sendVerifyMobileData()
        } else {
            sendForgotPasswordData()
        }
        
    }

    // MARK: Call Api
    
    // 發送忘記密碼－Email
    func sendForgotPasswordData() {
        self.pleaseWait()
        forgotPasswordModel?.sendForgotPasswordData(account, verify: "") { (forgot, errorMessage) -> Void in
            self.clearAllNotice()
            if ( forgot == nil) {
                self.showAlert(errorMessage!)
            } else {
                var status_code = forgot!.status_code
                let range = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
                status_code?.removeRange(range)
                if(status_code != "101") {
                    self.showAlert((forgot!.description)!)
                    return
                }
                
                self.showSuccess("已發送密碼至您所填的Email")
                // 登入頁
                let signInView = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
                self.navigationController?.pushViewController(signInView, animated: false)
            }
        }
    }
    
    // 忘記密碼-發送手機驗證碼
    func sendVerifyMobileData() {
        self.pleaseWait()
        verifyMobileModel?.sendVerifyMobileData(account, from: SendVerifyFrom.ForgotPassword.rawValue, completionHandler: { (verify: VerifyMobileResponse?, errorMessage: String?) -> Void in
            self.clearAllNotice()
            if (verify == nil) {
                self.showAlert(errorMessage!)
            } else {
                var status_code = verify!.status_code
                let range       = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
                status_code?.removeRange(range)
                
                switch status_code! {
                case "100":
                    let verifyView          = self.storyboard?.instantiateViewControllerWithIdentifier("VerifyMobileView") as! VerifyMobileViewController
                    verifyView.MobileNumber = self.account
                    verifyView.Password     = ""
                    verifyView.From         = SendVerifyFrom.ForgotPassword
                    self.navigationController?.pushViewController(verifyView, animated: false)
                case "301":
                    self.showAlert((verify?.description)!)
                    let signInView = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
                    self.navigationController?.pushViewController(signInView, animated: false)
                default:
                    self.showAlert((verify?.description)!)
                }
            }
        })
    }

    
    // MARK: - Table view data source

    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }*/

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
