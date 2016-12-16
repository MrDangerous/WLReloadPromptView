//
//  ViewController.swift
//  WLReloadPromptView
//
//  Created by Wayne on 15/12/24.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WLReloadPromptViewDelegate, WLReloadPromptViewDataSource {
    
    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var reloadPromptView: WLReloadPromptView!
    
    var shouldReload = true
    
    deinit {
        print("deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadPromptView = WLReloadPromptView.init(viewController: self)
        
        // 模拟网络不畅
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            self.activityIndicatorView.isHidden = true;
            self.reloadPromptView.appear()
        }
    }

    func reloadPromptViewAllowedReload() -> Bool {
        return shouldReload
    }
    
    func image(in promptView: WLReloadPromptView) -> UIImage {
        return #imageLiteral(resourceName: "wifi")
    }
    
    func description(in promptView: WLReloadPromptView) -> NSAttributedString {
        let string = NSAttributedString.init(string: "您的网络环境不太顺畅", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)])
        return string
    }
    
    func button(in promptView: WLReloadPromptView) -> UIControl {
        let button = UIButton.init(type: .system)
        button.setTitle("点击重试", for: .normal)
        button.bounds = CGRect.init(origin: .zero, size: .init(width: 128, height: 34))
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        
        return button
    }
    
    func didTapedReloadButton(in reloadView: WLReloadPromptView) {
        activityIndicatorView.isHidden = false;
        activityIndicatorView.startAnimating();
        view.bringSubview(toFront: self.activityIndicatorView)
        
        shouldReload = false
        URLSession.shared.dataTask(with: URL.init(string: "http://img.hb.aicdn.com/363be1dcb8896a5307c0c5149b056929b7e9084618aee-Fcy2rj_fw658")!, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { 
                self.iamgeView.image = UIImage(data: data!)
                self.activityIndicatorView.isHidden = true
                self.shouldReload = true
                self.reloadPromptView.disappear()
            })
        }).resume()
    }
}

