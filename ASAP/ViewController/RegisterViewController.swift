//
//  RegisterViewController.swift
//  ASAP
//
//  Created by janet on 2015/9/25.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class RegisterViewController: UITableViewController {
    
    let privacyUrl  = "https://shop-tw1.uitox.com/AW000001/member/privacy_page"
    let termsUrl    = "https://shop-tw1.uitox.com/AW000001/member/terms_page"
    
    var registerModel: RegisterModel?           = RegisterModel()
    var verifyMobileModel: VerifyMobileModel?   = VerifyMobileModel()
    var signInModel: SignInModel?               = SignInModel()
	var	delegate: SignInDelegate?				= nil
    
    var passwrodStrength:   Strength            = Strength.Weak
    var account:    String = ""
    var password:   String = ""
    var sendEdm:    String = ""
    
    @IBOutlet var webView:          UIWebView!
    
    @IBOutlet var confirmEmailCell: UITableViewCell! // Email確認
    @IBOutlet var edmCell:          UITableViewCell! // 勾選電子報
    
    @IBOutlet var accountText:      UITextField!
    @IBOutlet var confirmEmailText: UITextField!
    @IBOutlet var passwordText:     UITextField!
    @IBOutlet var edmLabel:         UILabel!
    
    @IBOutlet var passwordSwitch:   UISwitch!
    @IBOutlet var registerButton:   UIButton!
    
    @IBOutlet var readAgreeCheckBox: CheckBox!
    @IBOutlet var subscribeCheckBox: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.passwordSwitch.addTarget(self, action: Selector("PasswordSwitch:"), forControlEvents: UIControlEvents.ValueChanged)
        self.subscribeCheckBox.isChecked = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: 顯示密碼
    @IBAction func PasswordSwitch(sender: UISwitch) {
        self.passwordText.secureTextEntry = !self.passwordSwitch.on
    }
    
    // MARK: 驗證Email/Mobile
    var isMobile : Bool = false
    @IBAction func accountChanged(sender: AnyObject) {

        account = self.accountText.text!
        
        self.tableView.beginUpdates()
        self.isMobile = account.isMobile()
//        self.confirmEmailCell.hidden    = self.isMobile
//        self.edmCell.hidden             = self.isMobile
        self.confirmEmailText.hidden    = self.isMobile
        self.subscribeCheckBox.hidden   = self.isMobile
        self.edmLabel.hidden            = self.isMobile
        self.tableView.endUpdates()

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
    
    // MARK: 註冊
    @IBAction func registerButtonClick(sender: AnyObject) {
        if (!self.checkRequire()) {
            return
        }
        
        if (self.account.isMobile()) {
            sendVerifyMobileData()
        } else {
            self.sendRegisterData()
        }
        
    }
    
    // MARK: Call Api
    // 註冊－Email
    func sendRegisterData() {
        self.pleaseWait()
        registerModel?.sendRegisterData(account, password: password, sendEdm: sendEdm, verify: "", completionHandler: { (register: RegisterResponse?, errorMessage: String?) -> Void in
            self.clearAllNotice()
            if (register == nil) {
                self.showAlert(errorMessage!)
            } else {
                var status_code = register!.status_code
                let range       = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
                status_code?.removeRange(range)
                
                switch status_code! {
                case "100":
					// 回原來那頁
                    self.showSuccess("註冊成功！\n歡迎使用此帳號進行購物")
					self.delegate?.signInSuccess()
					self.dismissViewControllerAnimated(true, completion: nil)
                    // 登入－>回首頁
//                    self.sendSignInData()
                case "300":
                    self.showAlert((register?.description)!)
                    let signInView = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
                    self.navigationController?.pushViewController(signInView, animated: false)
                default:
                    self.showAlert((register?.description)!)
                }
            }
        })
    }
    
    // 註冊-發送手機驗證碼
    func sendVerifyMobileData() {
        self.pleaseWait()
        verifyMobileModel?.sendVerifyMobileData(account, from: SendVerifyFrom.Register.rawValue, completionHandler: { (verify: VerifyMobileResponse?, errorMessage: String?) -> Void in
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
                    verifyView.Password     = self.password
                    verifyView.From         = SendVerifyFrom.Register
					verifyView.delegate		= self.delegate
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
    
    // 登入
    func sendSignInData() {
        self.pleaseWait()
        signInModel?.sendSignInData(account, password: password, completionHandler: { (signIn, errorMessage) -> Void in
            self.clearAllNotice()
            if (signIn == nil) {
                self.showAlert(errorMessage!)
            } else {
                var status_code = signIn!.status_code
                let range       = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
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

    // 檢查必填
    func checkRequire() -> Bool {
        let confirmEmail    = self.confirmEmailText.text!
        account             = self.accountText.text!
        password            = self.passwordText.text!
        sendEdm             = self.subscribeCheckBox.isChecked ? "1" : "0"

		if( account.characters.count == 0 || (!self.isMobile && confirmEmail.characters.count == 0) || password.characters.count == 0 ) {
            self.showAlert("輸入資料格式有誤")
            return false
        }
        
        if (!account.isMobile()) {
            if (account != confirmEmail) {
                self.showAlert("Email帳號驗證錯誤")
                self.confirmEmailText.becomeFirstResponder()
                return false
            }
        }
        
        if (self.passwrodStrength == Strength.Weak) {
            self.showAlert("密碼強度不足，請重新輸入")
            self.passwordText.text = ""
            self.passwordText.becomeFirstResponder()
            return false
        }

        if (!self.readAgreeCheckBox.isChecked) {
            self.showAlert("請閱讀並勾選同意「購物須知」及「隱私權政策」")
            return false
        }
        
        return true
    }
    
    // 購物須知
    @IBAction func termsClick(sender: AnyObject) {
        let webView = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        webView.urlString = self.termsUrl
        self.navigationController?.pushViewController(webView, animated: false)
    }
    
    // 隱私權
    @IBAction func privacyButtonClick(sender: AnyObject) {
        let webView = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        webView.urlString = self.privacyUrl
        self.navigationController?.pushViewController(webView, animated: false)
    }
	
	@IBAction func loginButtonClick(sender: UIButton) {
		self.navigationController?.popToRootViewControllerAnimated(true)
	}
	
    
     // MARK: - Table view data source
    
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        
        return cell!
    }*/
    
    /*override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        var height: CGFloat = cell!.frame.size.height
        if(self.isMobile) {
            if(cell?.reuseIdentifier == "confirmEmailCell" || cell?.reuseIdentifier == "edmCell") {
              height = 0
            }
        }

        return height
    }*/

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
