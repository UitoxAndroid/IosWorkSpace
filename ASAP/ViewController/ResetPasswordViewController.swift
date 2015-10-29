//
//  ResetPasswordViewController.swift
//  ASAP
//
//  Created by janet on 2015/9/25.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UITableViewController {

    var resetPasswordModel: ResetPasswordModel? = ResetPasswordModel()
    var passwrodStrength:   Strength            = Strength.Weak

    var account:    String = ""
    var password:   String = ""
    
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var passwordSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.passwordSwitch.addTarget(self, action: Selector("PasswordSwitch:"), forControlEvents: UIControlEvents.ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 顯示密碼
    @IBAction func PasswordSwitch(sender: AnyObject) {
        self.passwordText.secureTextEntry = !self.passwordSwitch.on
    }
    
    // MARK: 驗證密碼強度
    @IBAction func passwordTextChanged(sender: AnyObject) {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.frame = CGRect(x: 0 + width , y: passwordText.frame.size.height - width , width: passwordText.frame.size.width - (width * 2), height: passwordText.frame.size.height - width)
        border.borderWidth = width
        
        let pwd = self.passwordText.text!
        // 密碼強度:弱
        if pwd.isWeak() {
            self.passwordText.rightView     = UIImageView(image: UIImage(named: "ic_exclamation_red"))
            self.passwordText.rightViewMode = UITextFieldViewMode.Always
            
            border.borderColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1).CGColor
            passwordText.layer.addSublayer(border)
            passwordText.layer.masksToBounds = true
            self.passwrodStrength = Strength.Weak
            return
        }
        // 密碼強度:強
        if pwd.isStrong() {
            self.passwordText.rightView     = UIImageView(image: UIImage(named: "ic_check_green"))
            self.passwordText.rightViewMode = UITextFieldViewMode.Always
            
            border.borderColor = UIColor(red: 0/255, green: 150/255, blue: 100/255, alpha: 1).CGColor
            passwordText.layer.addSublayer(border)
            passwordText.layer.masksToBounds = true
            self.passwrodStrength = Strength.Strong
            return
        }
        // 密碼強度:中
        self.passwordText.rightView     = UIImageView(image: UIImage(named: "ic_exclamation_yellow"))
        self.passwordText.rightViewMode = UITextFieldViewMode.Always
        
        border.borderColor = UIColor(red: 255/255, green: 200/255, blue: 0/255, alpha: 1).CGColor
        passwordText.layer.addSublayer(border)
        passwordText.layer.masksToBounds = true
        self.passwrodStrength = Strength.Medium
    }
    
    // MARK: 重設密碼
    @IBAction func resetPasswordClick(sender: AnyObject) {
        self.password = self.passwordText.text!
        
        if (self.passwrodStrength == Strength.Weak) {
            self.showAlert("密碼強度不足，請重新輸入")
            self.passwordText.text = ""
            self.passwordText.becomeFirstResponder()
            return
        }
        
        sendResetPasswordData()
    }
    
    // 手機重設密碼
    func sendResetPasswordData() {
        self.pleaseWait()
        resetPasswordModel?.sendVerifyMobileData(account, password: password, completionHandler: { (reset, errorMessage) -> Void in
            self.clearAllNotice()
            if (reset == nil) {
                self.showAlert(errorMessage!)
            } else {
                var status_code = reset!.status_code
                let range = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
                status_code?.removeRange(range)
                if(status_code != "100") {
                    self.showAlert((reset?.description)!)
                    return
                }
                self.showSuccess("密碼重設成功，下次登入請使用新密碼")
				
				self.navigationController?.popToRootViewControllerAnimated(true)
//                let signInView = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
//                self.navigationController?.pushViewController(signInView, animated: false)
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
