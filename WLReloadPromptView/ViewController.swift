//
//  ViewController.swift
//  WLReloadPromptView
//
//  Created by Wayne on 15/12/24.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var reloadPromptView: WLReloadPromptView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadPromptView = WLReloadPromptView(coveredView: self.view, reloadActions: {
            self.activityIndicatorView.hidden = false;
            self.activityIndicatorView.startAnimating();
            self.view.bringSubviewToFront(self.activityIndicatorView)
            
            NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://img.hb.aicdn.com/363be1dcb8896a5307c0c5149b056929b7e9084618aee-Fcy2rj_fw658")!, completionHandler: { (data, response, error) -> Void in
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.iamgeView.image              = UIImage(data: data!)
                    self.activityIndicatorView.hidden = true
                    self.reloadPromptView.disappear()
                })
            }).resume()
        })
        
        // 模拟网络不畅
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.activityIndicatorView.hidden = true;
            self.reloadPromptView.appear()
        }
    }


}

