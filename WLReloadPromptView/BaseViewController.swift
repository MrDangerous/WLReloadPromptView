//
//  BaseViewController.swift
//  WLReloadPromptView
//
//  Created by ByRongInvest on 15/12/24.
//  Copyright © 2015年 ZHWAYNE. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    var reloadPromptView: WLReloadPromptView!
    
    var shouldReload: Bool = false {
        didSet {
            guard self.view != nil else {
                return;
            }
            
            if shouldReload == true {
                reloadPromptView.appear()
            } else {
                reloadPromptView.disappear()
            }
        }
    }
    
    var reloadAction: (() -> Void)? {
        get { return reloadPromptView.reloadActions }
        set { reloadPromptView.reloadActions = newValue }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        reloadPromptView = WLReloadPromptView(coveredView: self.view)
    }
}