//
//  SignInViewController.swift
//  ASAP
//
//  Created by janet on 2015/9/16.
//  Copyright (c) 2015年 uitox. All rights reserved.
//

import UIKit

class SignInViewController: UITableViewController {
    
    var signInModel: SignInModel? = SignInModel()
    
    var account:    String = ""
    var password:   String = ""

    @IBOutlet var accountText:      UITextField!
    @IBOutlet var passwordText:     UITextField!
    @IBOutlet var passwordSwitch:   UISwitch!
    @IBOutlet var signInButton:     UIButton!
    
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
    
    //顯示密碼
    @IBAction func PasswordSwitch(sender: AnyObject) {
        self.passwordText.secureTextEntry = self.passwordSwitch.on ? false : true
     }
    
    //登入
    @IBAction func SignInClick(sender: AnyObject) {
        self.sendSignInData()
    }
    
    // MARK: Call Api
    func sendSignInData() {
        if(!self.checkRequire()) {
            return
        }
        
        self.pleaseWait()
        signInModel?.sendSignInData(account, password: password, completionHandler: { (signIn, errorMessage) -> Void in
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
                
                self.showSuccess("登入成功")
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
