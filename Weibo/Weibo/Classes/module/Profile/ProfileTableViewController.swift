//
//  ProfileTableViewController.swift
//  Weibo
//
//  Created by Heaven on 15/6/27.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView?.setupViewInfo("visitordiscover_image_profile", message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人", isHome: false)
    }
    
}