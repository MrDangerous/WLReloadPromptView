//
//  ViewController.swift
//  WLReloadPromptView
//
//  Created by ByRongInvest on 15/12/24.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadAction = {
            self.activityIndicatorView.hidden = false;
            self.activityIndicatorView.startAnimating();
            self.view.bringSubviewToFront(self.activityIndicatorView)
            
            NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://img.hb.aicdn.com/363be1dcb8896a5307c0c5149b056929b7e9084618aee-Fcy2rj_fw658")!, completionHandler: { (data, response, error) -> Void in
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.iamgeView.image              = UIImage(data: data!)
                    self.activityIndicatorView.hidden = true
                    self.shouldReload                 = false;
                })
            }).resume()
        }
        
        let time: NSTimeInterval = 1.0
        let delay = dispatch_time(DISPATCH_TIME_NOW,
            Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            self.activityIndicatorView.hidden = true;
            self.shouldReload = true;
        }
        
    }


}

