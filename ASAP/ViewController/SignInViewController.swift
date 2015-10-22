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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        switch (section) {
        case 1:
            return 2
        default:
            return 3
        }
    }
    
    //顯示密碼
    @IBAction func PasswordSwitch(sender: AnyObject) {
        if(self.passwordSwitch.on)
        {
            self.passwordText.secureTextEntry = false
        } else {
            self.passwordText.secureTextEntry = true
        }
     }
    
    //登入
    @IBAction func SignInClick(sender: AnyObject) {
        self.sendSignInData()
    }
    
    // MARK: Call Api
    func sendSignInData() {
        let account     = self.accountText.text
        let password    = self.passwordText.text
        
        signInModel?.sendSignInData(account!, password: password!, completionHandler: { (signIn, errorMessage) -> Void in
            if (signIn == nil) {
                self.showAlert(errorMessage!)
            } else {
                let alert = UIAlertView(title: "", message: "登入成功!!", delegate: self, cancelButtonTitle: "確定")
                alert.show()
            }
        })
    }
}
