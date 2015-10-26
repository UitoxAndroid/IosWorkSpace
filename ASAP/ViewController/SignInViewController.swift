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
        if(self.passwordSwitch.on) {
            self.passwordText.secureTextEntry = false
        } else {
            self.passwordText.secureTextEntry = true
        }
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
        let account     = self.accountText.text
        let password    = self.passwordText.text
        
		self.showBusy("登入中...請稍候")
		
        signInModel?.sendSignInData(account!, password: password!, completionHandler: { 
			(signIn: SignInResponse?, errorMessage: String?) -> Void in
			
			self.clearAllNotice()
			
            if (signIn == nil) {
                self.showAlert(errorMessage!)
            } else {
				let alert = UIAlertController(title: "", message: "登入成功!!", preferredStyle: UIAlertControllerStyle.Alert)
				let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: { act in
					self.dismissViewControllerAnimated(true, completion: {
						self.delegate?.signInSuccess()
					})
				})
				alert.addAction(confirmAction)
				self.presentViewController(alert, animated: true, completion: nil)

            }
        })
    }
}
