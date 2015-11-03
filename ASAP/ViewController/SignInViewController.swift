//
//  SignInViewController.swift
//  ASAP
//
//  Created by janet on 2015/9/16.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class SignInViewController: UITableViewController 
{ 
    lazy var signInModel: SignInModel? = SignInModel()
	var	delegate: SignInDelegate? = nil
    var account:    String = ""
    var password:   String = ""

    @IBOutlet var accountText:      UITextField!
    @IBOutlet var passwordText:     UITextField!
    @IBOutlet var passwordSwitch:   UISwitch!
    @IBOutlet var signInButton:     UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.passwordSwitch.addTarget(self, action: Selector("PasswordSwitch:"), forControlEvents: UIControlEvents.ValueChanged)
		self.setRightItemClose()
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ShowRegisterViewController" {
			if let registerViewController = segue.destinationViewController as? RegisterViewController {
				registerViewController.delegate = delegate
			}			
		}
	}
	
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 1:
            return 2
        default:
            return 3
        }
    }
    
    //顯示密碼
    @IBAction func PasswordSwitch(sender: AnyObject) {
        self.passwordText.secureTextEntry = self.passwordSwitch.on ? false : true
     }
    
    //登入
    @IBAction func SignInClick(sender: AnyObject) {
        self.sendSignInData()
    }
    
	//關閉
	func closeButtonOnClicked(sender: UIBarButtonItem) {
		self.dismissViewControllerAnimated(true, completion: {
			if self.delegate != nil {
				self.delegate?.signInCancel()
			}
		})
	}
	
    // MARK: Call Api
	
    func sendSignInData() {
        if(!self.checkRequire()) {
            return
        }
        
		self.showBusy("登入中...")
		
        signInModel?.sendSignInData(account, password: password, completionHandler: { 
			(signIn: SignInResponse?, errorMessage: String?) -> Void in
			
			self.clearAllNotice()
			
            if (signIn == nil) {
                self.showAlert(errorMessage!)
            } else {
                var status_code = signIn!.status_code
                let range = status_code!.startIndex.advancedBy(0)...status_code!.startIndex.advancedBy(7)
                status_code?.removeRange(range)
                
                switch status_code! {
                case "100":
                    self.showSuccess("登入成功")
                    self.delegate?.signInSuccess()
                    self.dismissViewControllerAnimated(true, completion: nil)
                case "302":
                    let errorString = "帳號或密碼輸入錯誤，請重新輸入，還剩餘\(signIn!.errorData!.canLoginTimes!)次機會"
                    self.showAlert(errorString)
                default:
                    self.showAlert((signIn!.description)!)
                }
                

//				let alert = UIAlertController(title: "", message: "登入成功!!", preferredStyle: UIAlertControllerStyle.Alert)
//				let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: { act in
//					self.dismissViewControllerAnimated(true, completion: {
//						self.delegate?.signInSuccess()
//					})
//				})
//				alert.addAction(confirmAction)
//				self.presentViewController(alert, animated: true, completion: nil)
			}
		})
	}
	
    // 檢查必填
    func checkRequire() -> Bool {
        account     = self.accountText.text!
        password    = self.passwordText.text!
        if( account.characters.count == 0 || password.characters.count == 0 ) {
            self.showAlert("輸入資料格式有誤")
            return false
        }
        
        return true
    }
}
