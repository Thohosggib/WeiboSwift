//
//  DiscoverTableViewController.swift
//  Weibo
//
//  Created by Heaven on 15/6/27.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit

class DiscoverTableViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView?.setupViewInfo("visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过", isHome: false)
        
    }
    
}
