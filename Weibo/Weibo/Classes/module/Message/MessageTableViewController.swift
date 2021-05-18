//
//  MessageTableViewController.swift
//  Weibo
//
//  Created by Heaven on 15/6/27.
//  Copyright © 2015年 Heaven. All rights reserved.
//

import UIKit

class MessageTableViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView?.setupViewInfo("visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", isHome: false)
        
    }
    
}