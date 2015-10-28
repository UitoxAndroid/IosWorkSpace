//
//  WebViewController.swift
//  ASAP
//
//  Created by janet on 2015/10/26.
//  Copyright © 2015年 uitox. All rights reserved.
//

import UIKit

// 顯示網頁
class WebViewController: UIViewController {

    @IBOutlet var webView: UIWebView!

    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let termsUrl = NSURL(string: urlString) {
            self.pleaseWait()
            let request = NSURLRequest(URL: termsUrl)
            self.webView.loadRequest(request)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.clearAllNotice()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
