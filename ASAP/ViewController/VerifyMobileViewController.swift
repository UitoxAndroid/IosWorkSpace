//
//  VerifyMobileViewController.swift
//  ASAP
//
//  Created by janet on 2015/9/25.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class VerifyMobileViewController: UITableViewController {
    
    var registerModel: RegisterModel?               = RegisterModel()
    var verifyMobileModel: VerifyMobileModel?       = VerifyMobileModel()
    var signInModel: SignInModel?                   = SignInModel()
    var forgotPasswordModel: ForgotPasswordModel?   = ForgotPasswordModel()
    
    var From:           SendVerifyFrom  = SendVerifyFrom.Register
    var MobileNumber:   String?
    var Password:       String?
    var verifyNumber:   String?
    
    @IBOutlet var mobileLabel: UILabel!
    @IBOutlet var verifyMobileText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.mobileLabel.text = self.MobileNumber
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 重新取得手機驗證碼
    @IBAction func resendVerifyClick(sender: AnyObject) {
        //self.sendVerifyMobileData()
        self.showAlert("重新發送")
    }
    // 進行手機驗證
    @IBAction func verifyMobileClick(sender: AnyObject) {
        self.verifyNumber = self.verifyMobileText.text
        
        
        if (self.From == SendVerifyFrom.Register) {
            //進行手機註冊
            self.sendRegisterData()
        } else {
            //手機忘記密碼
            self.sendForgotPasswordData()
        }
    }
    
    // MARK : Call Api
    
    // 發送手機驗證碼
    func sendVerifyMobileData() {
        self.pleaseWait()
        verifyMobileModel?.sendVerifyMobileData(MobileNumber!, from: From.rawValue, completionHandler: { (verify: VerifyMobileResponse?, errorMessage: String?) -> Void in
            self.clearAllNotice()
            if (verify == nil) {
                self.showAlert(errorMessage!)
            } else {
                var status_code = verify!.status_code
                let range = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
                status_code?.removeRange(range)
                
                if(status_code != "100") {
                    self.showAlert((verify?.description)!)
                }
            }
        })
    }
    
    // 註冊－Phone
    func sendRegisterData() {
        self.pleaseWait()
        registerModel?.sendRegisterData(MobileNumber!, password: Password!, sendEdm: "0", verify: verifyNumber!, completionHandler: { (register: RegisterResponse?, errorMessage: String?) -> Void in
            self.clearAllNotice()
            if (register == nil) {
                self.showAlert(errorMessage!)
            } else {
                var status_code = register!.status_code
                let range = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
                status_code?.removeRange(range)
                if(status_code != "100") {
                    self.showAlert((register?.description)!)
                    return
                }
                
                self.showSuccess("手機驗證完成")
                // 登入－>回首頁
                self.sendSignInData()
            }
        })
    }
    
    // 登入
    func sendSignInData() {
        self.pleaseWait()
        signInModel?.sendSignInData(MobileNumber!, password: Password!, completionHandler: { (signIn, errorMessage) -> Void in
            self.clearAllNotice()
            if (signIn == nil) {
                self.showAlert(errorMessage!)
            } else {
                var status_code = signIn!.status_code
                let range = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
                status_code?.removeRange(range)
                if(status_code != "100") {
                    self.showAlert((signIn!.description)!)
                    return
                }
                
                let firstView = self.storyboard?.instantiateViewControllerWithIdentifier("MyTabBarViewController") as! MyTabBarViewController
                self.navigationController?.presentViewController(firstView, animated: false, completion: nil)
            }
        })
    }

    // 忘記密碼－Phone
    func sendForgotPasswordData() {
        self.pleaseWait()
        forgotPasswordModel?.sendForgotPasswordData(MobileNumber!, verify: verifyNumber!) { (forgot, errorMessage) -> Void in
            self.clearAllNotice()
            if (forgot == nil) {
                self.showAlert(errorMessage!)
            } else {
                var status_code = forgot!.status_code
                let range = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
                status_code?.removeRange(range)
                
                switch status_code! {
                case "100":
                    self.showSuccess("驗證完成，請重設密碼")
                    let resetPasswordView = self.storyboard?.instantiateViewControllerWithIdentifier("ResetPasswordViewController") as! ResetPasswordViewController
                    resetPasswordView.account = self.MobileNumber!
                    self.navigationController?.pushViewController(resetPasswordView, animated: false)
                case "300":
                    self.showAlert("驗證密碼錯誤，請重新輸入")
                default:
                    self.showAlert((forgot!.description)!)
                }
            }
        }
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
